module 0x97cefd596a19a48817736e538ad8fce99aa2b03bfc17ac5a471c4e175498f60e::lilsui {
    struct LILSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILSUI>(arg0, 6, b"LILSUI", x"f09f9088e2808de2ac9b204c494c53554920f09f9088e2808de2ac9b", x"f09f9088e2808de2ac9b2074686520736d616c6c657374202f63757465737420636174206f6e2053554920f09f9088e2808de2ac9b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734258898142.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LILSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

