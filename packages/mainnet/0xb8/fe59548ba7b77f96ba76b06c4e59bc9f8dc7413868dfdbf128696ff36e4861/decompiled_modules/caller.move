module 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::caller {
    struct PIX has drop {
        version: u32,
    }

    public(friend) fun get_caller() : PIX {
        PIX{version: 1}
    }

    // decompiled from Move bytecode v6
}

