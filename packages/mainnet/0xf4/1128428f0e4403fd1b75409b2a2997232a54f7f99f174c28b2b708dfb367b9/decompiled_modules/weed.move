module 0xf41128428f0e4403fd1b75409b2a2997232a54f7f99f174c28b2b708dfb367b9::weed {
    struct WEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEED>(arg0, 6, b"WEED", b"Sui Weed", b"$WEED - a culture coin designed to connect degens, meme connoiseurs & cannabis enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002759_53f1c3a9bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

