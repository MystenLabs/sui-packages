module 0x643b9b5ae37e871e6776d488cdf1e153c5227a45e5bcc5799c97215ddfa67d33::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 6, b"LCAT", x"f09f9088e2808de2ac9b4c494c434154f09f9088e2808de2ac9b", x"f09f9088e2808de2ac9b2074686520736d616c6c657374202f63757465737420636174206f6e2053554920f09f9088e2808de2ac9b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734258898142.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

