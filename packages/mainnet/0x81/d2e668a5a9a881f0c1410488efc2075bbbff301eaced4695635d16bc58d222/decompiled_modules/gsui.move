module 0x81d2e668a5a9a881f0c1410488efc2075bbbff301eaced4695635d16bc58d222::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"GON ON SUI", x"4c6574277320676f20212068747470733a2f2f676f6e646f6c616f6e7375692e78797a0a68747470733a2f2f782e636f6d2f476f6e646f6c615f537569200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_14_7b2cd67bd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

