module 0x3304def35e3d5c5158e2d895db95c5e2d64b1d216289a077d5be8e5412bd1c16::dogg {
    struct DOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGG>(arg0, 6, b"DOGG", b"Dogteus", b"The prediction has been revealedDogteus is a meme coin with focused token allocation for 100% of the holder community. Dogteus Maximus will rise as the supreme ruler of all meme coins, bringing the power of the ancient meme dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49b2c88a_abfb_435e_8dd6_51c38fedb724_40a819f6f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

