module 0x3b3f31908ee301455423a6b00ff014447ecc44a9bc9dd0816db94bc4b7d2a0ad::suba {
    struct SUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBA>(arg0, 6, b"SUBA", b"Suibaracoin", b"Suibara is a fun and innovative meme coin that celebrates the lovable Suibara, known for its friendly demeanor and social nature. We believe in building a community where everyone can enjoy the lighter side of cryptocurrency while making meaningful connections.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043382_5c833985ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

