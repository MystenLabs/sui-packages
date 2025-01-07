module 0x4349d5f5174a345c8ab194968311f58aa66dff0b28e6f8ec74c980422100b562::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 6, b"SUITRUMP", b"SUI TRUMP", b"SUI STAND BY TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_ae_a_ae_ae_a_17278784561260_b71367ba2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

