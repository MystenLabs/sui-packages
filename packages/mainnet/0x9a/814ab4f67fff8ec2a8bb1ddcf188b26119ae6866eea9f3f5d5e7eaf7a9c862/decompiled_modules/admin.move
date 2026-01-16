module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::admin {
    struct Admin has drop {
        dummy_field: bool,
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

