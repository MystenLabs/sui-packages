module 0x54752ded6377e3bf5cd00c5c0f90b60a7af0d9f0b8881fcaaec588ff85a2c7ea::LAMA {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 9, b"LAMA", b"Lama Trump", b"Lama Trump Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

