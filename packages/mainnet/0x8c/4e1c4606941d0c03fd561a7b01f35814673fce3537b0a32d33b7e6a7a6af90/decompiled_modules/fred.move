module 0x8c4e1c4606941d0c03fd561a7b01f35814673fce3537b0a32d33b7e6a7a6af90::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Fred the Platypus", b"Gyrururururuk... on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731341423355.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

