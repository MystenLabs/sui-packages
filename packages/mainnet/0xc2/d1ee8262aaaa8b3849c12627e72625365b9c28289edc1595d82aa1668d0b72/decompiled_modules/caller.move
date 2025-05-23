module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller {
    struct PINS has drop {
        version: u32,
    }

    public(friend) fun get_caller() : PINS {
        PINS{version: 1}
    }

    // decompiled from Move bytecode v6
}

