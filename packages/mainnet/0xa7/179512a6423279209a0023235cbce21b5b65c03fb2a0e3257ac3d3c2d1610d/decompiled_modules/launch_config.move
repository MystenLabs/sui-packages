module 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::launch_config {
    public(friend) fun keep_whole() : u64 {
        assert!(true, 1);
        80890
    }

    public fun keep_whole_view() : u64 {
        80890
    }

    public fun pinned() : bool {
        true
    }

    // decompiled from Move bytecode v7
}

