module 0xfcee96b2410d87d4603f6f92bb9138e13be7733a021afcc26771be35549b9cb8::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"PORING", b"PoringSui", x"24504f52494e470a5468652074727565206d656d6520746f6b656e206f6e2053756920626c6f636b636861696e2e7c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973570052.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

