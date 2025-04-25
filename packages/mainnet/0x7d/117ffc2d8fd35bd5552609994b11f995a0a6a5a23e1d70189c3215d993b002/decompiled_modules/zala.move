module 0x7d117ffc2d8fd35bd5552609994b11f995a0a6a5a23e1d70189c3215d993b002::zala {
    struct ZALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZALA>(arg0, 9, b"ZALA", x"5ae296b34ce296b320e296b349", b"Zala AI, the artificial influencer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUaDbuzVdFZy4uvH4tNsFq8byXnq2SiCfM1zudfQs1EhZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZALA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZALA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

