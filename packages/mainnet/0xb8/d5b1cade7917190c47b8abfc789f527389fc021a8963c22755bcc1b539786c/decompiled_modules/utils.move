module 0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::utils {
    public(friend) fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

