module 0x242bd573d8e9220cad3b8f426eb0cb78f6e8dfc06072f32e584a0c89ecd0c49a::dotnt {
    struct DOTNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTNT>(arg0, 6, b"DOTNT", b"Dont Invest Coin", b"DOTNT - JUST A MEME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020690_d807e6d4bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

