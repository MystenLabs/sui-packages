module 0xef1c0a92c14c71fb9b8b83294eadcc2593ac16c12a49cbcb469989005a082543::catf {
    struct CATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATF>(arg0, 6, b"CATF", b"CATFISH SUI", b"Its a Cat.. Its a Fish.. Its Catfish on SUI! https://catfishsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xf217249507c83f0d404b096c1f79194c3290d9c26b453cd78c95d2062f76812d_fish_fish_1bf0a18249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATF>>(v1);
    }

    // decompiled from Move bytecode v6
}

