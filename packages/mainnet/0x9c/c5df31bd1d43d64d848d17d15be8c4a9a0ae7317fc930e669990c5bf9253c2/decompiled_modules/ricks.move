module 0x9cc5df31bd1d43d64d848d17d15be8c4a9a0ae7317fc930e669990c5bf9253c2::ricks {
    struct RICKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKS>(arg0, 6, b"RICKS", b"Rick Sui", b"Wubba Lubba Dub Dub!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicebmrrxnmeuon2gnu2wtfbez2iusscyil3uw3h6gocc6qxsytsnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

