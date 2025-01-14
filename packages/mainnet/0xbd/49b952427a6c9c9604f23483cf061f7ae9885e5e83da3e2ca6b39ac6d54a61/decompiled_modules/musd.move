module 0xbd49b952427a6c9c9604f23483cf061f7ae9885e5e83da3e2ca6b39ac6d54a61::musd {
    struct MUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSD>(arg0, 9, b"mUSD", b"mUSD", b"Metastable USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/musd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

