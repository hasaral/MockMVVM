//
//  MockMVVMTests.swift
//  MockMVVMTests
//
//  Created by Hasan Saral on 20.06.2023.
//

import XCTest
@testable import MockMVVM

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var view: MockHomeViewContoller!
    private var storeManager: MockAnimalStoreManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        storeManager = .init()
        viewModel = .init(view: view, storeManager: storeManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        storeManager = nil
        viewModel = nil
        
    }
    
    func test_detailType_ReturnsAries() {
        XCTAssertEqual(viewModel.detailType, .aries)
    }
    
    func test_detailType_SecondItemSelected_ReturnsBull() {
        viewModel.didSelectItem(at: .init(item: 1, section: 0))
        
        XCTAssertEqual(viewModel.detailType, .bull)
    }
    
    func test_viewDidload_InvokesRequiredMethods() {
        //XCTAssertEqual(view.invokePrepareCollectionViewCount, 0)
        //XCTAssertEqual(view.invokedBeginRefreshingCount, 0)
        //given
        XCTAssertFalse(view.invokePrepareCollectionView)
        XCTAssertFalse(view.invokedBeginRefreshing)
        XCTAssertFalse(storeManager.invokedFetchAnimals)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedReloadData)

        
        //when
        viewModel.viewDidload()
        
        //then
        
        XCTAssertEqual(view.invokePrepareCollectionViewCount, 1)
        XCTAssertEqual(view.invokedBeginRefreshingCount, 1)
        XCTAssertEqual(storeManager.invokeFetchAnimalCount, 1)
        XCTAssertEqual(view.invokedEndRefreshingCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)

    }
    
    func test_viewWillAppear_InvokesPrepareRefreshControl() {
        XCTAssertTrue(view.invokedPrepareRefreshControlParametersList.isEmpty)
        
        viewModel.viewWillAppear()
        
        XCTAssertEqual(view.invokedPrepareRefreshControlParametersList.map(\.tintColor), ["FF9060"])
    }
    
    func test_didSelectItem_WithFirstIndex_PerformSeque() {
        
        XCTAssertTrue(view.invokedPerformSegueParametersList.isEmpty)
        
        viewModel.didSelectItem(at: .init(item: 0, section: 0))
        
        XCTAssertEqual(view.invokedPerformSegueParametersList.map(\.identifier), ["detailVC"])
    }
    
    func test_didSelectItem_WithSecondIndex_PerformSeque() {
        
        XCTAssertTrue(view.invokedPerformSegueParametersList.isEmpty)
        
        viewModel.didSelectItem(at: .init(item: 1, section: 0))
        
        XCTAssertEqual(view.invokedPerformSegueParametersList.map(\.identifier), ["detailVC"])
    }
    
    func test_didSelectItem_WithThirdIndex_PerformSeque() {
        
        XCTAssertTrue(view.invokedPerformSegueParametersList.isEmpty)
        
        viewModel.didSelectItem(at: .init(item: 2, section: 0))
        
        XCTAssertEqual(view.invokedPerformSegueParametersList.map(\.identifier), ["reportsVC"])
    }
    
    func test_didSelectItem_With_Index_PerformSeque() {
        
        XCTAssertTrue(view.invokedPerformSegueParametersList.isEmpty)
        
        (0...100).forEach { item in
            viewModel.didSelectItem(at: .init(item: item, section: 0))
        }
        
        let result = view.invokedPerformSegueParametersList.filter { $0.identifier == "reportsVC"
            
            //XCTAssertEqual(view.invokedPerformSegueParametersList.map(\.identifier), res)
        }
        
        //XCTAssertEqual(view.invokedPerformSegueParametersList.map(\.identifier), ["reportsVC"])
    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
