module 0x80c9d4eb2f358ee3c6d249402954e0b51fbbd993053f1d2e2999370aed799fcc::utils {
    public(friend) fun assert_foreign_address_length(arg0: u64, arg1: &vector<u8>) {
        let v0 = if (arg0 == 1) {
            32
        } else {
            20
        };
        assert!(0x1::vector::length<u8>(arg1) == v0, 51);
    }

    // decompiled from Move bytecode v6
}

