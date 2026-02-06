module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::seal_approve {
    entry fun seal_approve(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap) {
        approve_internal(arg0, arg1, arg2);
    }

    fun approve_internal(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap) {
        let v0 = 0x2::object::id_to_bytes(&arg1);
        assert!(is_prefix(&v0, &arg0), 2);
        assert!(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::channel_id(arg2) == arg1, 1);
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 > 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

