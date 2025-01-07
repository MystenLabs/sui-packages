module 0x150d08ba2252fe523bb794e7eb061a5dafa449426c964cbf328d1b9396be5846::math {
    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

