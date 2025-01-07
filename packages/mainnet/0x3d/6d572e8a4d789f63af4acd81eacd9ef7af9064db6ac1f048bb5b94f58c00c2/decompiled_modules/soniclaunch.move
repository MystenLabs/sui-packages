module 0x3d6d572e8a4d789f63af4acd81eacd9ef7af9064db6ac1f048bb5b94f58c00c2::soniclaunch {
    struct SONICLAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONICLAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONICLAUNCH>(arg0, 6, b"SonicLaunch", b"Sonic Snipe Bot Launching Today!", b"Raising Awareness of Sonic Snipe Bot Launching in 6 hours from now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_01_09_09_aff4d2dfb0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONICLAUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONICLAUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

