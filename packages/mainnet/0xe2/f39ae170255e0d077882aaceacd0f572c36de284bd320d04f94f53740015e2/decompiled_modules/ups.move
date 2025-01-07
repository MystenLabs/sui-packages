module 0xe2f39ae170255e0d077882aaceacd0f572c36de284bd320d04f94f53740015e2::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPS>(arg0, 6, b"UPS", b"UP SUI-NDROME", b"For those diagnosed with Up Sui-ndrome ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_05_06_16_65b657f92a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

