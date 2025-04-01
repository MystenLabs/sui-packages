module 0xbf609bb629a11e7ee7c72bc3d5cf98c1c26cd2e35b2d017be4895d7e0c6be898::temps_sui {
    struct TEMPS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPS_SUI>(arg0, 9, b"TSUI", b"tmep sui", b"temp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.base64-image.de/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

