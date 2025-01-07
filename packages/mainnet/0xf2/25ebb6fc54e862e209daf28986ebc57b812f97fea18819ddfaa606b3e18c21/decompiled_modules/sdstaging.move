module 0xf225ebb6fc54e862e209daf28986ebc57b812f97fea18819ddfaa606b3e18c21::sdstaging {
    struct MyStruct has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    struct Deposit has copy, drop {
        user_address: address,
        deposit_amount: u64,
    }

    struct Withdraw has copy, drop {
        user_address: address,
        amount: u64,
    }

    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        fee_percentage: u64,
    }

    public fun borrow<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::tx_context::TxContext) {
        check_allowed(arg9);
        0x2::balance::join<T0>(&mut arg0.balance, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg1.navi_account));
    }

    public fun check_allowed(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xccbfc425fd39c156ae2138782f65eaaba10c0761bcc142d85999ea6ab975c5cf, 100);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyStruct{
            id           : 0x2::object::new(arg0),
            navi_account : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        };
        0x2::transfer::share_object<MyStruct>(v0);
        let v1 = FeeConfig{
            id             : 0x2::object::new(arg0),
            fee_percentage : 25,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public fun repay<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_allowed(arg9);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg7), arg9), arg8, &arg1.navi_account)
    }

    public fun set_fee_percentage(arg0: &mut FeeConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_allowed(arg2);
        assert!(arg1 <= 10000, 10000);
        arg0.fee_percentage = arg1;
    }

    public fun userDeposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &FeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000 / arg2.fee_percentage, 0);
        let v1 = v0 * arg2.fee_percentage / 10000;
        let v2 = Deposit{
            user_address   : 0x2::tx_context::sender(arg3),
            deposit_amount : v0 - v1,
        };
        0x2::event::emit<Deposit>(v2);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg3)));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun userWithdraw<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), arg1);
        let v0 = Withdraw{
            user_address : 0x2::tx_context::sender(arg3),
            amount       : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), @0xccbfc425fd39c156ae2138782f65eaaba10c0761bcc142d85999ea6ab975c5cf);
    }

    public fun withdrawFees<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_balance, arg1), arg2), @0xccbfc425fd39c156ae2138782f65eaaba10c0761bcc142d85999ea6ab975c5cf);
    }

    public fun withdrawNavi<T0>(arg0: &mut Treasury<T0>, arg1: &MyStruct, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::tx_context::TxContext) {
        check_allowed(arg10);
        0x2::balance::join<T0>(&mut arg0.balance, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &arg1.navi_account));
    }

    // decompiled from Move bytecode v6
}

