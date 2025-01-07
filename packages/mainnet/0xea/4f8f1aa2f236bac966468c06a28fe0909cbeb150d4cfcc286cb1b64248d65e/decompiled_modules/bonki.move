module 0xea4f8f1aa2f236bac966468c06a28fe0909cbeb150d4cfcc286cb1b64248d65e::bonki {
    struct BONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKI>(arg0, 6, b"BONKi", b"Bonki Cat", x"426f6e6b692043617420697420616c6c2061626f75742074686520636f6d6d756e69747920616e6420676f6f64207669626573206f6e20535549204e6574776f726b2e200a0a57652061732061207465616d2063616e20646f206d6f72652069662074686520636f6d6d756e69747920737570706f72747320616e642077686174e280997320736f6d657468696e67207265616c2e200a0a436865636b206f7574206f7572207765627369746520666f72206d6f72652064657461696c732e200a0a57697468206c6f76652066726f6d20426f6e6b6921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731630690438.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

