module 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::deck {
    public fun burn_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) {
        draw_card(arg0, arg1, arg2, arg3);
    }

    public fun derive_entropy(arg0: &vector<u8>, arg1: address, arg2: u64) : u64 {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun draw_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : u8 {
        *arg3 = *arg3 + 1;
        0x1::vector::swap_remove<u8>(arg0, derive_entropy(arg1, arg2, *arg3) % (0x1::vector::length<u8>(arg0) as u64))
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

