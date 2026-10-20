module 0x512982f9e14bbe6ac52be6e66a8f5068e0af0fb66870baa29a929c1ff19e4ed0::market {
    struct MarketVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        pool_id: 0x2::object::ID,
        deep: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        quote_fees: 0x2::balance::Balance<T1>,
        max_input: u64,
        max_deep_per_trade: u64,
        max_total_deep_spend: u64,
        total_deep_spent: u64,
        paused: bool,
    }

    struct TradeFee has copy, drop {
        trader: address,
        is_buy: bool,
        quote_traded: u64,
        quote_fee: u64,
        taker_fee_rate: u64,
        deep_spent: u64,
    }

    public fun add_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun buy<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0 && arg3 > 0, 4);
        check<T0, T1>(arg0, arg1, arg3, arg5);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v3 = fee_for(arg3, v0);
        assert!(v3 <= arg4 && (0x2::coin::value<T1>(&arg2) as u128) >= (arg3 as u128) + (v3 as u128), 6);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::split<T1>(&mut arg2, arg3, arg8), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg5), arg8), arg6, arg7, arg8);
        let v7 = v5;
        let v8 = arg3 - 0x2::coin::value<T1>(&v7);
        let v9 = fee_for(v8, v0);
        assert!(v9 <= arg4 && v9 <= 0x2::coin::value<T1>(&arg2), 6);
        0x2::balance::join<T1>(&mut arg0.quote_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v9, arg8)));
        0x2::coin::join<T1>(&mut arg2, v7);
        let v10 = TradeFee{
            trader         : 0x2::tx_context::sender(arg8),
            is_buy         : true,
            quote_traded   : v8,
            quote_fee      : v9,
            taker_fee_rate : v0,
            deep_spent     : settle_deep<T0, T1>(arg0, arg5, v6),
        };
        0x2::event::emit<TradeFee>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg8));
    }

    fun check<T0, T1>(arg0: &MarketVault<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64) {
        assert!(!arg0.paused, 2);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 3);
        assert!(arg2 > 0 && arg2 <= arg0.max_input, 4);
        let v0 = if (arg3 > 0) {
            if (arg3 <= arg0.max_deep_per_trade) {
                arg3 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
    }

    public fun create<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(arg3 <= arg4 && arg4 <= 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1), 5);
        let v1 = MarketVault<T0, T1>{
            id                   : 0x2::object::new(arg5),
            admin                : 0x2::tx_context::sender(arg5),
            pool_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            deep                 : 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1),
            quote_fees           : 0x2::balance::zero<T1>(),
            max_input            : arg2,
            max_deep_per_trade   : arg3,
            max_total_deep_spend : arg4,
            total_deep_spent     : 0,
            paused               : true,
        };
        0x2::transfer::share_object<MarketVault<T0, T1>>(v1);
    }

    fun fee_for(arg0: u64, arg1: u64) : u64 {
        assert!((arg1 as u128) <= 1000000000, 6);
        ((((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000) as u64)
    }

    public fun raise_deep_cap<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.paused, 2);
        assert!(arg1 >= arg0.max_total_deep_spend, 5);
        assert!(arg1 <= arg0.total_deep_spent + 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep), 5);
        arg0.max_total_deep_spend = arg1;
    }

    public fun sell<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 4);
        check<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2), arg4);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg4), arg7), arg5, arg6, arg7);
        let v6 = v4;
        let v7 = 0x2::coin::value<T1>(&v6);
        let v8 = fee_for(v7, v0);
        assert!(v8 <= arg3 && v7 - v8 >= arg5, 7);
        0x2::balance::join<T1>(&mut arg0.quote_fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, v8, arg7)));
        let v9 = TradeFee{
            trader         : 0x2::tx_context::sender(arg7),
            is_buy         : false,
            quote_traded   : v7,
            quote_fee      : v8,
            taker_fee_rate : v0,
            deep_spent     : settle_deep<T0, T1>(arg0, arg4, v5),
        };
        0x2::event::emit<TradeFee>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg7));
    }

    public fun set_paused<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
    }

    fun settle_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) : u64 {
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg2);
        assert!(v0 <= arg1, 5);
        let v1 = arg1 - v0;
        assert!(arg0.total_deep_spent + v1 <= arg0.max_total_deep_spend, 5);
        arg0.total_deep_spent = arg0.total_deep_spent + v1;
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
        v1
    }

    public fun withdraw_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.paused, 2);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg1), arg2), arg0.admin);
    }

    public fun withdraw_quote_fees<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T1>(&arg0.quote_fees), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_fees, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v7
}

