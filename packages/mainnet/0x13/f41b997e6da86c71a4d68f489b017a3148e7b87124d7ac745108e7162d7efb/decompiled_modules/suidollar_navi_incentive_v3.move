module 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar_navi_incentive_v3 {
    public fun borrow<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::tx_context::TxContext) {
        0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::check_allowed(arg10);
        assert!(arg7 > 0, 3002);
        0x2::balance::join<T0>(0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0)));
    }

    public fun claimRewards<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: vector<0x1::ascii::String>, arg6: vector<address>, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::check_allowed(arg7);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg5) > 0, 3003);
        assert!(0x1::vector::length<address>(&arg6) > 0, 3003);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0))
    }

    public fun depositNavi<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::check_allowed(arg9);
        assert!(arg6 > 0, 3002);
        let v0 = 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(v0) >= arg6, 3001);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg6), arg9), arg7, arg8, 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0));
    }

    public fun repay<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::check_allowed(arg10);
        assert!(arg7 > 0, 3002);
        let v0 = 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(v0) >= arg7, 3001);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg7), arg10), arg8, arg9, 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0))
    }

    public fun withdrawNavi<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::tx_context::TxContext) {
        0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::check_allowed(arg10);
        assert!(arg7 > 0, 3002);
        0x2::balance::join<T0>(0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0)));
    }

    // decompiled from Move bytecode v6
}

