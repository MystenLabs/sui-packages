module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize {
    public fun address_(arg0: &vector<u8>, arg1: u64) : (address, u64) {
        (0x2::address::from_bytes(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(arg0, arg1, arg1 + 32)), arg1 + 32)
    }

    public fun bool_(arg0: &vector<u8>, arg1: u64) : (bool, u64) {
        let v0 = *0x1::vector::borrow<u8>(arg0, arg1);
        if (v0 == 0) {
            (false, arg1 + 1)
        } else {
            assert!(v0 == 1, 1);
            (true, arg1 + 1)
        }
    }

    public fun id_(arg0: &vector<u8>, arg1: u64) : (0x2::object::ID, u64) {
        (0x2::object::id_from_bytes(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(arg0, arg1, arg1 + 32)), arg1 + 32)
    }

    public fun string_(arg0: &vector<u8>, arg1: u64) : (0x1::string::String, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        (0x1::string::utf8(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(arg0, v1, v1 + v0)), v1 + v0)
    }

    public fun u128_(arg0: &vector<u8>, arg1: u64) : (u128, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 16) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, arg1 + (v0 as u64)) as u128) << v0 * 8);
            v0 = v0 + 1;
        };
        (v1, arg1 + 16)
    }

    public fun u16_(arg0: &vector<u8>, arg1: u64) : (u16, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 2) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, arg1 + (v0 as u64)) as u16) << v0 * 8);
            v0 = v0 + 1;
        };
        (v1, arg1 + 2)
    }

    public fun u256_(arg0: &vector<u8>, arg1: u64) : (u256, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 32) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, arg1 + v0) as u256) << ((v0 * 8) as u8));
            v0 = v0 + 1;
        };
        (v1, arg1 + 32)
    }

    public fun u32_(arg0: &vector<u8>, arg1: u64) : (u32, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 4) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, arg1 + (v0 as u64)) as u32) << v0 * 8);
            v0 = v0 + 1;
        };
        (v1, arg1 + 4)
    }

    public fun u64_(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 8) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, arg1 + (v0 as u64)) as u64) << v0 * 8);
            v0 = v0 + 1;
        };
        (v1, arg1 + 8)
    }

    public fun url_(arg0: &vector<u8>, arg1: u64) : (0x2::url::Url, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        (0x2::url::new_unsafe_from_bytes(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(arg0, v1, v1 + v0)), v1 + v0)
    }

    public fun vec_address(arg0: &vector<u8>, arg1: u64) : (vector<address>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, _) = address_(arg0, v1 + v3 * 32);
            0x1::vector::push_back<address>(&mut v2, v4);
            v3 = v3 + 1;
        };
        (v2, v1 + v0 * 32)
    }

    public fun vec_bool(arg0: &vector<u8>, arg1: u64) : (vector<bool>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, _) = bool_(arg0, v1 + v3);
            0x1::vector::push_back<bool>(&mut v2, v4);
            v3 = v3 + 1;
        };
        (v2, v1 + v0)
    }

    public fun vec_id(arg0: &vector<u8>, arg1: u64) : (vector<0x2::object::ID>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, _) = id_(arg0, v1 + v3 * 32);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v4);
            v3 = v3 + 1;
        };
        (v2, v1 + v0 * 32)
    }

    public fun vec_map_string_string(arg0: &vector<u8>, arg1: u64) : (0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        while (v3 < v0) {
            let (v5, v6) = string_(arg0, v2);
            let (v7, v8) = string_(arg0, v6);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, v5, v7);
            v2 = v8;
            v3 = v3 + 1;
        };
        (v4, v2)
    }

    public fun vec_string(arg0: &vector<u8>, arg1: u64) : (vector<0x1::string::String>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x1::string::String>();
        while (v3 < v0) {
            let (v5, v6) = string_(arg0, v2);
            0x1::vector::push_back<0x1::string::String>(&mut v4, v5);
            v2 = v6;
            v3 = v3 + 1;
        };
        (v4, v2)
    }

    public fun vec_u128(arg0: &vector<u8>, arg1: u64) : (vector<u128>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u128>();
        while (v2 < v0) {
            let (v4, _) = u128_(arg0, v1 + v2 * 16);
            0x1::vector::push_back<u128>(&mut v3, v4);
            v2 = v2 + 1;
        };
        (v3, v1 + v0 * 16)
    }

    public fun vec_u16(arg0: &vector<u8>, arg1: u64) : (vector<u16>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u16>();
        while (v2 < v0) {
            let (v4, _) = u16_(arg0, v1 + v2 * 2);
            0x1::vector::push_back<u16>(&mut v3, v4);
            v2 = v2 + 1;
        };
        (v3, v1 + v0 * 2)
    }

    public fun vec_u256(arg0: &vector<u8>, arg1: u64) : (vector<u256>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u256>();
        while (v2 < v0) {
            let (v4, _) = u256_(arg0, v1 + v2 * 32);
            0x1::vector::push_back<u256>(&mut v3, v4);
            v2 = v2 + 1;
        };
        (v3, v1 + v0 * 32)
    }

    public fun vec_u32(arg0: &vector<u8>, arg1: u64) : (vector<u32>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u32>();
        while (v2 < v0) {
            let (v4, _) = u32_(arg0, v1 + v2 * 4);
            0x1::vector::push_back<u32>(&mut v3, v4);
            v2 = v2 + 1;
        };
        (v3, v1 + v0 * 4)
    }

    public fun vec_u64(arg0: &vector<u8>, arg1: u64) : (vector<u64>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        while (v2 < v0) {
            let (v4, _) = u64_(arg0, v1 + v2 * 8);
            0x1::vector::push_back<u64>(&mut v3, v4);
            v2 = v2 + 1;
        };
        (v3, v1 + v0 * 8)
    }

    public fun vec_u8(arg0: &vector<u8>, arg1: u64) : (vector<u8>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        (0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(arg0, v1, v1 + v0), v1 + v0)
    }

    public fun vec_url(arg0: &vector<u8>, arg1: u64) : (vector<0x2::url::Url>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::url::Url>();
        while (v3 < v0) {
            let (v5, v6) = url_(arg0, v2);
            0x1::vector::push_back<0x2::url::Url>(&mut v4, v5);
            v2 = v6;
            v3 = v3 + 1;
        };
        (v4, v2)
    }

    public fun vec_vec_map_string_string(arg0: &vector<u8>, arg1: u64) : (vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>();
        while (v3 < v0) {
            let (v5, v6) = vec_map_string_string(arg0, v2);
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v4, v5);
            v2 = v6;
            v3 = v3 + 1;
        };
        (v4, v2)
    }

    public fun vec_vec_u8(arg0: &vector<u8>, arg1: u64) : (vector<vector<u8>>, u64) {
        let (v0, v1) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::bcs2::uleb128_length(arg0, arg1);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0x1::vector::empty<vector<u8>>();
        while (v3 < v0) {
            let (v5, v6) = vec_u8(arg0, v2);
            0x1::vector::push_back<vector<u8>>(&mut v4, v5);
            v2 = v6;
            v3 = v3 + 1;
        };
        (v4, v2)
    }

    // decompiled from Move bytecode v6
}

