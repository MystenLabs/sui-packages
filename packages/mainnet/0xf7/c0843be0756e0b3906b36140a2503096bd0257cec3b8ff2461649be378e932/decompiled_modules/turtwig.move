module 0xf7c0843be0756e0b3906b36140a2503096bd0257cec3b8ff2461649be378e932::turtwig {
    struct TURTWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTWIG>(arg0, 6, b"Turtwig", b"Turtwig SuI", b"Turtwig is a Grass type Pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibene56kollwueqxifonu7hxjbdgokmto2ndmsuenbfc5cbfnqr2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURTWIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

