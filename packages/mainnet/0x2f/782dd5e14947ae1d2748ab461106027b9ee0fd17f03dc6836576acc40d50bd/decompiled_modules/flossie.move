module 0x2f782dd5e14947ae1d2748ab461106027b9ee0fd17f03dc6836576acc40d50bd::flossie {
    struct FLOSSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOSSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOSSIE>(arg0, 6, b"FLOSSIE", b"Oldest Cat", b"Oldest Living Cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004433_1dcecb5f30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOSSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOSSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

