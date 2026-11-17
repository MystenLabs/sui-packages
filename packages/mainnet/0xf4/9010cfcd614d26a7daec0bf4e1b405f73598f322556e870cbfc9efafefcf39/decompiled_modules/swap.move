module 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::swap {
    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_in: u64,
        amount_out: u64,
        is_base_to_quote: bool,
        deep_fee: u64,
    }

    public fun get_base_quantity_in<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_in<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun get_base_quantity_out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg1, arg2)
    }

    public fun get_base_quantity_out_input_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg1, arg2)
    }

    public fun get_level2_range<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun get_level2_ticks_from_mid<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, arg1, arg2)
    }

    public fun get_quote_quantity_in<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun get_quote_quantity_out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg1, arg2)
    }

    public fun get_quote_quantity_out_input_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg1, arg2)
    }

    public fun mid_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1)
    }

    public fun pool_book_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0)
    }

    public fun pool_trade_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0)
    }

    public fun vault_balances<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (u64, u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0)
    }

    public fun whitelisted<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : bool {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)
    }

    fun assert_fee_coin_kept_apart<T0, T1>(arg0: &0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v1 = 0x1::type_name::with_defining_ids<T0>() == v0 || 0x1::type_name::with_defining_ids<T1>() == v0;
        assert!(!v1 || 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0) == 0, 503);
    }

    fun class_of<T0, T1>() : u8 {
        if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<T0>()) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit()
        } else {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter()
        }
    }

    fun emit_swap<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = SwapEvent{
            pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            sender           : 0x2::tx_context::sender(arg5),
            amount_in        : arg1,
            amount_out       : arg2,
            is_base_to_quote : arg3,
            deep_fee         : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun swap_base_for_quote<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg6 > 0, 500);
        assert!(arg7 > 0, 502);
        assert_fee_coin_kept_apart<T1, T2>(&arg8);
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg4, arg2, arg3, class_of<T0, T2>(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_swap());
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg5, 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, arg6), arg10), arg8, 0, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::coin::value<T2>(&v5);
        assert!(v7 >= arg7, 501);
        emit_swap<T1, T2>(arg5, arg6 - 0x2::coin::value<T1>(&v6), v7, true, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg8) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4), arg10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, 0x2::coin::into_balance<T1>(v6));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, 0x2::coin::into_balance<T2>(v5));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg5)));
        v4
    }

    public fun swap_pocket_base_for_quote<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 500);
        assert!(arg6 > 0, 502);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_swap<T0, T1, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg2, arg5);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg4, 0x2::coin::from_balance<T1>(v0, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
        let v5 = v3;
        let v6 = v2;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        let v7 = 0x2::coin::value<T2>(&v5);
        assert!(v7 >= arg6, 501);
        emit_swap<T1, T2>(arg4, arg5 - 0x2::coin::value<T1>(&v6), v7, true, 0, arg8);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_swap_to_escrow<T0, T1, T2, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg2, arg3, v1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg4), 0x2::coin::into_balance<T2>(v5), 0x2::coin::into_balance<T1>(v6));
    }

    public fun swap_pocket_quote_for_base<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 500);
        assert!(arg6 > 0, 502);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_swap<T0, T2, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg2, arg5);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg4, 0x2::coin::from_balance<T2>(v0, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
        let v5 = v3;
        let v6 = v2;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg6, 501);
        emit_swap<T1, T2>(arg4, arg5 - 0x2::coin::value<T2>(&v5), v7, false, 0, arg8);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_swap_to_escrow<T0, T2, T1, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg2, arg3, v1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg4), 0x2::coin::into_balance<T1>(v6), 0x2::coin::into_balance<T2>(v5));
    }

    public fun swap_quote_for_base<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg6 > 0, 500);
        assert!(arg7 > 0, 502);
        assert_fee_coin_kept_apart<T1, T2>(&arg8);
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::version::current_version(), arg0, arg1, arg4, arg2, arg3, class_of<T0, T1>(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_swap());
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg5, 0x2::coin::from_balance<T2>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T2, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, arg6), arg10), arg8, 0, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg7, 501);
        emit_swap<T1, T2>(arg5, arg6 - 0x2::coin::value<T2>(&v5), v7, false, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg8) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4), arg10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, 0x2::coin::into_balance<T2>(v5));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, &mut v0, 0x2::coin::into_balance<T1>(v6));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::DeepbookWitness>(0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg5)));
        v4
    }

    // decompiled from Move bytecode v7
}

