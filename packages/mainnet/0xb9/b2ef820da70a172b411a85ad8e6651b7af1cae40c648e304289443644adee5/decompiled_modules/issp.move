module 0xb9b2ef820da70a172b411a85ad8e6651b7af1cae40c648e304289443644adee5::issp {
    struct ISSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISSP>(arg0, 9, b"ISSP", b"ISSP Coin", b"Sui20 Coin for ISSP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISSP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISSP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

