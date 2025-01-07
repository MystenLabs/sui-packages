module 0xdf2c122621d90c9874a6fc4083d5630e997b25d4c1a1f5f5a2d1853a7e23759::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"Cs", b"Cat Sui", b"Cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956144984.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

