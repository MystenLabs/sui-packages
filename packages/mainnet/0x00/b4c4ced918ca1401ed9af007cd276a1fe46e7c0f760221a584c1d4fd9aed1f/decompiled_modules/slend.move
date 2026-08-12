module 0xb4c4ced918ca1401ed9af007cd276a1fe46e7c0f760221a584c1d4fd9aed1f::slend {
    struct SLEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEND>(arg0, 6, b"SLEND", b"Suilend Lending", b"This receipt token represents the shares a user has of the Suilend Lending Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/SLEND.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

