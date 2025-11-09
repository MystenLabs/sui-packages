module 0x72031f9f9432b39416d586daa66af521c967f7002022369e71a456b018ccbc8e::encrypter {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x72031f9f9432b39416d586daa66af521c967f7002022369e71a456b018ccbc8e::collectivo::AdminCap, arg2: &0x72031f9f9432b39416d586daa66af521c967f7002022369e71a456b018ccbc8e::campaign::Campaign) {
        assert!(0x2::object::id_bytes<0x72031f9f9432b39416d586daa66af521c967f7002022369e71a456b018ccbc8e::campaign::Campaign>(arg2) == arg0, 0);
    }

    // decompiled from Move bytecode v6
}

