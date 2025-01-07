module 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::deepbookv3 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepbookV3Config has store, key {
        id: 0x2::object::UID,
        is_alternative_payment: bool,
        deep_fee_vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct DeepbookV3SwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        deep_fee: u64,
        alt_payment_deep_fee: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun add_whitelist(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: 0x2::object::ID, arg3: bool) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, arg3);
    }

    public(friend) fun alternative_payment_deep(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(is_alternative_payment(arg0), 1);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault) >= arg2, 0);
        let v0 = 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v0, 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg2));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg3)
    }

    public fun deposit_deep_fee(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepbookV3Config{
            id                     : 0x2::object::new(arg0),
            is_alternative_payment : true,
            deep_fee_vault         : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            whitelist              : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<DeepbookV3Config>(v0);
    }

    public fun is_alternative_payment(arg0: &DeepbookV3Config) : bool {
        arg0.is_alternative_payment
    }

    public(friend) fun is_whitelisted(arg0: &DeepbookV3Config, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg1)
    }

    public fun remove_whitelist(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: 0x2::object::ID) {
        if (!is_whitelisted(arg1, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.whitelist, arg2);
    }

    public fun set_alternative_payment(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: bool) {
        arg1.is_alternative_payment = arg2;
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::Config, arg1: &mut DeepbookV3Config, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg2, v0, arg5);
        let v4 = 0;
        let v5 = if (v3 > 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4)) {
            let v6 = v3 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4);
            v4 = v6;
            assert!(is_whitelisted(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2)), 2);
            alternative_payment_deep(arg1, arg4, v6, arg6)
        } else {
            arg4
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, arg3, v5, 0, arg5, arg6);
        let v10 = v8;
        let v11 = v7;
        let v12 = DeepbookV3SwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            amount_in            : v0 - 0x2::coin::value<T0>(&v11),
            amount_out           : 0x2::coin::value<T1>(&v10),
            a2b                  : true,
            by_amount_in         : true,
            deep_fee             : v3,
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3SwapEvent>(v12);
        0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::utils::transfer_or_destroy_coin<T0>(v11, arg6);
        0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, arg6);
        let (v13, _) = 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::pay_fee<T1>(arg0, v10, arg6);
        v13
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::Config, arg1: &mut DeepbookV3Config, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg2, v0, arg5);
        let v4 = 0;
        let v5 = if (v3 > 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4)) {
            let v6 = v3 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4);
            v4 = v6;
            assert!(is_whitelisted(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2)), 2);
            alternative_payment_deep(arg1, arg4, v6, arg6)
        } else {
            arg4
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, arg3, v5, 0, arg5, arg6);
        let v10 = v8;
        let v11 = v7;
        let v12 = DeepbookV3SwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            amount_in            : v0 - 0x2::coin::value<T1>(&v10),
            amount_out           : 0x2::coin::value<T0>(&v11),
            a2b                  : false,
            by_amount_in         : true,
            deep_fee             : v3,
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3SwapEvent>(v12);
        0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::utils::transfer_or_destroy_coin<T1>(v10, arg6);
        0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, arg6);
        let (v13, _) = 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::pay_fee<T0>(arg0, v11, arg6);
        v13
    }

    public fun withdraw_deep_fee(arg0: &mut DeepbookV3Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

