module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding {
    public fun encoded_blob_length(arg0: u64, arg1: u8, arg2: u16) : u64 {
        assert!(arg1 == 1, 0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::redstuff::encoded_blob_length(arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

