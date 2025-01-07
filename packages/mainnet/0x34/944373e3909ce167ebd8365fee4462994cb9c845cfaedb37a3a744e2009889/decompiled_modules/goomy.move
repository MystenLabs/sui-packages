module 0x34944373e3909ce167ebd8365fee4462994cb9c845cfaedb37a3a744e2009889::goomy {
    struct GOOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOMY>(arg0, 6, b"GOOMY", b"Sui Goomy", b"Born slimy, raised gritty, and trained in the crypto trenches, Goomy is the squishiest trenchwarrior you'll ever meet. Dont let the exterior fool youthis little guy is tougher than a bear market and more locked in than you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049410_5e99f1f40f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

