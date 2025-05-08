module 0x827cf9cc3d189985935e185904777eef3c58f67b8a3bda699de06f096e7a139::sco {
    struct SCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCO>(arg0, 6, b"SCO", b"The real coin of Sui", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cetus.zone/coin-metadata/mainnet/icon/3c86d496-1c05-440b-ab0f-fc7642fe9805.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

