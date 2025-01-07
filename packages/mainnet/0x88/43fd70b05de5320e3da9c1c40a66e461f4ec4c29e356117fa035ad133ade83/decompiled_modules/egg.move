module 0x8843fd70b05de5320e3da9c1c40a66e461f4ec4c29e356117fa035ad133ade83::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"EGGTRUMP", x"4547475452554d50200a0a466169726c61756e6368696e6720646f6e74206d6973730a53616d6520646576206c61756e63680a0a5447203a2068747470733a2f2f742e6d652f2b494256786c5673644c664d795a474a68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5930_e14c5ec598.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

