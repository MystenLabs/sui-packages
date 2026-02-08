module 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::utils {
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

