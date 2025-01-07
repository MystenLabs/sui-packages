module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2 {
    public fun peel_ascii(arg0: &mut 0x2::bcs::BCS) : 0x1::ascii::String {
        0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0))
    }

    public fun peel_id(arg0: &mut 0x2::bcs::BCS) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::bcs::peel_address(arg0))
    }

    public fun peel_option_byte(arg0: &mut 0x2::bcs::BCS) : bool {
        0x2::bcs::peel_bool(arg0)
    }

    public fun peel_utf8(arg0: &mut 0x2::bcs::BCS) : 0x1::string::String {
        0x1::string::utf8(0x2::bcs::peel_vec_u8(arg0))
    }

    public fun peel_vec_ascii(arg0: &mut 0x2::bcs::BCS) : vector<0x1::ascii::String> {
        let v0 = 0x2::bcs::peel_vec_vec_u8(arg0);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun peel_vec_id(arg0: &mut 0x2::bcs::BCS) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(0x2::bcs::peel_address(arg0)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun peel_vec_map_utf8(arg0: &mut 0x2::bcs::BCS) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::bcs::peel_vec_vec_u8(arg0);
        assert!(0x1::vector::length<vector<u8>>(&v0) % 2 == 0, 1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, v2)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, v2 + 1)));
            v2 = v2 + 2;
        };
        v1
    }

    public fun peel_vec_utf8(arg0: &mut 0x2::bcs::BCS) : vector<0x1::string::String> {
        let v0 = 0x2::bcs::peel_vec_vec_u8(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun u64_into_uleb128(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1;
        loop {
            v1 = ((arg0 & 127) as u8);
            arg0 = arg0 >> 7;
            if (arg0 == 0) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, v1 | 128);
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        v0
    }

    public fun uleb128_length(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            assert!(v0 <= 4, 0);
            let v3 = (*0x1::vector::borrow<u8>(arg0, arg1 + v0) as u64);
            v2 = v2 | (v3 & 127) << v1;
            if (v3 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
            v0 = v0 + 1;
        };
        (v2, arg1 + v0 + 1)
    }

    // decompiled from Move bytecode v6
}

