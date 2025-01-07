module 0xa165d8a7519b93745ebfc79ad6f7ea8778ad8822a8e1e216dce710e3c0f3921e::genz {
    struct GENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ>(arg0, 6, b"GENZ", b"GEN Z", x"54484520494e5445524e45542047454e45524154494f4e20f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954841529.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

