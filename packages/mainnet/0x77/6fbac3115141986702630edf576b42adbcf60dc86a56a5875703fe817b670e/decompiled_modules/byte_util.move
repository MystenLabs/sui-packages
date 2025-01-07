module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util {
    public fun concat(arg0: &vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun count_bits(arg0: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            if (arg0 & 1 == 1) {
                v0 = v0 + 1;
            };
            arg0 = arg0 >> 1;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

