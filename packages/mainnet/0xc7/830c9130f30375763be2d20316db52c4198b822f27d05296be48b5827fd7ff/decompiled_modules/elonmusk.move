module 0xc7830c9130f30375763be2d20316db52c4198b822f27d05296be48b5827fd7ff::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELONMUSK>(arg0, 6, b"ELONMUSK", b"ElonMusk by SuiAI", b"ElonMusk IA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Anime_XL_Meme_of_pixelated_cat_with_exaggerated_and_c_0_8b43dce2c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELONMUSK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

