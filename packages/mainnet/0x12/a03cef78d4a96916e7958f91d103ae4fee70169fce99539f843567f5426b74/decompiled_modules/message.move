module 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message {
    fun addr_at(arg0: &vector<u8>, arg1: u64) : address {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun be_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun be_u32(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun burn_body(arg0: address, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>) : vector<u8> {
        let v0 = x"00000001";
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        let v3 = &mut v0;
        push_be_u256(v3, (arg1 as u256));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        let v4 = &mut v0;
        push_be_u256(v4, 0);
        let v5 = &mut v0;
        push_be_u256(v5, (arg3 as u256));
        let v6 = &mut v0;
        push_be_u256(v6, 0);
        0x1::vector::append<u8>(&mut v0, arg4);
        v0
    }

    public fun burn_fields(arg0: &vector<u8>) : (address, u64, address, u64, vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 228 && be_u32(arg0, 0) == 1, 200);
        let v0 = be_u256(arg0, 68);
        let v1 = be_u256(arg0, 164);
        assert!(v0 <= 18446744073709551615 && v1 <= v0, 200);
        let v2 = b"";
        let v3 = 228;
        while (v3 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        (addr_at(arg0, 36), (v0 as u64), addr_at(arg0, 100), (v1 as u64), v2)
    }

    public fun buy_hook(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: address, arg5: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, kind_buy());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        let v3 = &mut v0;
        push_u64(v3, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        let v4 = &mut v0;
        push_u64(v4, arg5);
        v0
    }

    public fun home_hook(arg0: &vector<u8>) : (u8, u64, address) {
        assert!(0x1::vector::length<u8>(arg0) >= 42 && *0x1::vector::borrow<u8>(arg0, 0) == 1, 200);
        let v0 = *0x1::vector::borrow<u8>(arg0, 1);
        assert!(v0 == kind_refund() && 0x1::vector::length<u8>(arg0) == 42 || v0 == kind_sale() && 0x1::vector::length<u8>(arg0) == 50, 200);
        (v0, le_u64(arg0, 2), addr_at(arg0, 10))
    }

    public fun kind_buy() : u8 {
        1
    }

    public fun kind_refund() : u8 {
        2
    }

    public fun kind_sale() : u8 {
        3
    }

    fun le_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 8;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64);
        };
        v0
    }

    fun push_be_u256(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 32;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> ((8 * v1) as u8) & 255) as u8));
        };
    }

    fun push_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 8) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v0 & 255) as u8));
            v0 = v0 + 1;
        };
    }

    public fun refund_hook(arg0: u64, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, kind_refund());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        v0
    }

    public fun sale_hook(arg0: u64, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, kind_sale());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v3 = &mut v0;
        push_u64(v3, arg2);
        v0
    }

    // decompiled from Move bytecode v7
}

