module 0xe9f0e5b63f667cdcbe3f2676c305ca88e9e3e2e47d0e962f543c4a60db875bc4::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"SANTA", b"SANTA COIN ON SUI", x"5765207769736820796f752061206d65727279204368726973746d617320616e642061204861707079204e65772059656172210a0a54473a2068747470733a2f2f742e6d652f73616e74616f6e7375690a547769747465723a2068747470733a2f2f782e636f6d2f53414e54414f4e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_SANTA_c611b7f97c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

