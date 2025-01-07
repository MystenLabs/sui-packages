module 0xcfeb72c6739dc6fc07e81706f08347a2bd3345f7674c67ebdd99beec658f8824::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"Suimon", x"4d656574205375696d6f6e202c2074686520746f6b656e2074686174206272696e6773207468652073616c6d6f6e207669626520746f2074686520537569206e6574776f726b2120466173742c207365637572652c20616e642066756c6c206f6620656e657267792c207065726665637420666f722074686f73652077686f2077616e7420746f207377696d207468652063727970746f2077617665732e204a6f696e20746865205375696d6f6e20636f6d6d756e69747920616e642062652070617274206f6620746869732063757272656e74206f662073756363657373212020235375696d6f6e20235375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_08_14_57_16_A_meme_style_logo_for_a_cryptocurrency_token_called_Suimon_featuring_a_playful_blue_salmon_The_salmon_should_have_a_cartoonish_expression_with_big_f06daf86d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

