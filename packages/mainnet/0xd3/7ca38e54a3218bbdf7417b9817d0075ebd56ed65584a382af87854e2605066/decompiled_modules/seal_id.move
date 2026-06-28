module 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::seal_id {
    public fun decode(arg0: vector<u8>) : (0x2::object::ID, u64) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 40, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::bad_id());
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(&arg0, v0 - 8 + v2) as u64) << ((8 * v2) as u8));
            v2 = v2 + 1;
        };
        let v3 = b"";
        let v4 = 0;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg0, v0 - 40 + v4));
            v4 = v4 + 1;
        };
        (0x2::object::id_from_address(0x2::address::from_bytes(v3)), v1)
    }

    public fun encode(arg0: 0x2::object::ID, arg1: u64) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    // decompiled from Move bytecode v7
}

