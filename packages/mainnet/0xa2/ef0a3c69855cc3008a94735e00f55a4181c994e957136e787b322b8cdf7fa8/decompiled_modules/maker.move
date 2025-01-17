module 0xa2ef0a3c69855cc3008a94735e00f55a4181c994e957136e787b322b8cdf7fa8::maker {
    struct MAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKER>(arg0, 6, b"MAKER", b"SuiMaker", b"Maker token, $MAKER is the native token for suimaker, used for services, rewards and driving growth in blockchain trading. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_perfectly_flat_forward_facing_cryptocurrency_token_design_for_the_Maker_Token_ticker_MAKER_The_coin_features_a_bold_and_clean_M_at_the_center_1_5fdae7948d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

