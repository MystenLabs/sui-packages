module 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::utils {
    public fun are_coins_suitable<T0, T1>() : bool {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::select_different_coins());
        true
    }

    public fun assert_coin_integrity<T0, T1, T2>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::TreasuryCap<T2>, arg3: &0x2::coin::CoinMetadata<T2>) {
        are_coins_suitable<T0, T1>();
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>(), 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::invalid_quote_token());
        assert_coin_integrity_tm<T0>(arg0, arg1);
        assert_coin_integrity_tm<T2>(arg2, arg3);
    }

    public fun assert_coin_integrity_tm<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>) {
        assert!(0x2::coin::get_decimals<T0>(arg1) == 6, 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::meme_and_ticket_coins_must_have_6_decimals());
        assert!(0x2::coin::total_supply<T0>(arg0) == 0, 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::should_have_0_total_supply());
    }

    public fun assert_ticket_coin_integrity<T0, T1, T2>(arg0: &0x2::coin::CoinMetadata<T0>) {
        assert!(0x2::coin::get_decimals<T0>(arg0) == 6, 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::meme_and_ticket_coins_must_have_6_decimals());
        assert_ticket_coin_otw<T0, T1, T2>();
    }

    fun assert_ticket_coin_otw<T0, T1, T2>() {
        are_coins_suitable<T0, T1>();
        let v0 = 0x1::type_name::get<T2>();
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get_module(&v1);
        let v3 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v3, b"ticket_");
        0x1::string::append_utf8(&mut v3, 0x1::ascii::into_bytes(0x1::type_name::get_module(&v0)));
        let v4 = 0x1::string::to_ascii(v3);
        let v5 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::comparator::compare<0x1::ascii::String>(&v2, &v4);
        assert!(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::comparator::eq(&v5), 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::wrong_module_name());
    }

    public fun get_optimal_add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 && arg3 == 0) {
            return (arg0, arg1)
        };
        let v0 = quote_liquidity(arg0, arg2, arg3);
        if (arg1 >= v0) {
            return (arg0, v0)
        };
        (quote_liquidity(arg1, arg3, arg2), arg1)
    }

    public fun get_ticket_coin_name<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x1::string::String {
        let v0 = 0x2::coin::get_name<T0>(arg0);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v1, *0x1::string::bytes(&v0));
        0x1::string::append_utf8(&mut v1, b" Ticket Coin");
        v1
    }

    public fun get_ticket_coin_symbol<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x1::ascii::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"ticket-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x2::coin::get_symbol<T0>(arg0)));
        0x1::string::to_ascii(v0)
    }

    public fun is_coin_x<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<0x2::sui::SUI>();
        &v0 == &v1
    }

    public fun mist(arg0: u64) : u64 {
        1000000000 * arg0
    }

    public fun quote_liquidity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math64::mul_div_up(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

