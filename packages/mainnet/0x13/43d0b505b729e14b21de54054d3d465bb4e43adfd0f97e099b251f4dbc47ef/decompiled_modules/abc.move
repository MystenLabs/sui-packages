module 0x1343d0b505b729e14b21de54054d3d465bb4e43adfd0f97e099b251f4dbc47ef::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 9, b"ABC", b"ABC", b"Just a test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ABC>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

