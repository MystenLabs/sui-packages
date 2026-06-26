module 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::deck {
    public fun draw_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 1);
        0x1::vector::remove<u8>(arg0, pick(arg1, arg2, arg3, v0))
    }

    fun pick(arg0: &vector<u8>, arg1: address, arg2: &mut u64, arg3: u64) : u64 {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg1)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(*arg2)));
        *arg2 = *arg2 + 1;
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 << 8;
            v2 = v4 + (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2 % arg3
    }

    public fun standard_deck() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

