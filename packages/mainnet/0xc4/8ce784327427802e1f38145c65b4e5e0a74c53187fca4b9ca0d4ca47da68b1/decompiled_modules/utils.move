module 0xc48ce784327427802e1f38145c65b4e5e0a74c53187fca4b9ca0d4ca47da68b1::utils {
    public fun are_coins_suitable<T0, T1>() : bool {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0);
        true
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

