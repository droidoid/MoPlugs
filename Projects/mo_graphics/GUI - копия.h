
#pragma once

//--- SDK include
#include <fbsdk/fbsdk.h>

#include <GL\glew.h>

// STL
#include <vector>

////////////////////////////
// FORWARD DECLARATION

class CGUIWidgetModel;
class CGUIWidgetView;

//////////////////////////////////////////////////
//
class CGUIComponent
{
public:
	//! a constructor
	CGUIComponent();

	// creation input parameters
	struct Region
	{
		double	x;
		double	y;
		double	w;
		double	h;
	} mRegion;

	// calculated world position
	struct Position
	{
		double x;
		double y;
		double w;
		double h;
	} mPosition;


	bool		mSelected;
	bool		mFocused;


	virtual void Set(const double x, const double y, const double width, const double height)
	{
		mRegion.x = x;
		mRegion.y = y;
		mRegion.w = width;
		mRegion.h = height;

		mPosition.x = 0.0;
		mPosition.y = 0.0;
		mPosition.w = 1.0;
		mPosition.h = 1.0;

		mSelected = false;
		mFocused = false;
	}

	const double GetRegionX() const { return mRegion.x; }
	const double GetRegionY() const { return mRegion.y; }
	const double GetRegionW() const { return mRegion.w; }
	const double GetRegionH() const { return mRegion.h; }

	virtual void SetPosition(const double x, const double y, const double width, const double height)
	{
		mPosition.x = x;
		mPosition.y = y;
		mPosition.w = width;
		mPosition.h = height;
	}

	const bool IsInside(const double x, const double y)
	{
		return (x > mPosition.x && y > mPosition.y 
			&& x < (mPosition.x+mPosition.w) && y < (mPosition.y+mPosition.h) );
	}

	const bool Select(const double x, const double y)
	{
		mSelected = IsInside(x, y);
		return mSelected;
	}
};

//////////////////////////////////////////////////////////////////////////////
//

struct CGUIWidgetOptions
{
	struct
	{
		double					element;	// size of the element in world coords
		double					space;		// spacing between the elements
	} size;
};

// layouts - way to calculate item position

class CGUILayout
{
public:
	//! a constructor
	CGUILayout();

	virtual void Calculate(const int w, const int h, const int numberOfComponents, CGUIComponent *comps, const CGUIWidgetOptions &options);	// calculate real world position of an item
};

class CGUILayoutHGrid : public CGUILayout
{
public:
	//! a constructor
	CGUILayoutHGrid();

	virtual void Calculate(const int w, const int h, const int numberOfComponents, CGUIComponent *comps, const CGUIWidgetOptions &options);
};

//////////////////////////////////////////////////////////////////////////////
// an idea, that we could specify order of components (sort by date, name, etc.)

class CGUIWidgetModel : public CGUIComponent
{
public:

	//! a constructor
	CGUIWidgetModel();

	//! a destructor
	virtual ~CGUIWidgetModel();

	void Free();

	// function for recalculation dimensions and world positions of the elements
	void ReSize(const int w, const int h);
	
	// process data according the user input
	void Input(const int pMouseX, const int pMouseY, FBInputType pAction, const int pButtonKey, const int pModifier);


	//
	void ConnectToView( CGUIWidgetView *pView );

	// some logic information
	const int GetNumberOfComponents() const;
	const int GetNumberOfRows() const;
	const int GetNumberOfCols() const;

	const double GetElementSize() const;
	const double GetSpaceSize() const;

	CGUIComponent *GetComponentPtr(const int index);

protected:

	int									mNumberOfComponents;
	int									mNumberOfRows;
	int									mNumberOfCols;
	std::unique_ptr<CGUIComponent[]>	mComponents;
	std::auto_ptr<CGUILayout>			mComponentsLayout;

	CGUIWidgetView		*mView;

	friend class CGUIWidgetView;

	// user input logic

	CGUIWidgetOptions	mOptions;

	int			mWidth;
	int			mHeight;

	double		mPan;

	bool		mMouseDown;
	bool		mMouseMotion;
	int			mMouseLastX;
	int			mMouseLastY;

	bool		mNeedUpdate;

	// different behaviour depends on a layout class
	void CalculatePosition(const int *w, const int *h);
	void SelectUnderCursor( const int pMouseX, const int pMouseY, const int pButtonKey, const int pModifier );

	void DisconnectView();

protected:

	// override for adding some logic elements to a widget
	
	virtual CGUILayout *CreateLayout()
	{
		return new CGUILayout();
	}
	
	virtual void OnFree();
	virtual void OnReSize(const int w, const int h);
	virtual void OnMouseDown(const int pMouseX, const int pMouseY, const int pButtonKey);
	virtual void OnMouseMotion(const int pMouseX, const int pMouseY, const int pButtonKey);
	virtual void OnMouseUp(const int pMouseX, const int pMouseY, const int pButtonKey, const bool hasMotion);

};

////////////////////////////////////////////////////////////////////////////////////////////
//
class CGUIWidgetView
{
public:

	//! a constructor
	CGUIWidgetView(CGUIWidgetModel *pModel);

	//!< a destructor
	virtual ~CGUIWidgetView();

	void Free();

	//
	void ConnectToModel( CGUIWidgetModel *pModel );

	void Render();

protected:
	
	

	void DisconnectModel();

protected:

	virtual void OnUpdate();
	virtual void OnRender();

	virtual void OnFree();
	virtual void OnReSize(const int w, const int h);
	virtual void OnMouseDown(const int pMouseX, const int pMouseY, const int pButtonKey);
	virtual void OnMouseMotion(const int pMouseX, const int pMouseY, const int pButtonKey);
	virtual void OnMouseUp(const int pMouseX, const int pMouseY, const int pButtonKey, const bool hasMotion);

private:
	bool				_mNeedUpdate;
	CGUIWidgetModel		*_mModel;

	friend class CGUIWidgetModel;
};


/////////////////////////////////////////////////////////////////////////////////////////////
//
class CGUIWidget
{
public:
	//! a constructor
	CGUIWidget();

protected:

	CGUIWidgetModel		*mModel;
	CGUIWidgetView		*mView;

	FBArrayTemplate<CGUIComponent*>		mComponents;

};

