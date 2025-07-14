module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils {
    public(friend) fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        assert!(arg0 <= arg2, 1);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    public(friend) fun arithmetic_is_less_than_u16(arg0: u16, arg1: u16, arg2: u16) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        assert!(arg0 <= arg2, 1);
        let v0 = arg2 / arg1;
        (((v0 - arg0 / arg1) / v0) as u8)
    }

    public(friend) fun assert_valid_version(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState) {
        assert!(!0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::is_global_frozen(arg0), 1);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::global_state_version(arg0) == 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::current_package_version(), 0);
    }

    public(friend) fun calc_rarity(arg0: u16) : u8 {
        let v0 = arithmetic_is_less_than_u16(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_probability_mythic_arithmetic(), 10000);
        let v1 = arithmetic_is_less_than_u16(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_probability_legendary_arithmetic(), 10000) * (1 - v0);
        let v2 = arithmetic_is_less_than_u16(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_probability_epic_arithmetic(), 10000) * (1 - v0) * (1 - v1);
        let v3 = arithmetic_is_less_than_u16(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_probability_rare_arithmetic(), 10000) * (1 - v0) * (1 - v1) * (1 - v2);
        v0 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_mythic_index() + v1 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_legendary_index() + v2 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_epic_index() + v3 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_rare_index() + (1 - v0) * (1 - v1) * (1 - v2) * (1 - v3) * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::rarity_common_index()
    }

    public(friend) fun generate_rarity(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        calc_rarity(0x2::random::generate_u16_in_range(arg0, 1, 10000))
    }

    public fun generate_uniform_random(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = arg2 + 1;
        let v1 = 1;
        let v2 = 256;
        while (v2 < v0) {
            v1 = v1 + 1;
            v2 = v2 * 256;
        };
        let v3;
        loop {
            assert!(arg1 + v1 <= 0x1::vector::length<u8>(arg0), 2);
            v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                let v5 = v3 * 256;
                v3 = v5 + (*0x1::vector::borrow<u8>(arg0, arg1 + v4) as u64);
                v4 = v4 + 1;
            };
            arg1 = arg1 + v1;
            if (v3 < v2 - v2 % v0) {
                break
            };
        };
        v3 % v0
    }

    public(friend) fun generate_unique_invite_code(arg0: u64, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::tx_context::sender(arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0));
        let v3 = 0x2::hash::blake2b256(&v1);
        let v4 = b"0123456789abcdefghijklmnopqrstuvwxyz";
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 8) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, (*0x1::vector::borrow<u8>(&v3, v6 * 4) as u64) % 36));
            v6 = v6 + 1;
        };
        0x1::string::utf8(v5)
    }

    public(friend) fun is_valid_aquarium_description(arg0: &0x1::string::String) : bool {
        if (0x1::string::length(arg0) > 100) {
            return false
        };
        is_valid_english_string(arg0)
    }

    public(friend) fun is_valid_aquarium_name(arg0: &0x1::string::String) : bool {
        if (0x1::string::length(arg0) > 10) {
            return false
        };
        is_valid_english_string(arg0)
    }

    public(friend) fun is_valid_diver_name(arg0: &0x1::string::String) : bool {
        if (0x1::string::length(arg0) > 7) {
            return false
        };
        is_valid_english_string(arg0)
    }

    public(friend) fun is_valid_english_string(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = if (v2 >= 65 && v2 <= 90) {
                true
            } else if (v2 >= 97 && v2 <= 122) {
                true
            } else if (v2 >= 48 && v2 <= 57) {
                true
            } else {
                v2 == 32
            };
            if (!v3) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public(friend) fun pow_with_decimals(arg0: u64, arg1: u64) : u64 {
        let v0 = 100;
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = v0 * arg0;
            v0 = v2 / 100;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

