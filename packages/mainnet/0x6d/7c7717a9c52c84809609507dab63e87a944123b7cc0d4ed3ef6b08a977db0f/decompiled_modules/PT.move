module 0x6d7c7717a9c52c84809609507dab63e87a944123b7cc0d4ed3ef6b08a977db0f::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 6, b"PT for haSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PT>>(v0);
    }

    // decompiled from Move bytecode v6
}

