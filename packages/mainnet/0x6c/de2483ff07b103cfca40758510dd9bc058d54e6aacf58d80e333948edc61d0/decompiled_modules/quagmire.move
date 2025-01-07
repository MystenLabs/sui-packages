module 0x6cde2483ff07b103cfca40758510dd9bc058d54e6aacf58d80e333948edc61d0::quagmire {
    struct QUAGMIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAGMIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAGMIRE>(arg0, 6, b"QUAGMIRE", b"QUAGMIRE ON SUI", x"5375692069732061626f757420746f20676574207765742c204749474954590a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_02_10_39_abbe0b1e2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAGMIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUAGMIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

