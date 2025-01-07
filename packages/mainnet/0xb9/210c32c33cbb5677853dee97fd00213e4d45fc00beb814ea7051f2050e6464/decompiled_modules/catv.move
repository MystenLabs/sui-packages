module 0xb9210c32c33cbb5677853dee97fd00213e4d45fc00beb814ea7051f2050e6464::catv {
    struct CATV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATV>(arg0, 6, b"CATV", b"CATVERSE", b"Catverse is an innovative memetoken launched on the SUI with the aim of revolutionizing interaction in the crypto space. Through the development of a virtual assistant on Telegram and an integrated game in the metaverse, Catverse seeks to create an engaged community and an immersive experience for users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_22_54_53_e4c6f86924.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATV>>(v1);
    }

    // decompiled from Move bytecode v6
}

