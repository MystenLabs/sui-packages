module 0x1036bc1d4ca238f10ddd581fd5f803869fc7fcee3f459e616a1bfe6ca8dcb05d::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 6, b"SAPE", b"SuiAPE", b"Meet SuiAPE the ape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gg_1bf920e1a8_e301435dbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

