module 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::timestamp_privacy {
    public(friend) fun deoffset_timestamp_ms(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1);
        arg0 - arg1
    }

    public(friend) fun offset_timestamp_ms(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 0);
        arg0 + arg1
    }

    // decompiled from Move bytecode v6
}

