module 0xc4db9e647fc311a768a28ba97130698d6b01c3c770aebda283f935d6d705a7ca::sahur {
    struct SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHUR>(arg0, 6, b"SAHUR", b"Tung Tung Tung Sahur", b"Tung tung tung tung tung tung tung tung tung sahur. A terrifying anomaly that only comes out at Sahoor. It is said that if someone is called for Sahoor three times and does not answer, then this creature comes to your house. Ooh, so scary!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749306606982.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAHUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

