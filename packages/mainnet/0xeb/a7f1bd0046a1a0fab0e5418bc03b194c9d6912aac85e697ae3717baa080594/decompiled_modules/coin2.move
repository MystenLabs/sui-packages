module 0xeba7f1bd0046a1a0fab0e5418bc03b194c9d6912aac85e697ae3717baa080594::coin2 {
    struct COIN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN2>(arg0, 9, b"TICKER2", b"coin2", b"desc2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/103dddc1-5d71-4f93-8e22-05676dfb11e7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

