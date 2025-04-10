module 0x8d8e6ea750136f388f53ef3e9755ef0d66a0bf4312ce8cd4518d658674898376::suidollar {
    struct MyStruct has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    public fun borrowSUI<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::tx_context::TxContext) {
        check_allowed(arg9);
        0x2::balance::join<T0>(&mut arg0.balance, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg1.navi_account));
    }

    public fun check_allowed(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
    }

    public fun claimRewards<T0>(arg0: &MyStruct, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_allowed(arg7);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &arg0.navi_account)
    }

    public fun create_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg0);
        let v0 = Treasury<T0>{
            id          : 0x2::object::new(arg0),
            balance     : 0x2::balance::zero<T0>(),
            fee_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun depositNavi<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg9);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg6), arg9), arg7, arg8, &arg1.navi_account);
    }

    public fun repayWETH<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_allowed(arg9);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg7), arg9), arg8, &arg1.navi_account)
    }

    public fun userDeposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0 * 25 / 10000;
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg2)));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        v0 - v1
    }

    public fun userWithdraw<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), arg1);
    }

    public fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawFees<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_balance, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawNavi<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::tx_context::TxContext) {
        check_allowed(arg10);
        0x2::balance::join<T0>(&mut arg0.balance, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &arg1.navi_account));
    }

    // decompiled from Move bytecode v6
}

