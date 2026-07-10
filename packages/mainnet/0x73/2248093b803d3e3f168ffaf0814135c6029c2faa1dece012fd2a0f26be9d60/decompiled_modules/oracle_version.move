module 0x732248093b803d3e3f168ffaf0814135c6029c2faa1dece012fd2a0f26be9d60::oracle_version {
    public fun next_version() : u64 {
        0x732248093b803d3e3f168ffaf0814135c6029c2faa1dece012fd2a0f26be9d60::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x732248093b803d3e3f168ffaf0814135c6029c2faa1dece012fd2a0f26be9d60::oracle_constants::version(), 0x732248093b803d3e3f168ffaf0814135c6029c2faa1dece012fd2a0f26be9d60::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x732248093b803d3e3f168ffaf0814135c6029c2faa1dece012fd2a0f26be9d60::oracle_constants::version()
    }

    // decompiled from Move bytecode v7
}

