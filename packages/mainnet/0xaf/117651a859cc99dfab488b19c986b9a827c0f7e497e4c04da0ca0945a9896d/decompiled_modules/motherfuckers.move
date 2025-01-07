module 0xaf117651a859cc99dfab488b19c986b9a827c0f7e497e4c04da0ca0945a9896d::motherfuckers {
    struct MOTHERFUCKERS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOTHERFUCKERS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOTHERFUCKERS>>(0x2::coin::mint<MOTHERFUCKERS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOTHERFUCKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHERFUCKERS>(arg0, 6, b"MOTHERFUCKERS", b"MOTHERFUCKERS", b"This is MOTHERFUCKERS token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTHERFUCKERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTHERFUCKERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

