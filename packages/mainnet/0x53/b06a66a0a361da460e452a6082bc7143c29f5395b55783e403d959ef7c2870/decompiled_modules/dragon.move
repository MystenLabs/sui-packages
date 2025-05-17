module 0x53b06a66a0a361da460e452a6082bc7143c29f5395b55783e403d959ef7c2870::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"Sui Dragon", b"The best Dragon on sui network!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiglf6dpf2pc6ffsulseqsmaynrtvr5bovic3352ainargjwpflpwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

