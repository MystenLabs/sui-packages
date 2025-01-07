module 0x9023802b00ccf6025e93d292984cc3b3cf378dd0c9b7b09d2ddf0d347473e5af::cdot {
    struct CDOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDOT>(arg0, 6, b"CDOT", b"Crocodotter", b"Double the love for fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ICON_77eb783a9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

