module 0x2838031f3b57e62746f34f99c9d614ca64edc4d9e5dc9323b384b1951a4a97bb::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

