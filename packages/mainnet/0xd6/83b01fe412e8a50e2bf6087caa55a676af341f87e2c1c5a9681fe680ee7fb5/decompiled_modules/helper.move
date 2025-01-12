module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper {
    struct CapInfo has copy, drop, store {
        cap_id: 0x2::object::ID,
        type_info: 0x1::ascii::String,
    }

    public fun calc_prize_level(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = vector[];
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 9223372114164187135);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<bool>(&mut v0, 0x1::vector::borrow<u8>(arg0, v2) == 0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 6 && *0x1::vector::borrow<bool>(&v0, (v3 as u64))) {
            v3 = v3 + 1;
        };
        v3
    }

    public fun create_cap_info<T0>(arg0: 0x2::object::ID) : CapInfo {
        CapInfo{
            cap_id    : arg0,
            type_info : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        }
    }

    public(friend) fun generate_u8(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u8, arg3: u8) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, arg2, arg3)
    }

    public fun get_cap_id(arg0: &CapInfo) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun get_type_info(arg0: &CapInfo) : 0x1::ascii::String {
        arg0.type_info
    }

    fun is_leap_year(arg0: u64) : bool {
        arg0 % 4 != 0 && false || arg0 % 100 != 0 || arg0 % 400 != 0 && false || true
    }

    public fun ms_to_date_string(arg0: u64) : 0x1::ascii::String {
        let v0 = 1970;
        let v1 = arg0 / 86400000;
        while (v1 >= 365) {
            let v2 = if (is_leap_year(v0)) {
                366
            } else {
                365
            };
            if (v1 >= v2) {
                v1 = v1 - v2;
                v0 = v0 + 1;
            } else {
                break
            };
        };
        let v3 = 1;
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 31);
        let v5 = if (is_leap_year(v0)) {
            29
        } else {
            28
        };
        0x1::vector::push_back<u64>(&mut v4, v5);
        0x1::vector::push_back<u64>(&mut v4, 31);
        0x1::vector::push_back<u64>(&mut v4, 30);
        0x1::vector::push_back<u64>(&mut v4, 31);
        0x1::vector::push_back<u64>(&mut v4, 30);
        0x1::vector::push_back<u64>(&mut v4, 31);
        0x1::vector::push_back<u64>(&mut v4, 31);
        0x1::vector::push_back<u64>(&mut v4, 30);
        0x1::vector::push_back<u64>(&mut v4, 31);
        0x1::vector::push_back<u64>(&mut v4, 30);
        0x1::vector::push_back<u64>(&mut v4, 31);
        while (v3 <= 12 && v1 >= *0x1::vector::borrow<u64>(&v4, v3 - 1)) {
            v1 = v1 - *0x1::vector::borrow<u64>(&v4, v3 - 1);
            v3 = v3 + 1;
        };
        let v6 = v1 + 1;
        let v7 = number_to_string(v0);
        0x1::ascii::append(&mut v7, 0x1::ascii::string(b"-"));
        if (v3 < 10) {
            0x1::ascii::append(&mut v7, 0x1::ascii::string(b"0"));
        };
        0x1::ascii::append(&mut v7, number_to_string(v3));
        0x1::ascii::append(&mut v7, 0x1::ascii::string(b"-"));
        if (v6 < 10) {
            0x1::ascii::append(&mut v7, 0x1::ascii::string(b"0"));
        };
        0x1::ascii::append(&mut v7, number_to_string(v6));
        0x1::debug::print<0x1::ascii::String>(&v7);
        v7
    }

    public fun number_to_string(arg0: u64) : 0x1::ascii::String {
        0x1::string::to_ascii(0x1::u64::to_string(arg0))
    }

    public fun validate_pool_type(arg0: &0x1::ascii::String) : bool {
        let v0 = vector[b"daily", b"weekly", b"monthly", b"yearly"];
        let v1 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg0));
        0x1::vector::contains<vector<u8>>(&v0, &v1)
    }

    // decompiled from Move bytecode v6
}

