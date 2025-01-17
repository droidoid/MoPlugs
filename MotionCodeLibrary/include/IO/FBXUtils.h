
#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////
//
// file: FBXUtils.h
//
//	Author Sergey Solokhin (Neill3d)
//
//
//	GitHub page - https://github.com/Neill3d/MoPlugs_Framework
//	Licensed under BSD 3-Clause - https://github.com/Neill3d/MoPlugs_Framework/blob/master/LICENSE
//
///////////////////////////////////////////////////////////////////////////////////////////////////

#include	<vector>
#include	<set>
#include	<algorithm>

//#include <fbxsdk.h>

#define STRING_MAX_LENGTH		128

struct Float4 { float x[4]; };
struct Float2 { float x[2]; };


struct InputModelData
{
	std::vector<Float4>		positions;

	int						materialMapping;
	std::vector<int>		materialIndices;

	//
	//

	struct PolyInfo
	{
		int		materialId;
		int		vertexCount;
		int		*indices;

		PolyInfo()
		{
			materialId = 0;
			vertexCount = 0;
			indices = nullptr;
		}
		void Free()
		{
			if (indices != nullptr)
			{
				delete [] indices;
				indices = nullptr;
			}
		}

		size_t		ComputeTotalSize();
		size_t		CopyToMemory(void *memory);
		size_t		InitFromMemory(void *memory);
	};

	std::vector<PolyInfo>	polyInfo;

	//
	//

	int						normalMapping;
	int						normalReferenceMode;

	std::vector<Float4>		normalsDirect;
	std::vector<int>		normalIndices;

	double					LclPosition[3];
	double					LclRotation[3];
	double					LclScaling[3];

	// only 1 uvset supported

	char				uvSetName[STRING_MAX_LENGTH];

	int						uvSetMapping;
	int						uvSetReferenceMode;

	std::vector<Float2>		uvs;
	std::vector<int>		uvIndices;

	// properties for snapshot
	char				baseModelName[STRING_MAX_LENGTH];
	double					snapshotTime;

	// skin and clusters

	struct DeformedVertex
	{
		int			index;
		float		weight;

		//! a constructor
		DeformedVertex()
		{
			index = 0;
			weight = 0.0f;
		}
		DeformedVertex(const int _index, const float _weight)
			: index(_index)
			, weight(_weight)
		{}

		size_t		ComputeTotalSize();
		size_t		CopyToMemory(void *memory);
		size_t		InitFromMemory(void *memory);

	};

	struct Cluster
	{
		char		name[STRING_MAX_LENGTH];

		int			parent;		// -1 means no parent

		char		modelname[STRING_MAX_LENGTH];

		// current pose
		double		LclPosition[3];
		double		LclRotation[3];
		double		LclScaling[3];

		// link matrix
		double		LinkPosition[3];
		double		LinkRotation[3];
		double		LinkScaling[3];

		int			mode;		// link mode ( total one, normalized, additive )

		std::vector<DeformedVertex>		vertices;

		//! a constructor
		Cluster()
		{
		}

		~Cluster()
		{
			Free();
		}

		void Free()
		{
		}

		bool operator <( const Cluster &other ) const
		{
			return (strcmp(name, other.name) < 0);
		}
		bool operator ==(const Cluster &other ) const
		{
			return (strcmp(name, other.name) == 0);
		}

		size_t		ComputeTotalSize();
		size_t		CopyToMemory(void *memory);
		size_t		InitFromMemory(void *memory);
	};

	// rlbond's magic comparator
	struct ClusterLessThan : public std::binary_function<Cluster, Cluster, bool> {
		bool operator()(const Cluster* lhs, const Cluster* rhs) const
		{
			return !(strcmp(lhs->modelname, rhs->modelname)==0) && (strcmp(lhs->modelname, rhs->modelname) < 0);
		}
	};

	std::set<Cluster*, ClusterLessThan>		clusters;


	//! a constructor
	InputModelData()
	{
		memset( uvSetName, 0, sizeof(char) * 128 );
		//uvSetName = nullptr;
		memset( baseModelName, 0, sizeof(char) * 128 );
		//baseModelName = nullptr;
	}
	//! a destructor
	~InputModelData()
	{
		std::for_each( polyInfo.begin(), polyInfo.end(), [] (PolyInfo &info) {
			info.Free();
		} );
		
		std::for_each( clusters.begin(), clusters.end(), [] (Cluster *cluster) {
			delete cluster;
		} );
		
	}

	void SetUVSetName( const char *name )
	{
		memset( uvSetName, 0, sizeof(char) * 128 );
		sprintf_s( uvSetName, sizeof(char)*128, "%s", name );
	}

	void SetBaseModelName( const char *name )
	{
		memset( baseModelName, 0, sizeof(char) * 128 );
		sprintf_s( baseModelName, sizeof(char)*128, "%s", name );
	}

	size_t	ComputeTotalSize();

	void	CopyToMemory(void *memory);
	void	InitFromMemory(void *memory);
};


/*
	MakeSnapshotFBX

	FBX SDK has much more flexibility and functionality for working with a model geometry
	 and it helps to make correct snapshot (with all needed uv coords and uv sets - thats what is missing in OR SDK)

	\param filename read-only - full filename to save fbx snapshot model to
	\param uniqueName read-only - export and merge model with some unique name to avoid overriding existing scene objects
	\param data		read-only - full needed information about model geometry
	\param ResetXForm read-only - do we need to bake transformation into vertex position or leave as it is

	\return operation status (success or not)
*/
bool MakeSnapshotFBX(const char *filename, const char *uniqueName, InputModelData &data, const bool ResetXForm);


/*
	CombineMeshesFBX

	this function make a one model from several MoBu models using extracted InputModelData information.
	This helps to optimaze number of draw calls and make one mesh for correction shapes
	The main feature of this function is TextureAtlas. The main idea is to combine all meshes materials and textures
	into one material with atlas textures. This also should reduce number of calls and increase performance.

	This operation doesn't support BlendShapes.

	\return operation status (success or not)
*/
//bool CombineMeshesFBX(const char *filename, const InputModelData *data, const bool CombineClusters, const bool TextureAtlas);