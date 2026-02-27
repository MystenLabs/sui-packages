module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::signal {
    public(friend) fun gen_noise(arg0: &0x2::object::ID) : u16 {
        let v0 = 0x1::hash::sha3_256(0x2::bcs::to_bytes<0x2::object::ID>(arg0));
        ((((*0x1::vector::borrow<u8>(&v0, 0) as u32) << 24 | (*0x1::vector::borrow<u8>(&v0, 1) as u32) << 16 | (*0x1::vector::borrow<u8>(&v0, 2) as u32) << 8 | (*0x1::vector::borrow<u8>(&v0, 3) as u32)) % 10000) as u16)
    }

    public(friend) fun tag_channel(arg0: 0x1::string::String, arg1: u8) : 0x1::string::String {
        assert!(arg1 <= 1, 1);
        let v0 = 0x1::string::into_bytes(arg0);
        *0x1::vector::borrow_mut<u8>(&mut v0, 2) = 48 + arg1;
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

