module 0xe4bfa85ece7be1551feca39402b447deae8cc0b7dd16c9a5a7b6f6ded3261f6a::bscc {
    struct BSCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCC>(arg0, 9, b"BSCC", b"BSCCToken", b"It is test token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://testtoken")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

