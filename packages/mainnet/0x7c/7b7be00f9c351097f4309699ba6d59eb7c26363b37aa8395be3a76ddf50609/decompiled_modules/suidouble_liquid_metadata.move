module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_metadata {
    public(friend) fun get_metadata(arg0: &vector<u8>, arg1: u8) : 0x1::option::Option<vector<u8>> {
        let v0 = get_metadata_offset_for_n(arg0, arg1);
        let v1 = get_metadata_length_for_offset(arg0, v0);
        if (v1 == 0 || 0x1::vector::length<u8>(arg0) < v0 + (v1 as u64)) {
            return 0x1::option::none<vector<u8>>()
        };
        if (*0x1::vector::borrow<u8>(arg0, v0 + 2) == 0) {
            return 0x1::option::none<vector<u8>>()
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = v0 + 3;
        while (v3 < v0 + (v1 as u64)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        0x1::option::some<vector<u8>>(v2)
    }

    public(friend) fun get_metadata_address(arg0: &vector<u8>, arg1: u8) : 0x1::option::Option<address> {
        let v0 = get_metadata(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<address>()
        };
        let v1 = 0x1::option::destroy_some<vector<u8>>(v0);
        if (0x1::vector::length<u8>(&v1) != 32) {
            return 0x1::option::none<address>()
        };
        let v2 = 0x2::bcs::new(v1);
        0x1::option::some<address>(0x2::bcs::peel_address(&mut v2))
    }

    fun get_metadata_length_for_offset(arg0: &vector<u8>, arg1: u64) : u8 {
        if (arg1 == 0x1::vector::length<u8>(arg0)) {
            return 0
        };
        *0x1::vector::borrow<u8>(arg0, arg1 + 1)
    }

    fun get_metadata_offset_for_n(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == arg1) {
                return v1
            };
            let v2 = (*0x1::vector::borrow<u8>(arg0, v1 + 1) as u64);
            v1 = v1 + v2;
        };
        v0
    }

    public(friend) fun get_metadata_u64_with_default(arg0: &vector<u8>, arg1: u8, arg2: u64) : u64 {
        let v0 = get_metadata(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return arg2
        };
        let v1 = 0x1::option::destroy_some<vector<u8>>(v0);
        if (0x1::vector::length<u8>(&v1) != 8) {
            return arg2
        };
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_u64(&mut v2)
    }

    public(friend) fun has_metadata(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = get_metadata_offset_for_n(arg0, arg1);
        let v1 = get_metadata_length_for_offset(arg0, v0);
        if (v1 == 0 || 0x1::vector::length<u8>(arg0) < v0 + (v1 as u64)) {
            return false
        };
        if (*0x1::vector::borrow<u8>(arg0, v0 + 2) == 0) {
            return false
        };
        true
    }

    public(friend) fun remove_metadata(arg0: &mut vector<u8>, arg1: u8) : bool {
        let v0 = get_metadata_offset_for_n(arg0, arg1);
        if (get_metadata_length_for_offset(arg0, v0) == 0) {
            return false
        };
        0x1::vector::push_back<u8>(arg0, 0);
        0x1::vector::swap<u8>(arg0, 0x1::vector::length<u8>(arg0), v0 + 2);
        0x1::vector::pop_back<u8>(arg0);
        true
    }

    public(friend) fun set_metadata<T0>(arg0: &mut vector<u8>, arg1: u8, arg2: &T0) : bool {
        let v0 = get_metadata_offset_for_n(arg0, arg1);
        let v1 = get_metadata_length_for_offset(arg0, v0);
        let v2 = 0x2::bcs::to_bytes<T0>(arg2);
        let v3 = 0x1::vector::length<u8>(&v2);
        if (v3 > 253) {
            return false
        };
        if (v1 == 0) {
            0x1::vector::push_back<u8>(arg0, arg1);
            0x1::vector::push_back<u8>(arg0, (v3 as u8) + 3);
            0x1::vector::push_back<u8>(arg0, 1);
            0x1::vector::append<u8>(arg0, v2);
        } else {
            if (v3 != ((v1 - 3) as u64)) {
                return false
            };
            let v4 = 0x1::vector::length<u8>(arg0);
            let v5 = v0 + (v1 as u64);
            while (!0x1::vector::is_empty<u8>(&v2)) {
                v5 = v5 - 1;
                0x1::vector::push_back<u8>(arg0, 0x1::vector::pop_back<u8>(&mut v2));
                0x1::vector::swap<u8>(arg0, v4, v5);
                0x1::vector::pop_back<u8>(arg0);
            };
            0x1::vector::push_back<u8>(arg0, 1);
            0x1::vector::swap<u8>(arg0, v4, v0 + 2);
            0x1::vector::pop_back<u8>(arg0);
            0x1::vector::destroy_empty<u8>(v2);
        };
        true
    }

    public(friend) fun set_metadata_address(arg0: &mut vector<u8>, arg1: u8, arg2: address) : bool {
        set_metadata<address>(arg0, arg1, &arg2)
    }

    public(friend) fun set_metadata_u64(arg0: &mut vector<u8>, arg1: u8, arg2: u64) : bool {
        set_metadata<u64>(arg0, arg1, &arg2)
    }

    // decompiled from Move bytecode v6
}

