module 0x8da024f7860cc082bb60111369e6bad234899e5b29c41d8405a97782e25f7ec5::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 7, b"FLIP", b"Chainflip", b"ChainFlip on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLIP>(&mut v2, 90000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

