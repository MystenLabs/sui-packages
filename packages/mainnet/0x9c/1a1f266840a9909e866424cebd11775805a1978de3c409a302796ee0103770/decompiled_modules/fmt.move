module 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt {
    public fun addr(arg0: address) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg0)));
        v0
    }

    public fun amount(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = 0x1::u64::pow(10, arg1);
        let v1 = dec(arg0 / v0);
        let v2 = arg0 % v0;
        if (v2 > 0) {
            let v3 = dec(v2);
            let v4 = b"";
            let v5 = (arg1 as u64) - 0x1::vector::length<u8>(&v3);
            while (v5 > 0) {
                0x1::vector::push_back<u8>(&mut v4, 48);
                v5 = v5 - 1;
            };
            0x1::vector::append<u8>(&mut v4, v3);
            while (*0x1::vector::borrow<u8>(&v4, 0x1::vector::length<u8>(&v4) - 1) == 48) {
                0x1::vector::pop_back<u8>(&mut v4);
            };
            0x1::vector::push_back<u8>(&mut v1, 46);
            0x1::vector::append<u8>(&mut v1, v4);
        };
        v1
    }

    public fun base58(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0;
        while (v1 < v0 && *0x1::vector::borrow<u8>(arg0, v1) == 0) {
            v1 = v1 + 1;
        };
        let v2 = b"";
        let v3 = v1;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u8>(arg0, v3) as u64);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u8>(&v2)) {
                let v6 = v4 + ((*0x1::vector::borrow<u8>(&v2, v5) as u64) << 8);
                *0x1::vector::borrow_mut<u8>(&mut v2, v5) = ((v6 % 58) as u8);
                v4 = v6 / 58;
                v5 = v5 + 1;
            };
            while (v4 > 0) {
                0x1::vector::push_back<u8>(&mut v2, ((v4 % 58) as u8));
                v4 = v4 / 58;
            };
            v3 = v3 + 1;
        };
        let v7 = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        let v8 = b"";
        let v9 = 0;
        while (v9 < v1) {
            0x1::vector::push_back<u8>(&mut v8, 49);
            v9 = v9 + 1;
        };
        let v10 = 0x1::vector::length<u8>(&v2);
        while (v10 > 0) {
            v10 = v10 - 1;
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&v7, (*0x1::vector::borrow<u8>(&v2, v10) as u64)));
        };
        v8
    }

    public fun dec(arg0: u64) : vector<u8> {
        0x1::string::into_bytes(0x1::u64::to_string(arg0))
    }

    public fun id(arg0: 0x2::object::ID) : vector<u8> {
        addr(0x2::object::id_to_address(&arg0))
    }

    public fun line(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"0a";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b": ");
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    fun two(arg0: u64) : vector<u8> {
        let v0 = b"";
        if (arg0 < 10) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        };
        0x1::vector::append<u8>(&mut v0, dec(arg0));
        v0
    }

    public fun type_of<T0>() : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        v0
    }

    public fun utc(arg0: u64) : vector<u8> {
        let v0 = arg0 / 1000;
        let v1 = v0 % 86400;
        let v2 = v0 / 86400 + 719468;
        let v3 = v2 / 146097;
        let v4 = v2 - v3 * 146097;
        let v5 = (v4 - v4 / 1460 + v4 / 36524 - v4 / 146096) / 365;
        let v6 = v4 - 365 * v5 + v5 / 4 - v5 / 100;
        let v7 = (5 * v6 + 2) / 153;
        let v8 = if (v7 < 10) {
            v7 + 3
        } else {
            v7 - 9
        };
        let v9 = if (v8 <= 2) {
            1
        } else {
            0
        };
        let v10 = dec(v5 + v3 * 400 + v9);
        0x1::vector::push_back<u8>(&mut v10, 45);
        0x1::vector::append<u8>(&mut v10, two(v8));
        0x1::vector::push_back<u8>(&mut v10, 45);
        0x1::vector::append<u8>(&mut v10, two(v6 - (153 * v7 + 2) / 5 + 1));
        0x1::vector::push_back<u8>(&mut v10, 32);
        0x1::vector::append<u8>(&mut v10, two(v1 / 3600));
        0x1::vector::push_back<u8>(&mut v10, 58);
        0x1::vector::append<u8>(&mut v10, two(v1 % 3600 / 60));
        0x1::vector::push_back<u8>(&mut v10, 58);
        0x1::vector::append<u8>(&mut v10, two(v1 % 60));
        0x1::vector::append<u8>(&mut v10, b" UTC");
        v10
    }

    public fun with_unit(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::push_back<u8>(&mut arg0, 32);
        0x1::vector::append<u8>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v7
}

