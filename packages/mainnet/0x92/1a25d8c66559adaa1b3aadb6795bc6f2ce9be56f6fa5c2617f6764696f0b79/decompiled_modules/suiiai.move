module 0x921a25d8c66559adaa1b3aadb6795bc6f2ce9be56f6fa5c2617f6764696f0b79::suiiai {
    struct SUIIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIIAI>(arg0, 6, b"SUIIAI", b"SuiIAi", b"ai fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/WX_20241221_174110_99cab411cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIIAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

