module 0x852a84284180ffe4d8e339c8e9bc3b9afe917f7489d7938620813aa7f0ee5381::superSui {
    struct SUPERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSUI>(arg0, 9, b"sysuperSUI", b"SY superSUI", b"SY superSUI (superSUI)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

