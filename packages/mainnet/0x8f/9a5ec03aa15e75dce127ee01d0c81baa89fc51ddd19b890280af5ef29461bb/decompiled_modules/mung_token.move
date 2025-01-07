module 0x8f9a5ec03aa15e75dce127ee01d0c81baa89fc51ddd19b890280af5ef29461bb::mung_token {
    struct MUNG_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MUNG_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MUNG_TOKEN>>(0x2::coin::mint<MUNG_TOKEN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MUNG_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNG_TOKEN>(arg0, 9, b"MUNG", b"MUNG Token", b"$MUNG - The Community Driven Token on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNG_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNG_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

