module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys {
    struct EggWhitelist has copy, drop, store {
        wl_address: address,
    }

    struct EggImage has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun egg_image() : EggImage {
        EggImage{dummy_field: false}
    }

    public(friend) fun egg_whitelist(arg0: address) : EggWhitelist {
        EggWhitelist{wl_address: arg0}
    }

    // decompiled from Move bytecode v6
}

