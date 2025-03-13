module 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::encoding {
    public fun encoded_blob_length(arg0: u64, arg1: u8, arg2: u16) : u64 {
        assert!(arg1 == 1, 0);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::redstuff::encoded_blob_length(arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

