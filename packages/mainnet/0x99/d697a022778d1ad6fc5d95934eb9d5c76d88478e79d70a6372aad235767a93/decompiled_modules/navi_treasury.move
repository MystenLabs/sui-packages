module 0x99d697a022778d1ad6fc5d95934eb9d5c76d88478e79d70a6372aad235767a93::navi_treasury {
    struct MyStruct has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct SuiTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<T0>,
    }

    public fun depositNavi<T0>(arg0: &mut SuiTreasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg6), arg9), arg7, arg8, &arg1.navi_account);
    }

    public fun depositSUI<T0>(arg0: &mut SuiTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509, 100);
        0x2::balance::join<T0>(&mut arg0.sui_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun testSuiObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509, 100);
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

    public fun withdrawNavi<T0>(arg0: &MyStruct, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg9) == @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509, 100);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg0.navi_account)
    }

    public fun withdrawSUI<T0>(arg0: &mut SuiTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg1), arg2), @0xc9e26910f7a4df1c70a00b16d7248d50921b22b7a388e73d708c399554050509);
    }

    // decompiled from Move bytecode v6
}

