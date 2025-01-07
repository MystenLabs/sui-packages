module 0xb201d1b3d3d1ba36d03e3255e5c05435032ffcc0630f3bafb4ddbf8d1f341479::suirekt {
    struct SUIREKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREKT>(arg0, 9, b"SREKT", b"SUIRekt", b"Rekt SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREKT>>(v1);
        0x2::coin::mint_and_transfer<SUIREKT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUIREKT>>(v2);
    }

    // decompiled from Move bytecode v6
}

