module 0x50f82deab7c120c47b5f12bc09e36313921a39ee6ee76d9d63e94ea402935a2a::test {
    public fun test_fn<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

