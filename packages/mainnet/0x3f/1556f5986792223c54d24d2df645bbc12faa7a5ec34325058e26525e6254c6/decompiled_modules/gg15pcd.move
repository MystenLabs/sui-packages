module 0x3f1556f5986792223c54d24d2df645bbc12faa7a5ec34325058e26525e6254c6::gg15pcd {
    struct GG15PCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG15PCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG15PCD>(arg0, 0, b"GG15PCD", b"Sui Blue Gift Owner G15PCD", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG15PCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GG15PCD>>(0x2::coin::mint<GG15PCD>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG15PCD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

