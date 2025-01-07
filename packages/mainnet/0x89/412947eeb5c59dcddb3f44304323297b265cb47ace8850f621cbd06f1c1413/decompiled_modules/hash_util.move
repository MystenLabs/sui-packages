module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::hash_util {
    public fun hash_inscription(arg0: u8, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u128) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u8>(&arg0);
        let v1 = &v0;
        v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(v1, 0x1::bcs::to_bytes<u64>(&arg1));
        let v2 = &v0;
        v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(v2, 0x1::bcs::to_bytes<address>(&arg2));
        let v3 = &v0;
        v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(v3, 0x1::bcs::to_bytes<u64>(&arg3));
        let v4 = &v0;
        v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(v4, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::hash::sha3_256(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(&v0, 0x1::bcs::to_bytes<u128>(&arg5)))
    }

    // decompiled from Move bytecode v6
}

