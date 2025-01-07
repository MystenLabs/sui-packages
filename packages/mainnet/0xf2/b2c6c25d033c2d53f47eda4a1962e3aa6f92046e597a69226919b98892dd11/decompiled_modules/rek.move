module 0xf2b2c6c25d033c2d53f47eda4a1962e3aa6f92046e597a69226919b98892dd11::rek {
    struct REK has drop {
        dummy_field: bool,
    }

    fun init(arg0: REK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REK>(arg0, 9, b"REK", b"Riding ", x"4920646f6ee2809974207468696e6b20736f206265636175736520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90b2d9ee-2adf-4489-a402-17dc7d8d2599.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REK>>(v1);
    }

    // decompiled from Move bytecode v6
}

