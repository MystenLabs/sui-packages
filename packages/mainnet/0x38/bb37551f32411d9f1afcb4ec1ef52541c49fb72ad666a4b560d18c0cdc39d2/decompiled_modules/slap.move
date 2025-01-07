module 0x38bb37551f32411d9f1afcb4ec1ef52541c49fb72ad666a4b560d18c0cdc39d2::slap {
    struct SLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAP>(arg0, 6, b"SLAP", b"SLAP SUI", x"576520534c415020616e6420676f20424c415020424c41502e0a0a537072617920686172642c2073707261792066696572636520616e64206d6f7374206f6620616c6c2073707261792064656570207e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/use1_6f46d5d929.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

