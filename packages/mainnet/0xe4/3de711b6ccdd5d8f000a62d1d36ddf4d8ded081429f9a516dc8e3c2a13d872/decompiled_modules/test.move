module 0xe43de711b6ccdd5d8f000a62d1d36ddf4d8ded081429f9a516dc8e3c2a13d872::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"Test Token Do not Buy", b"This is a test token. Please don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_02_22_17_43_A_playful_cartoon_style_depiction_of_a_digital_token_named_Test_The_token_should_have_a_round_shiny_coin_like_appearance_with_the_word_Test_pro_1819586784.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

