module 0x6d90b7478c293a6eae201918a6a702df15086fbf83aade923d36d02069403c68::kien {
    struct KIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIEN>(arg0, 9, b"KIEN", b"Kmeme", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9ff0a53-2973-4789-9c46-e38d754e7314.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

