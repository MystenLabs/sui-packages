module 0x5e42466c68fcbcf5d1f79291d745a73c0ed0450e554c8c9d5c2fae924b240f5b::pool {
    public fun flash_swap(arg0: &0x5e42466c68fcbcf5d1f79291d745a73c0ed0450e554c8c9d5c2fae924b240f5b::swap_pool::SwapPool) : u64 {
        0x5e42466c68fcbcf5d1f79291d745a73c0ed0450e554c8c9d5c2fae924b240f5b::swap_pool::get_current_balance(arg0)
    }

    // decompiled from Move bytecode v6
}

