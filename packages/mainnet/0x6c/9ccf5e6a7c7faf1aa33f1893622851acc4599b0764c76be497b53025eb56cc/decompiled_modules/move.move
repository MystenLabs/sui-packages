module 0x6c9ccf5e6a7c7faf1aa33f1893622851acc4599b0764c76be497b53025eb56cc::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 6, b"Move", b"Move Pump", b"The official Move Pump token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D8_ADC_80_C_D700_4028_B427_14_B3_E921_E104_7c7dccbb48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

