module 0xe52a28d6197fbe84f4b1db5999317e12f52e9453644d05dfdbefba5c839539ce::moisaa {
    struct MOISAA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOISAA>, arg1: 0x2::coin::Coin<MOISAA>) {
        0x2::coin::burn<MOISAA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOISAA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOISAA>>(0x2::coin::mint<MOISAA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOISAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOISAA>(arg0, 9, b"moisaa", b"MOISAA", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOISAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOISAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

