module 0xf0c2f614e6007b40fcf793484117495127b64c592e833bc1fbc248fdd8382b91::candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 6, b"Candle", b"Candle Cat", b"Candle Cat at SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_14_230759_bab2116a93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

