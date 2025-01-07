module 0x2ecda46d50404eae1efd4397022bc68004c2495b5672924d8d7e6bcab7fd01b3::DORA {
    struct DORA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DORA>, arg1: 0x2::coin::Coin<DORA>) {
        0x2::coin::burn<DORA>(arg0, arg1);
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORA>(arg0, 9, b"DORA", b"DORA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DORA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DORA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

