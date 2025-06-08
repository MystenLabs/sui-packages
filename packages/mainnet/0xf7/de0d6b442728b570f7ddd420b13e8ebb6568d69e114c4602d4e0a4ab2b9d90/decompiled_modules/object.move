module 0xf7de0d6b442728b570f7ddd420b13e8ebb6568d69e114c4602d4e0a4ab2b9d90::object {
    struct S has store, key {
        id: 0x2::object::UID,
        contents: vector<u8>,
    }

    public fun delete(arg0: S) {
        let S {
            id       : v0,
            contents : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_uleb128_boundary(arg0: u64) : bool {
        if (arg0 <= 0x1::address::length() + 1) {
            return true
        };
        let v0 = arg0 - 0x1::address::length() - 1;
        if (v0 >= 127 && v0 <= 130) {
            true
        } else if (v0 >= 16383 && v0 <= 16386) {
            true
        } else {
            v0 >= 2097151 && v0 <= 2097154
        }
    }

    public fun new_with_size(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : S {
        assert!(arg0 > 0x1::address::length() + 1, 1);
        assert!(!is_uleb128_boundary(arg0), 2);
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0 - 0x1::address::length() + 1) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = S{
            id       : 0x2::object::new(arg1),
            contents : v0,
        };
        let v3 = 0x2::bcs::to_bytes<S>(&v2);
        let v4 = 0x1::vector::length<u8>(&v3);
        while (v4 > arg0) {
            0x1::vector::pop_back<u8>(&mut v2.contents);
            v4 = v4 - 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

