module 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::encoding {
    public fun encoded_blob_length(arg0: u64, arg1: u8, arg2: u16) : u64 {
        assert!(arg1 == 0 || arg1 == 1, 0);
        0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::redstuff::encoded_blob_length(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

