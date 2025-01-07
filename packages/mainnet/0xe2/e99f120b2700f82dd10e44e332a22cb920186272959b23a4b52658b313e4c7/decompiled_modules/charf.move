module 0xe2e99f120b2700f82dd10e44e332a22cb920186272959b23a4b52658b313e4c7::charf {
    struct CHARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARF>(arg0, 6, b"CHARF", b"Chad Dog", b"Chad Dog is a blend of the Chad and Shibu Inu meme cultures prevalent within the crypto space. But with a twist....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049420_53bad421bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

