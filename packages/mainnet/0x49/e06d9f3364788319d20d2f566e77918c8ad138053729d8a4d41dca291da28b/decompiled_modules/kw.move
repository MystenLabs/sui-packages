module 0x49e06d9f3364788319d20d2f566e77918c8ad138053729d8a4d41dca291da28b::kw {
    struct KW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KW>(arg0, 6, b"KW", b"GBCMOBILE", b"Providing a comprehensive digital currency based on digital currencies to support sustainable growth in the mobile phone and accessories sector, while providing innovative financial services ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730626871598.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

