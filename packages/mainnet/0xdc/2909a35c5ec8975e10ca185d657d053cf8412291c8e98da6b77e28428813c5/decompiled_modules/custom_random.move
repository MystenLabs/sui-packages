module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::custom_random {
    public(friend) fun get_lucky_number(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u32) : u64 {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        let v1 = 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::drand_lib::derive_randomness(0x2::hash::keccak256(&v0));
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::drand_lib::safe_selection((arg3 as u64), &v1)
    }

    // decompiled from Move bytecode v6
}

