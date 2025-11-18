module 0xb26c83c01ac12770c01dd3665cef7e063b91a912d4b344928c66671f9c812be4::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

