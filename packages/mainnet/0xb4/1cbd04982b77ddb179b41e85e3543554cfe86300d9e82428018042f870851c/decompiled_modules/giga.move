module 0xb41cbd04982b77ddb179b41e85e3543554cfe86300d9e82428018042f870851c::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"GigaChad", b"Giga Chad Fitness. Lifestyle Brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731092751524.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

