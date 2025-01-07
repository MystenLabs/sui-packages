module 0xd6ab973d008dfc771b034a5a78a852eef2f02a8581846255a335e8f80b5f1ac7::utils {
    struct Int_wrapper has copy, drop, store {
        value: u64,
    }

    public fun check_ticket_gold_cost(arg0: u64) : bool {
        arg0 == 1 * 1000000000 || arg0 == 5 * 1000000000 || arg0 == 10 * 1000000000 || arg0 == 100 * 1000000000 || arg0 == 500 * 1000000000
    }

    public fun estimate_reward(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = (arg2 as u64) * arg1 * 3 / 10;
        let v1 = v0;
        let v2 = arg0 * 9 / 10;
        if (v0 > v2) {
            v1 = v2;
        };
        v1
    }

    public fun generate_wrapper_with_value(arg0: u64) : Int_wrapper {
        Int_wrapper{value: arg0}
    }

    public fun get_cards_level2_prop_by_lineup_power(arg0: u64) : u64 {
        25 * arg0
    }

    public fun get_class_by_level(arg0: 0x1::string::String, arg1: u8) : 0x1::string::String {
        let v0 = arg0;
        let v1 = if (arg1 == 1) {
            0x1::string::utf8(b"1")
        } else if (arg1 == 2) {
            0x1::string::utf8(b"1_1")
        } else if (arg1 >= 3 && arg1 <= 5) {
            0x1::string::utf8(b"2")
        } else if (arg1 >= 6 && arg1 <= 8) {
            0x1::string::utf8(b"2_1")
        } else {
            0x1::string::utf8(b"3")
        };
        0x1::string::append(&mut v0, v1);
        v0
    }

    public fun get_int(arg0: &Int_wrapper) : u64 {
        arg0.value
    }

    public fun get_left_right_number(arg0: 0x1::string::String) : (u64, u64) {
        let v0 = 0x1::string::utf8(b"-");
        let v1 = 0x1::string::index_of(&arg0, &v0);
        if (v1 == 0x1::string::length(&arg0)) {
            return (utf8_to_u64(0x1::string::sub_string(&arg0, 0, v1)), 0)
        };
        (utf8_to_u64(0x1::string::sub_string(&arg0, 0, v1)), utf8_to_u64(0x1::string::sub_string(&arg0, v1 + 1, 0x1::string::length(&arg0))))
    }

    public fun get_lineup_level2_prop_by_lineup_power(arg0: u64) : u64 {
        35 * arg0
    }

    public fun get_lineup_level3_prop_by_lineup_power(arg0: u64) : u64 {
        if (arg0 <= 16) {
            0
        } else {
            11 * arg0
        }
    }

    public fun get_lineup_power_by_tag(arg0: u8, arg1: u8) : u64 {
        ((2 + arg0 * 2 - arg1) as u64)
    }

    public fun get_pool_tag(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = u8_to_string(arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, u8_to_string(arg1));
        v0
    }

    public fun get_random_num(arg0: u64, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        (arg0 + tx_bytes_to_u64(seed(arg3, arg2))) % (arg1 + 1)
    }

    public fun get_role_num_by_lineup_power(arg0: u64) : u64 {
        if (arg0 >= 6) {
            6
        } else if (arg0 >= 4) {
            5
        } else if (arg0 >= 3) {
            4
        } else {
            3
        }
    }

    public fun numbers_to_ascii_vector(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun print2(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        0x1::string::append(&mut arg0, arg1);
        0x1::debug::print<0x1::string::String>(&arg0);
    }

    public fun removeSuffix(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"3");
        if (0x1::string::index_of(&arg0, &v0) < 0x1::string::length(&arg0)) {
            let v1 = 0x1::string::utf8(b"3");
            return 0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v1))
        };
        let v2 = 0x1::string::utf8(b"2_1");
        if (0x1::string::index_of(&arg0, &v2) < 0x1::string::length(&arg0)) {
            let v3 = 0x1::string::utf8(b"2_1");
            return 0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v3))
        };
        let v4 = 0x1::string::utf8(b"2");
        if (0x1::string::index_of(&arg0, &v4) < 0x1::string::length(&arg0)) {
            let v5 = 0x1::string::utf8(b"2");
            return 0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v5))
        };
        let v6 = 0x1::string::utf8(b"1_1");
        if (0x1::string::index_of(&arg0, &v6) < 0x1::string::length(&arg0)) {
            let v7 = 0x1::string::utf8(b"1_1");
            return 0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v7))
        };
        let v8 = 0x1::string::utf8(b"1");
        if (0x1::string::index_of(&arg0, &v8) < 0x1::string::length(&arg0)) {
            let v9 = 0x1::string::utf8(b"1");
            return 0x1::string::sub_string(&arg0, 0, 0x1::string::index_of(&arg0, &v9))
        };
        arg0
    }

    public fun seed(arg0: &mut 0x2::tx_context::TxContext, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg1);
        let v1 = 0x2::object::new(arg0);
        0x2::object::delete(v1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, 0x2::object::uid_to_bytes(&v1));
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v3));
        0x2::hash::keccak256(&v2)
    }

    public fun set_int(arg0: &mut Int_wrapper, arg1: u64) {
        arg0.value = arg1;
    }

    fun tx_bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            assert!(0x1::vector::length<u8>(&arg0) > v1, 1);
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::insert<u8>(&mut v0, ((arg0 % 10) as u8) + 48, 0);
        arg0 = arg0 / 10;
        while (arg0 > 0) {
            0x1::vector::insert<u8>(&mut v0, ((arg0 % 10) as u8) + 48, 0);
            arg0 = arg0 / 10;
        };
        0x1::string::utf8(v0)
    }

    public fun u8_to_string(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::insert<u8>(&mut v0, arg0 % 10 + 48, 0);
        arg0 = arg0 / 10;
        while (arg0 > 0) {
            0x1::vector::insert<u8>(&mut v0, arg0 % 10 + 48, 0);
            arg0 = arg0 / 10;
        };
        0x1::string::utf8(v0)
    }

    public fun utf8_to_u64(arg0: 0x1::string::String) : u64 {
        let v0 = *0x1::string::bytes(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            assert!(0x1::vector::length<u8>(&v0) > v1, 1);
            let v3 = v2 * 10;
            v2 = v3 + (*0x1::vector::borrow<u8>(&v0, v1) as u64) - 48;
            v1 = v1 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

