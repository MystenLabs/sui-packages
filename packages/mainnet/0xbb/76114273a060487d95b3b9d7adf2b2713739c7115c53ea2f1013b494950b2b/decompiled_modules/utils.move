module 0x2de1232ad4416d44c0563766c6d346cfa5bfe900c97078ae3cb356ef6c890900::utils {
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

