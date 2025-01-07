module 0x3e4706a421ed99a2a7e1821899b595dd7c5ef45d3f77b4696f092d8a8338b4ca::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"Sui Inu on SUI Chain", x"53756920496e75202d2074686520776174657220646f67206f66205355492e204c61756e6368696e6720736f6f6e2e2054656c656772616d202d2068747470733a2f2f742e6d652f73756973696e750a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisinu_0d75f68868.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

