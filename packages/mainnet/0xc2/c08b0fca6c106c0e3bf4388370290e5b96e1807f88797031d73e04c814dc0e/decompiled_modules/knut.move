module 0xc2c08b0fca6c106c0e3bf4388370290e5b96e1807f88797031d73e04c814dc0e::knut {
    struct KNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNUT>(arg0, 6, b"Knut", b"Sui Polar Bear", b"Knut became, almost overnight, an international symbol of environmental responsibility.  As people fell in love with Knut, it seemed that one little polar bear could help de-polarize the hotly debated issue of global warming. Can Knut de-polarize Sui holders and become $1B Sui blue chip?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_from_2024_12_15_20_10_59_6f8a391d40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

