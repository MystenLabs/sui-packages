module 0x88293f7a06300156d6924bbd0a405f3ab3a94d1b748f85bc68f1b9b89b8b8f77::suiwoman {
    struct SUIWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMAN>(arg0, 6, b"SUIWOMAN", b"SUI WOMAN", b"Suiwoman ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5528_1d9f888ba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

