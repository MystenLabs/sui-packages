module 0xfe6120dee3713df9a11ae2969eccd123f9610578a6f9c66f77f12c1b99d58d24::tpump {
    struct TPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPUMP>(arg0, 6, b"TPUMP", b"Trump Pump", b"Trump owns SUIIIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736910412858.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

