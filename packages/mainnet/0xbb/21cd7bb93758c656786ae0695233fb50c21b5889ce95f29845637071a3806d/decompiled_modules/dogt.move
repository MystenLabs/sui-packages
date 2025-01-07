module 0xbb21cd7bb93758c656786ae0695233fb50c21b5889ce95f29845637071a3806d::dogt {
    struct DOGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGT>(arg0, 6, b"DOGT", b"Dogteus", b"The prediction has been revealed. Dogteus is a meme coin with focused token allocation for 100% of the holder community. Dogteus Maximus will rise as the supreme ruler of all meme coins, bringing the power of the ancient meme dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49b2c88a_abfb_435e_8dd6_51c38fedb724_178be5be81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

