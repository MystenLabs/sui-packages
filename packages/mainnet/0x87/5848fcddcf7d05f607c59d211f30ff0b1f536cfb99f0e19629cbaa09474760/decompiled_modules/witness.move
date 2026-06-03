module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::witness {
    struct WaterXPerp has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : WaterXPerp {
        WaterXPerp{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

