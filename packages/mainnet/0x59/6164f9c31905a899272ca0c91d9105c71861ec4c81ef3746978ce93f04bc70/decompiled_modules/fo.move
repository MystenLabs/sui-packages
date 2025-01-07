module 0x596164f9c31905a899272ca0c91d9105c71861ec4c81ef3746978ce93f04bc70::fo {
    struct FO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FO>(arg0, 9, b"FO", b"Fasting ", x"4920646f6ee2809974206b6e6f77207768617420796f752061726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03e81b94-57b6-43d1-8072-1da0ac226b49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FO>>(v1);
    }

    // decompiled from Move bytecode v6
}

