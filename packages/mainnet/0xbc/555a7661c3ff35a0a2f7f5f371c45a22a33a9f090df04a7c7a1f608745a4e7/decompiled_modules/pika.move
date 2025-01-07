module 0xbc555a7661c3ff35a0a2f7f5f371c45a22a33a9f090df04a7c7a1f608745a4e7::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"PIKASUI", b"PikaSui is a lightning-charged cryptocurrency on the SUI blockchain, sparking innovation and electrifying the crypto world! PikaSui ($PIKA) is officially zapping its way into the Sui chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734921938797.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

