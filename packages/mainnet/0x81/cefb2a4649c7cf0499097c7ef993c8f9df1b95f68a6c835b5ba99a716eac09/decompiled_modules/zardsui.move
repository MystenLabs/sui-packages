module 0x81cefb2a4649c7cf0499097c7ef993c8f9df1b95f68a6c835b5ba99a716eac09::zardsui {
    struct ZARDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARDSUI>(arg0, 6, b"ZardSui", b"CHARIZARD", b"Blazing onto the Sui blockchain, CHARIZARD is the ultimate meme token with zero fluff and all fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibeq4hwwwgtkemuqax7sr3qjpnobt6gqpy36pk3efkw2lldlmpw5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZARDSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

