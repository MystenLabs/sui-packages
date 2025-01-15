module 0xe44df51c0b21a27ab915fa1fe2ca610cd3eaa6d9666fe5e62b988bf7f0bd8722::musd {
    struct MUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSD>(arg0, 9, b"mUSD", b"mUSD", b"Metastable USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/musd.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

