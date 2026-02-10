module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::encoding {
    public fun encoded_blob_length(arg0: u64, arg1: u8, arg2: u16) : u64 {
        assert!(arg1 == 1, 0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::redstuff::encoded_blob_length(arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

