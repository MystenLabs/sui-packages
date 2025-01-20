module 0xccd628c2334c5ed33e6c47d6c21bb664f8b6307b2ac32c2462a61f69a31ebcee::meth {
    struct METH has drop {
        dummy_field: bool,
    }

    fun init(arg0: METH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METH>(arg0, 8, b"mETH", b"mETH", b"Metastable ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/meth.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METH>>(v1);
    }

    // decompiled from Move bytecode v6
}

