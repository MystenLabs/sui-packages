module 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::encoding {
    public fun encoded_blob_length(arg0: u64, arg1: u8, arg2: u16) : u64 {
        assert!(arg1 == 1, 0);
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::redstuff::encoded_blob_length(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

