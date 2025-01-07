module 0xbb184f618984c42c37333437b85133b0797ede3bb9aef57615c22dc3fb190ce9::sslty {
    struct SSLTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSLTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSLTY>(arg0, 6, b"SSLTY", b"Suisalty", b"Feeling a little salty? So is SUIsalty, the meme coin that brings the perfect mix of sass and spice to the crypto world! Powered by the reliable SUI network, SUIsalty is here to shake things up. With a pinch of attitude and a dash of fun, this coin is ready to leave its mark on the blockchain and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cute_meme_of_sea_s_732ef0a397.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSLTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSLTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

