module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::safeguards {
    public fun anti_snipe_window_ms() : u64 {
        1000
    }

    public fun compute_windows(arg0: u64) : (u64, u64) {
        (arg0 + 1000, arg0 + 86400000)
    }

    public fun ms_per_day() : u64 {
        86400000
    }

    // decompiled from Move bytecode v6
}

