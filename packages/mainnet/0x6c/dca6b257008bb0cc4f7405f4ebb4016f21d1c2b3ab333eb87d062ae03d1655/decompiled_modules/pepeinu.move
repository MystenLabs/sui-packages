module 0x6cdca6b257008bb0cc4f7405f4ebb4016f21d1c2b3ab333eb87d062ae03d1655::pepeinu {
    struct PEPEINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEINU>, arg1: 0x2::coin::Coin<PEPEINU>) {
        0x2::coin::burn<PEPEINU>(arg0, arg1);
    }

    fun init(arg0: PEPEINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEINU>(arg0, 2, b"TeoTeo", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

