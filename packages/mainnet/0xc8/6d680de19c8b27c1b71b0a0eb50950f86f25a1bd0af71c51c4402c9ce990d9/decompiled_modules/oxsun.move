module 0xc86d680de19c8b27c1b71b0a0eb50950f86f25a1bd0af71c51c4402c9ce990d9::oxsun {
    struct OXSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXSUN>(arg0, 6, b"OXSUN", b"0xsun", b"KOOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743183599226.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXSUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXSUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

