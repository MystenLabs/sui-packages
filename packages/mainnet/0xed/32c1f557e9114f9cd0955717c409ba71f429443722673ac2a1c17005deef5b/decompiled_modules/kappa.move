module 0xed32c1f557e9114f9cd0955717c409ba71f429443722673ac2a1c17005deef5b::kappa {
    struct KAPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPA>(arg0, 6, b"KAPPA", b"Kappa", b"Hello! $KAPPA he's your cute new friend!! Come on, carry out the treasure hunt mission", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033659_b63b3178b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

