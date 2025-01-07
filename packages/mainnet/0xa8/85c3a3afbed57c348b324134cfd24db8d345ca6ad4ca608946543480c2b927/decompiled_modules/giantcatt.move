module 0xa885c3a3afbed57c348b324134cfd24db8d345ca6ad4ca608946543480c2b927::giantcatt {
    struct GIANTCATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIANTCATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIANTCATT>(arg0, 6, b"GIANTCATT", b"Giant Cat", b"Giant Cat is a meme coin inspired by giant cats, bringing humor and fun to the crypto world. Focused on a vibrant community and the viral power of memes, it aims to attract enthusiasts who love meme culture and the world of cats, with growth potential driven by online engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/width_700_3a64659b17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIANTCATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIANTCATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

