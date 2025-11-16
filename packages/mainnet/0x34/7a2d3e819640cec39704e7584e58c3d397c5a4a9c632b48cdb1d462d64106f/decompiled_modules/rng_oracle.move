module 0x347a2d3e819640cec39704e7584e58c3d397c5a4a9c632b48cdb1d462d64106f::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

