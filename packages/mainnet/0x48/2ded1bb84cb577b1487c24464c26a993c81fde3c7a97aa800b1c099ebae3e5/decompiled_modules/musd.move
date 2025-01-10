module 0x482ded1bb84cb577b1487c24464c26a993c81fde3c7a97aa800b1c099ebae3e5::musd {
    struct MUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSD>(arg0, 9, b"mUSD", b"mUSD", b"Metastable USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

