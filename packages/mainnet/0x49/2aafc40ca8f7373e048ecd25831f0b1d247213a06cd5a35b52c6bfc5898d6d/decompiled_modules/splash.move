module 0x492aafc40ca8f7373e048ecd25831f0b1d247213a06cd5a35b52c6bfc5898d6d::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"Splasher", b"moving through the blockchain one splash at a time (relaunch)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splashermainpic_8cc90ae977.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

