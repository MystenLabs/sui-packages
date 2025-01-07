module 0x5f0aa8b9db8806ce595126398525b9bbd2d514a54e0346280fcd7fe60e984606::fairmile_navi {
    struct MyStruct has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct SuiTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<T0>,
    }

    struct UsdcTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    struct WethTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        weth_amount: 0x2::balance::Balance<T0>,
    }

    public fun borrow<T0>(arg0: &MyStruct, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg8) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_account)
    }

    public fun claimRewards<T0>(arg0: &MyStruct, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg7) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &arg0.navi_account)
    }

    public fun depositSUI<T0>(arg0: &mut SuiTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::balance::join<T0>(&mut arg0.sui_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun depositSuiNavi<T0>(arg0: &mut SuiTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg6), arg9), arg7, arg8, &arg1.navi_account);
    }

    public fun depositUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun depositUsdcNavi<T0>(arg0: &mut UsdcTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg6), arg9), arg7, arg8, &arg1.navi_account);
    }

    public fun depositWETH<T0>(arg0: &mut WethTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::balance::join<T0>(&mut arg0.weth_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun depositWethNavi<T0>(arg0: &mut WethTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.weth_amount, arg6), arg9), arg7, arg8, &arg1.navi_account);
    }

    public fun initializeSuiObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        let v0 = SuiTreasury<T0>{
            id         : 0x2::object::new(arg0),
            sui_amount : 0x2::balance::zero<T0>(),
        };
        let v1 = MyStruct{
            id           : 0x2::object::new(arg0),
            navi_account : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        };
        0x2::transfer::share_object<MyStruct>(v1);
        0x2::transfer::share_object<SuiTreasury<T0>>(v0);
    }

    public fun initializeUsdcObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        let v0 = UsdcTreasury<T0>{
            id          : 0x2::object::new(arg0),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<UsdcTreasury<T0>>(v0);
    }

    public fun initializeWethObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        let v0 = WethTreasury<T0>{
            id          : 0x2::object::new(arg0),
            weth_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<WethTreasury<T0>>(v0);
    }

    public fun repaySUI<T0>(arg0: &mut SuiTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg7), arg9), arg8, &arg1.navi_account)
    }

    public fun repayUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg7), arg9), arg8, &arg1.navi_account)
    }

    public fun repayWETH<T0>(arg0: &mut WethTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.weth_amount, arg7), arg9), arg8, &arg1.navi_account)
    }

    public fun withdrawNavi<T0>(arg0: &MyStruct, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg9) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg0.navi_account)
    }

    public fun withdrawSUI<T0>(arg0: &mut SuiTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawWETH<T0>(arg0: &mut WethTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.weth_amount, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    // decompiled from Move bytecode v6
}

