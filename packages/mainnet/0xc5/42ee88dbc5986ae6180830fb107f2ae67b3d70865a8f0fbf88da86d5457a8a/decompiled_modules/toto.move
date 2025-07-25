module 0xc542ee88dbc5986ae6180830fb107f2ae67b3d70865a8f0fbf88da86d5457a8a::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"TOTOSUI", b"A cheekiest meme token on Sui too! If you missed $CULO, get on $TOTO now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiafxgcuohenkd4banfjgz36zexguojkrf7twyglpslpuhrg3dlydi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

