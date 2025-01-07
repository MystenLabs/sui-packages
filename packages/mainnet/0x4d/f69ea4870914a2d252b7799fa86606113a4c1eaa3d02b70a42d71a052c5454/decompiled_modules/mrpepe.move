module 0x4df69ea4870914a2d252b7799fa86606113a4c1eaa3d02b70a42d71a052c5454::mrpepe {
    struct MRPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MRPEPE>, arg1: 0x2::coin::Coin<MRPEPE>) {
        0x2::coin::burn<MRPEPE>(arg0, arg1);
    }

    fun init(arg0: MRPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRPEPE>(arg0, 2, b"MRPEPE", b"MRPEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MRPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MRPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

