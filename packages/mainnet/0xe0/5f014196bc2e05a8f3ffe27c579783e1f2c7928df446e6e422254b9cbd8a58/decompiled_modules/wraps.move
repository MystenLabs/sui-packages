module 0xe05f014196bc2e05a8f3ffe27c579783e1f2c7928df446e6e422254b9cbd8a58::wraps {
    struct WRAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAPS>(arg0, 6, b"WRAPS", b"NGL It's Wraps", b"It's Wraps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_35e164d818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

