module 0x8df5dd85ed808e459f77abb2f4d4234c78f5154c621fea52a730e38c5c622959::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTC>(arg0, 6, b"CTC", b"Crazy Teckel Coin", b"It's a meme coin. Based on teckel culture. Made for fun & community.We didn't invent the wheel. We didn't solve world hunger.We made a coin about a crazy little dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Crazy_tackle_transparant_512_b6b4a27485.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

