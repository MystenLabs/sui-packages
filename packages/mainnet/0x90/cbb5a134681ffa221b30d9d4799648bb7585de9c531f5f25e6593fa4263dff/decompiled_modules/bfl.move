module 0x90cbb5a134681ffa221b30d9d4799648bb7585de9c531f5f25e6593fa4263dff::bfl {
    struct BFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFL>(arg0, 6, b"BFL", b"BITCOIN FLO", b"PUMP PUMP PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gold_bitcoin_text_art_rb3ofnlsewe9a2ap_ee7e75a690.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

