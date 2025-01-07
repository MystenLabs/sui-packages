module 0x6ed6ef979da105b612ebd7fbae239616bb563a60317eb296d006a2b23c25de9d::strongpepe {
    struct STRONGPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONGPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONGPEPE>(arg0, 2, b"STRONGPEPE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRONGPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONGPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STRONGPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STRONGPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

