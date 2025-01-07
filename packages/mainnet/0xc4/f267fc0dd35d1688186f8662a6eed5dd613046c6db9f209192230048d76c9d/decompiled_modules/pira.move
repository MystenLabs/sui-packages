module 0xc4f267fc0dd35d1688186f8662a6eed5dd613046c6db9f209192230048d76c9d::pira {
    struct PIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRA>(arg0, 6, b"PIRA", b"PiranhaOnsui", b"$PIRA The new meme coin On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_183229_4577bc74ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

