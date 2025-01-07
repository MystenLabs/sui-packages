module 0xe0d895d438ef5344c9f777dfe678e63d279fe2aac041c1b2e2144b341c8c7666::bbll {
    struct BBLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLL>(arg0, 6, b"BBLL", b"BLUE BULL", x"546869732069732061207265616c20746f6b656e2c20697420776173206372656174656420776974682074686520676f616c206f6620676174686572696e67206c696b652d6d696e6465642070656f706c6520696e2074686520646576656c6f706d656e74206f662074686520737569206e6574776f726b2c206a6f696e20757320616e64206c6574732074616b6520746f6b656e20746f2074686520666f726566726f6e7420746f676574686572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_14_50_59_A_promotional_image_for_the_Blue_Bull_token_featuring_the_cute_and_cartoonish_blue_bull_mascot_with_big_round_eyes_and_a_cheerful_expression_The_ae9af7dfe1_c8aea12058.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

