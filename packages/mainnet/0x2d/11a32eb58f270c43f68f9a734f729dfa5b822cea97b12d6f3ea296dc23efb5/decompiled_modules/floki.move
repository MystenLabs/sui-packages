module 0x2d11a32eb58f270c43f68f9a734f729dfa5b822cea97b12d6f3ea296dc23efb5::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"FLOKI", b"Floki on sui", b"the new floki on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/floki_52648a6827.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

