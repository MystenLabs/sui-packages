module 0x4fbc9a30d80ad5adbaf9bd480caeb6a7238cb6f1dc63a9b3ce41c78f5fd9ada1::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Fred the Platypus", b"Gyrururururuk... on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731433201936.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

