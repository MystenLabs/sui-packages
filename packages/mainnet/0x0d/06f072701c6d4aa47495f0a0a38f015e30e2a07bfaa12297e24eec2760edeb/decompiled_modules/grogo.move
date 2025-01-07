module 0xd06f072701c6d4aa47495f0a0a38f015e30e2a07bfaa12297e24eec2760edeb::grogo {
    struct GROGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGO>(arg0, 6, b"GROGO", b"GROGGO", b"Grogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731274587809.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

