module 0x5bbb73628be53511f483e22da32b3eadbac21cdf3d842dcceb51b2d3b7a27008::market {
    struct MarketVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        pool_id: 0x2::object::ID,
        deep: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        allowed: 0x2::vec_set::VecSet<address>,
        max_input: u64,
        max_deep_per_trade: u64,
        max_total_deep_spend: u64,
        total_deep_spent: u64,
        paused: bool,
    }

    public fun add_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun buy<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 5);
        check<T0, T1>(arg0, arg1, 0x2::coin::value<T1>(&arg2), arg3, arg6);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg3), arg6), arg4, arg5, arg6);
        settle_deep<T0, T1>(arg0, arg3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
    }

    fun check<T0, T1>(arg0: &MarketVault<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.allowed, &v0), 2);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 4);
        assert!(arg2 > 0 && arg2 <= arg0.max_input, 5);
        let v1 = if (arg3 > 0) {
            if (arg3 <= arg0.max_deep_per_trade) {
                arg3 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
    }

    public fun create<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(arg4 <= arg5 && arg5 <= 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1), 6);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, arg2);
        let v2 = MarketVault<T0, T1>{
            id                   : 0x2::object::new(arg6),
            admin                : 0x2::tx_context::sender(arg6),
            pool_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            deep                 : 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1),
            allowed              : v1,
            max_input            : arg3,
            max_deep_per_trade   : arg4,
            max_total_deep_spend : arg5,
            total_deep_spent     : 0,
            paused               : true,
        };
        0x2::transfer::share_object<MarketVault<T0, T1>>(v2);
    }

    public fun sell<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 5);
        check<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2), arg3, arg6);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg3), arg6), arg4, arg5, arg6);
        settle_deep<T0, T1>(arg0, arg3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun set_paused<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
    }

    public fun set_tester<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        if (arg2) {
            if (!0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
                0x2::vec_set::insert<address>(&mut arg0.allowed, arg1);
            };
        } else if (0x2::vec_set::contains<address>(&arg0.allowed, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.allowed, &arg1);
        };
    }

    fun settle_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg2);
        assert!(v0 <= arg1, 6);
        let v1 = arg1 - v0;
        assert!(arg0.total_deep_spent + v1 <= arg0.max_total_deep_spend, 6);
        arg0.total_deep_spent = arg0.total_deep_spent + v1;
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    public fun withdraw_deep<T0, T1>(arg0: &mut MarketVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.paused, 3);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v7
}

