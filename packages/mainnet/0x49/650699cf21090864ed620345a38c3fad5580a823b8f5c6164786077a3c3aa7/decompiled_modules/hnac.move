module 0x49650699cf21090864ed620345a38c3fad5580a823b8f5c6164786077a3c3aa7::hnac {
    struct HNAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNAC>(arg0, 6, b"HNAC", b"HornyAcorn", x"2047657420596f75722053746173682047726f77696e67207769746820486f726e7941636f726e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4992_9863946719.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

