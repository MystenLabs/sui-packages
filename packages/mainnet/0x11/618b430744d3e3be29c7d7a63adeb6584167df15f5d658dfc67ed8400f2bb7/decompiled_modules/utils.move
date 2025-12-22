module 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::utils {
    public fun add_balance_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    fun get_base(arg0: u16) : u128 {
        18446744073709551616 + ((arg0 as u128) << 64) / 10000
    }

    public fun get_id_from_price(arg0: u128, arg1: u16) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        assert!(arg0 > 0, 13835902995608764423);
        if (arg0 == 1) {
            let v0 = 1180591620717411303424 / log2_q64(get_base(arg1));
            assert!(v0 <= 443636, 13835621559286628357);
            return 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(((4294967295 - ((v0 as u32) as u64) + 1) as u32))
        };
        let v1 = false;
        let v2 = arg0;
        if (arg0 < 18446744073709551616) {
            let v3 = (18446744073709551616 as u256) * (18446744073709551616 as u256) / (arg0 as u256);
            assert!(v3 <= 340282366920938463463374607431768211455, 13835621623711137797);
            v2 = (v3 as u128);
            v1 = true;
        };
        let v4 = log2_q64(v2) / log2_q64(get_base(arg1));
        assert!(v4 <= 443636, 13835621666660810757);
        let v5 = if (!v1) {
            (v4 as u32)
        } else {
            ((4294967295 - ((v4 as u32) as u64) + 1) as u32)
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5)
    }

    fun log2_q64(arg0: u128) : u128 {
        assert!(arg0 >= 18446744073709551616, 13835340299058151427);
        let v0 = msb_u128(arg0);
        let v1 = arg0 >> ((v0 - 63) as u8);
        let v2 = 0;
        let v3 = 4611686018427387904;
        let v4 = 0;
        while (v4 < 63) {
            v1 = v1 * v1 >> 63;
            if (v1 >= 18446744073709551616) {
                v1 = v1 >> 1;
                v2 = v2 + v3;
            };
            v3 = v3 >> 1;
            v4 = v4 + 1;
        };
        (((v0 - 64) as u128) << 64) + (v2 << 1)
    }

    fun msb_u128(arg0: u128) : u8 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 > 18446744073709551615) {
            v0 = arg0 >> 64;
            v2 = v1 + 64;
        };
        if (v0 > 4294967295) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 > 65535) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 > 255) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 > 15) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 > 3) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 > 1) {
            v2 = v2 + 1;
        };
        v2
    }

    public fun remove_balance_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64, arg2: bool) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return (0x2::balance::zero<T0>(), 0)
        };
        let v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0));
        if (arg2) {
            return (0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), 0)
        };
        assert!(v1 >= arg1, 13835058433239285761);
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1), v1 - arg1)
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

