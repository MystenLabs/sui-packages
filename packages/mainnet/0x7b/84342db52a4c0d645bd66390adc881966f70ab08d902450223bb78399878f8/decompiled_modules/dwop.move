module 0x7b84342db52a4c0d645bd66390adc881966f70ab08d902450223bb78399878f8::dwop {
    struct DWOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOP>(arg0, 6, b"Dwop", b"DWOP", x"57686174206973207375693f20412044574f5020f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732140730470.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

