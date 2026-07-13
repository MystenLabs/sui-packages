module 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util {
    public(friend) fun address_to_hex_str(arg0: address) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = b"0123456789abcdef";
        let v2 = b"0x";
        let v3 = 0;
        while (v3 < 32) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v4 & 15) as u64)));
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun number_to_float_str(arg0: u64, arg1: u8, arg2: u8) : vector<u8> {
        assert!(arg2 <= arg1, 3003);
        let v0 = pow10((arg1 as u64));
        let v1 = u64_to_decimal_str(arg0 / v0);
        if (arg2 == 0) {
            return v1
        };
        let v2 = u64_to_decimal_str(arg0 % v0 / pow10(((arg1 - arg2) as u64)));
        0x1::vector::push_back<u8>(&mut v1, 46);
        let v3 = 0;
        while (v3 < (arg2 as u64) - 0x1::vector::length<u8>(&v2)) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v1, v2);
        v1
    }

    public(friend) fun pow10(arg0: u64) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            1000
        } else if (arg0 == 4) {
            10000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            10000000
        } else if (arg0 == 8) {
            100000000
        } else if (arg0 == 9) {
            1000000000
        } else if (arg0 == 10) {
            10000000000
        } else if (arg0 == 11) {
            100000000000
        } else if (arg0 == 12) {
            1000000000000
        } else if (arg0 == 13) {
            10000000000000
        } else if (arg0 == 14) {
            100000000000000
        } else if (arg0 == 15) {
            1000000000000000
        } else if (arg0 == 16) {
            10000000000000000
        } else if (arg0 == 17) {
            100000000000000000
        } else {
            assert!(arg0 == 18, 3009);
            1000000000000000000
        }
    }

    public(friend) fun u64_to_decimal_str(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v7
}

