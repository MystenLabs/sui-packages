module 0x66a28ae668e09c3b932ccfb25332005e2116b83b28c3442798ff02d526bc5fdb::math {
    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

