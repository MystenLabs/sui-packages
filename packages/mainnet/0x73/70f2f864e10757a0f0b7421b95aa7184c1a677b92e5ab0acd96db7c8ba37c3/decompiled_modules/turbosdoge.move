module 0x7370f2f864e10757a0f0b7421b95aa7184c1a677b92e5ab0acd96db7c8ba37c3::turbosdoge {
    struct TURBOSDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSDOGE>(arg0, 6, b"TURBOSDOGE", b"turbos doge", x"74686520747572626f7320666972737420646f676520f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730892801339.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

