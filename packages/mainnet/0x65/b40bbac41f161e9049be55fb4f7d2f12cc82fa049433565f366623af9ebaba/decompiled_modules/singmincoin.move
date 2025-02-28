module 0x65b40bbac41f161e9049be55fb4f7d2f12cc82fa049433565f366623af9ebaba::singmincoin {
    struct SINGMINCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SINGMINCOIN>, arg1: 0x2::coin::Coin<SINGMINCOIN>) {
        0x2::coin::burn<SINGMINCOIN>(arg0, arg1);
    }

    fun init(arg0: SINGMINCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGMINCOIN>(arg0, 6, b"singmin", b"singmin coin", b"singmin coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGMINCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGMINCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SINGMINCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SINGMINCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

