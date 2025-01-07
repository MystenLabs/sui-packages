module 0x15fe4eaddf21178d30af6085ba6d631f5648dea60b4ed6e26d409e76406d4737::sblack {
    struct SBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLACK>(arg0, 6, b"SBLACK", b"SUI BLACK", b"New black meta dog on SUI chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731275213206.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBLACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

