module 0xb030c6ad41c362df5c724c39b5ab1a25ce84c5bd32fae96688a7a1b4b70157d3::clmm_common {
    public fun resolve_tick_window(arg0: 0x1::option::Option<u64>, arg1: u32) : u64 {
        if (0x1::option::is_some<u64>(&arg0)) {
            *0x1::option::borrow<u64>(&arg0)
        } else {
            tick_window_size(arg1)
        }
    }

    public fun tick_window_size(arg0: u32) : u64 {
        if (arg0 <= 2) {
            100
        } else if (arg0 <= 20) {
            75
        } else if (arg0 <= 60) {
            50
        } else if (arg0 <= 200) {
            30
        } else {
            20
        }
    }

    // decompiled from Move bytecode v7
}

