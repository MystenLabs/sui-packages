module 0xd42bf1cbd90e3f6706bd3a5d414e9e89f81626bbf4850037c809fa0be4e29d0f::tenant_points {
    struct TENANT_POINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENANT_POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENANT_POINTS>(arg0, 6, b"TPTS", b"Tenant Points", b"Thanks for being a great tenant. Points expire soon.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENANT_POINTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENANT_POINTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

