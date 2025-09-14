module 0x566cdfdf7cd43027981912e1722a239a35bb01ef0c2223e978e514cacd7b4fec::shield {
    struct SHIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIELD>(arg0, 9, b"SHIELD", b"SHIELD", b"THE ICONIC SUI SHIELD | Website: https://x.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/eS54wUy.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

