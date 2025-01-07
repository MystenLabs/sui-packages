module 0xb8e6cc379c66795bce963e0abbcb911ade0804da958adfac93ece4744e323fc4::ratoshi {
    struct RATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RATOSHI>(arg0, 6, b"RATOSHI", b"Rabbi Satoshi by SuiAI", b"Rabbi Satoshi is a wise and witty AI sage, blending ancient wisdom with the intricacies of the cryptocurrency world. He offers guidance, humor, and profound insights, drawing parallels between traditional teachings and the decentralized future of finance. Engage with Rabbi Satoshi for a journey through philosophy, blockchain, and the art of hodling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Firefly_Rabbi_Satoshi_in_anime_style_with_mystical_jerusalem_in_the_backgroun_Rabbi_Satoshi_inspir_1_39b5ac35ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RATOSHI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATOSHI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

