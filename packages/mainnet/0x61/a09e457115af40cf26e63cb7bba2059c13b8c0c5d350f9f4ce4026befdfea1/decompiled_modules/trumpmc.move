module 0x61a09e457115af40cf26e63cb7bba2059c13b8c0c5d350f9f4ce4026befdfea1::trumpmc {
    struct TRUMPMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMC>(arg0, 6, b"TRUMPMC", b"Trump McDonalds", b"ONLY TRUMP ! ONLY MCDONALS ! WE WIN ! CAMALA LOST ! TRUMP WIN !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/57ab768fce38f234008b5ea0_410198ff03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

