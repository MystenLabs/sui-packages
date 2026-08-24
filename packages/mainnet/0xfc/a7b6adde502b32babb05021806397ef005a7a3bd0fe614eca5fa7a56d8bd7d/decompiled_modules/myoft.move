module 0xfca7b6adde502b32babb05021806397ef005a7a3bd0fe614eca5fa7a56d8bd7d::myoft {
    struct MYOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYOFT>(arg0, 6, b"Ram", b"2 Sticks of Ram", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYOFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYOFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

