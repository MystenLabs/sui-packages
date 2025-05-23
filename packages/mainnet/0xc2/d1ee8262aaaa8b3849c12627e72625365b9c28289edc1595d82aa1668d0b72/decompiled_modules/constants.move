module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::constants {
    struct Constants has drop {
        dummy_field: bool,
    }

    public fun MAX_NAME_LENGTH() : u64 {
        64
    }

    public fun MAX_XPIK_SIZE() : u64 {
        32
    }

    public fun MIN_NAME_LENGTH() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

