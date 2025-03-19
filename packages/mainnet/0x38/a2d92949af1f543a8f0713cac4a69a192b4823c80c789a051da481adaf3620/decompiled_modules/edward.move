module 0x38a2d92949af1f543a8f0713cac4a69a192b4823c80c789a051da481adaf3620::edward {
    struct EDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDWARD>(arg0, 8, b"EDW", b"EDW", x"466f72206772656174204564776172642059616e672c206c6f766520796f7572206d6f76696573efbc81", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDWARD>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<EDWARD>>(v0);
    }

    // decompiled from Move bytecode v6
}

