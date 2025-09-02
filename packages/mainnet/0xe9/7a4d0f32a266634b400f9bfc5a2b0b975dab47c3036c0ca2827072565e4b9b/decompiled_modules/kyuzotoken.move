module 0xe97a4d0f32a266634b400f9bfc5a2b0b975dab47c3036c0ca2827072565e4b9b::kyuzotoken {
    struct KYUZOTOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<KYUZOTOKEN>, arg1: 0x2::coin::Coin<KYUZOTOKEN>) {
        0x2::coin::burn<KYUZOTOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KYUZOTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KYUZOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYUZOTOKEN>(arg0, 6, b"KYC", b"Kyuzo's Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYUZOTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYUZOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

