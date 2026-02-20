module 0x9df35efa34f4e8ad11d511246ff632c92a85563073e95c03934f3002573e84a2::main_coin {
    struct MAIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_COIN>(arg0, 9, b"CSTM", b"Custom Token", b"My Custom SUI Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

