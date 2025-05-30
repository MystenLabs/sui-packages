module 0x6c7c11cfac2165ff9e1a21f505255b023e41fdcd6e1b4fb23fad32daf7cba27b::catzo {
    struct CATZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZO>(arg0, 6, b"CATZO", b"Catzo Meme", b"We are clawn embrace themovement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsmf23pdxihdsdg6su5w57rfy4fjrzgi5mrzffsxptemjgzz6bm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

