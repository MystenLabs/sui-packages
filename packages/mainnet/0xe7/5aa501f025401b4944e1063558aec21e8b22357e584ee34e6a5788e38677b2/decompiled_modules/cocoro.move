module 0xe75aa501f025401b4944e1063558aec21e8b22357e584ee34e6a5788e38677b2::cocoro {
    struct COCORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCORO>(arg0, 9, b"Cocoro", b"Cocoro On Sui", x"546865206e6577657374206d656d626572206f66206b61626f73752066616d696c790d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdNxyAdk8uF2M7k97P3ETYpvEqGX21nuxKGDoEmBQvuDc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COCORO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCORO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

