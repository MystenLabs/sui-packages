module 0xd890669911675e35a6adc7dfa79f41e53847ec29ea3ec6ce72613fc48909984c::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"Ghibli Sui", b"The Suivengers have been Ghiblified", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_65_b81c9c2c9d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

