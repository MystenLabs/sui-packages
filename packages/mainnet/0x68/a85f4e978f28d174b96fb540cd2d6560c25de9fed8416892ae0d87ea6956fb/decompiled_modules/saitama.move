module 0x68a85f4e978f28d174b96fb540cd2d6560c25de9fed8416892ae0d87ea6956fb::saitama {
    struct SAITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAITAMA>(arg0, 6, b"SAITAMA", b"SAITAMA", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAITAMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

