module 0x931051321bfad33a5e325a35ee2eaa70885982f599d9662e79ddb62ea6f21f95::clmm_common {
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

