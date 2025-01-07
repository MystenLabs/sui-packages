module 0xe2e2459f47b6b7502650cede0d9b3e397d583ae2db058246cd0af0c3fbf2aaa5::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"SODA", b"Sodaaaaa", b"Drink Soda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/document_e3cdf1418b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

