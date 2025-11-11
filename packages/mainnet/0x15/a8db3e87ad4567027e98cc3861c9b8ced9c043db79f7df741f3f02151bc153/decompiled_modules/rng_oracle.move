module 0x15a8db3e87ad4567027e98cc3861c9b8ced9c043db79f7df741f3f02151bc153::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

