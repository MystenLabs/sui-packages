module 0x15065849d41f14b8a9e3cc57fb6344b78f38fd882514e5e0913500ca358a799e::memek_abi {
    struct MEMEK_ABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ABI>(arg0, 6, b"MEMEKABI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ABI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ABI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ABI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

