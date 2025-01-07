module 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::math {
    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

