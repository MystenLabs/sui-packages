module 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::pool {
    struct DepositEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        base_amount_deposited: u64,
        quote_amount_deposited: u64,
        base_share_minted: u64,
        quote_share_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        base_share_burned: u64,
        quote_share_burned: u64,
        base_amount_withdrawn: u64,
        quote_amount_withdrawn: u64,
    }

    struct UserCapital has store {
        base_share: u64,
        quote_share: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        base_price_id: 0x2::object::ID,
        quote_price_id: 0x2::object::ID,
        base_price_object: 0x2::object::ID,
        quote_price_object: 0x2::object::ID,
        base_decimals: u8,
        quote_decimals: u8,
        base_price: u64,
        quote_price: u64,
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
        base_balance_value: u64,
        quote_balance_value: u64,
        base_target: u64,
        quote_target: u64,
        k: u64,
        fee_rate: u64,
        user_capital: 0x2::table::Table<address, UserCapital>,
        base_supply: u64,
        quote_supply: u64,
    }

    public(friend) fun contribute_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.base_target = arg0.base_target + v0;
        arg0.base_balance_value = arg0.base_balance_value + v0;
        0x2::balance::join<T0>(&mut arg0.base_balance, arg1);
        let v1 = 0x2::balance::value<T1>(&arg2);
        arg0.quote_target = arg0.quote_target + v1;
        arg0.quote_balance_value = arg0.quote_balance_value + v1;
        0x2::balance::join<T1>(&mut arg0.quote_balance, arg2);
    }

    public fun create_pool<T0, T1>(arg0: &0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::admin::AdminCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0 && arg7 <= 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::constants::get_k_scale(), 4);
        assert!(arg8 <= 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::constants::get_fee_dominator() / 10, 5);
        let v0 = Pool<T0, T1>{
            id                  : 0x2::object::new(arg10),
            base_price_id       : arg1,
            quote_price_id      : arg2,
            base_price_object   : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5),
            quote_price_object  : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg6),
            base_decimals       : arg3,
            quote_decimals      : arg4,
            base_price          : 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::oracle::get_price(arg9, &arg1, arg5),
            quote_price         : 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::oracle::get_price(arg9, &arg2, arg6),
            base_balance        : 0x2::balance::zero<T0>(),
            quote_balance       : 0x2::balance::zero<T1>(),
            base_balance_value  : 0,
            quote_balance_value : 0,
            base_target         : 0,
            quote_target        : 0,
            k                   : arg7,
            fee_rate            : arg8,
            user_capital        : 0x2::table::new<address, UserCapital>(arg10),
            base_supply         : 0,
            quote_supply        : 0,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun deposit<T0, T1>(arg0: &0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        update_prices_and_target<T0, T1>(arg1, arg2, arg3, arg4);
        let v0 = 0x2::balance::value<T0>(&arg5);
        let v1 = 0x2::balance::value<T1>(&arg6);
        let v2 = arg1.base_target;
        let v3 = if (arg1.base_supply == 0) {
            assert!(v0 >= 1000000, 3);
            v0 + v2
        } else {
            v0 * arg1.base_supply / v2
        };
        arg1.base_balance_value = arg1.base_balance_value + v0;
        0x2::balance::join<T0>(&mut arg1.base_balance, arg5);
        arg1.base_target = v2 + v0;
        arg1.base_supply = arg1.base_supply + v3;
        let v4 = arg1.quote_target;
        let v5 = if (arg1.quote_supply == 0) {
            assert!(v1 >= 1000000, 3);
            v1 + v4
        } else {
            v1 * arg1.quote_supply / v4
        };
        arg1.quote_balance_value = arg1.quote_balance_value + v1;
        0x2::balance::join<T1>(&mut arg1.quote_balance, arg6);
        arg1.quote_target = v4 + v1;
        arg1.quote_supply = arg1.quote_supply + v5;
        let v6 = 0x2::tx_context::sender(arg7);
        if (0x2::table::contains<address, UserCapital>(&arg1.user_capital, v6)) {
            let v7 = 0x2::table::borrow_mut<address, UserCapital>(&mut arg1.user_capital, v6);
            v7.base_share = v7.base_share + v3;
            v7.quote_share = v7.quote_share + v5;
        } else {
            let v8 = UserCapital{
                base_share  : v3,
                quote_share : v5,
            };
            0x2::table::add<address, UserCapital>(&mut arg1.user_capital, v6, v8);
        };
        let v9 = DepositEvent{
            sender                 : v6,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg1),
            base_amount_deposited  : v0,
            quote_amount_deposited : v1,
            base_share_minted      : v3,
            quote_share_minted     : v5,
        };
        0x2::event::emit<DepositEvent>(v9);
        (v3, v5)
    }

    public(friend) fun flash_buy_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0x2::balance::Balance<T0> {
        update_prices_and_target<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::formula::compute_base_out(get_mid_price<T0, T1>(arg0), arg0.k, arg0.base_target, arg0.base_balance_value, arg1);
        arg0.quote_balance_value = arg0.quote_balance_value + arg1;
        arg0.base_balance_value = arg0.base_balance_value - v0;
        0x2::balance::split<T0>(&mut arg0.base_balance, v0)
    }

    public(friend) fun flash_sell_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0x2::balance::Balance<T1> {
        update_prices_and_target<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::formula::compute_quote_out(get_mid_price<T0, T1>(arg0), arg0.k, arg0.quote_target, arg0.quote_balance_value, arg1);
        arg0.quote_balance_value = arg0.quote_balance_value - v0;
        arg0.base_balance_value = arg0.base_balance_value + arg1;
        0x2::balance::split<T1>(&mut arg0.quote_balance, v0)
    }

    public(friend) fun get_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    fun get_mid_price<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (((arg0.base_price as u128) * (0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::constants::get_price_precision() as u128) * (0x1::u64::pow(10, arg0.quote_decimals) as u128) / (arg0.quote_price as u128) / (0x1::u64::pow(10, arg0.base_decimals) as u128)) as u64)
    }

    public fun get_user_position<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, UserCapital>(&arg0.user_capital, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, UserCapital>(&arg0.user_capital, arg1);
        (v0.base_share, v0.quote_share)
    }

    public(friend) fun repay_reserve<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.base_balance, arg1);
        0x2::balance::join<T1>(&mut arg0.quote_balance, arg2);
    }

    public(friend) fun update_prices_and_target<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::oracle::get_price(arg1, &arg0.base_price_id, arg2);
        let v1 = 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::oracle::get_price(arg1, &arg0.quote_price_id, arg3);
        arg0.base_target = arg0.base_target * arg0.base_price / v0;
        arg0.quote_target = arg0.quote_target * arg0.quote_price / v1;
        arg0.base_price = v0;
        arg0.quote_price = v1;
    }

    public fun withdraw<T0, T1>(arg0: &0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::tx_context::sender(arg7);
        update_prices_and_target<T0, T1>(arg1, arg2, arg3, arg4);
        let v1 = 0x2::table::borrow_mut<address, UserCapital>(&mut arg1.user_capital, v0);
        assert!(v1.base_share >= arg5, 1);
        v1.base_share = v1.base_share - arg5;
        let v2 = arg1.base_supply;
        arg1.base_supply = v2 - arg5;
        let v3 = arg5 * arg1.base_target / v2;
        let v4 = v3 - 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::formula::compute_withdraw_penalty(0x2::balance::value<T0>(&arg1.base_balance), arg1.base_target, v3);
        arg1.base_target = arg1.base_target - v4;
        arg1.base_balance_value = arg1.base_balance_value - v4;
        let v5 = 0x2::balance::split<T0>(&mut arg1.base_balance, v4);
        assert!(v1.quote_share >= arg6, 2);
        v1.quote_share = v1.quote_share - arg6;
        let v6 = arg1.quote_supply;
        arg1.quote_supply = v6 - arg6;
        let v7 = arg6 * arg1.quote_target / v6;
        let v8 = v7 - 0xc74185bfcaa4cf073ce44cadaa4683e1d78462002f69d2feb3dbedc5a1c5f669::formula::compute_withdraw_penalty(0x2::balance::value<T1>(&arg1.quote_balance), arg1.quote_target, v7);
        arg1.quote_target = arg1.quote_target - v8;
        arg1.quote_balance_value = arg1.quote_balance_value - v8;
        let v9 = 0x2::balance::split<T1>(&mut arg1.quote_balance, v8);
        let v10 = WithdrawEvent{
            sender                 : v0,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg1),
            base_share_burned      : arg5,
            quote_share_burned     : arg6,
            base_amount_withdrawn  : 0x2::balance::value<T0>(&v5),
            quote_amount_withdrawn : 0x2::balance::value<T1>(&v9),
        };
        0x2::event::emit<WithdrawEvent>(v10);
        (v5, v9)
    }

    // decompiled from Move bytecode v6
}

