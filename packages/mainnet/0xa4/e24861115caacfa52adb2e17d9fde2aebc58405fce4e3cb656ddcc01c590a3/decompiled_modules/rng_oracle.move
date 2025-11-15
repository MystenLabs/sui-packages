module 0xa4e24861115caacfa52adb2e17d9fde2aebc58405fce4e3cb656ddcc01c590a3::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

