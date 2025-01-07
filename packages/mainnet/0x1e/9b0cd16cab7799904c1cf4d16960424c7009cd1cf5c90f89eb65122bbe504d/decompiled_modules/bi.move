module 0x1e9b0cd16cab7799904c1cf4d16960424c7009cd1cf5c90f89eb65122bbe504d::bi {
    struct BI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BI>(arg0, 9, b"BI", b"Jay", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6bc5c58-61c2-44ef-9be3-a8d1599b75cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BI>>(v1);
    }

    // decompiled from Move bytecode v6
}

