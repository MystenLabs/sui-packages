module 0x6c18a4acd4dbc9e7da78ab4aa45d5d92886216119c07b79d3107313d8ff223dc::pako {
    struct PAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKO>(arg0, 6, b"PAKO", b"Pako On Sui", b"Not every bird need to fly some just vibe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigh7nt7fka2om5lrdxwncknn7dz5dhprtdafwdr2jgeaqn4pczcom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

