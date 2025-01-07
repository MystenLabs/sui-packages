module 0x1067244a1e0427c3ce1a5cf83a7feee60743cb1689ca423e11c5eee988194a08::ggmu {
    struct GGMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGMU>(arg0, 6, b"GGMU", b"Man United", b"It is official Man United is launching its fan token on SUI. Join the community to get a chance to meet your favourite players", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731488160973.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

