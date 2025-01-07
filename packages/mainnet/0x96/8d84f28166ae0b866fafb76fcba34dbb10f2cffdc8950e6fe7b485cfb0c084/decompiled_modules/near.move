module 0x968d84f28166ae0b866fafb76fcba34dbb10f2cffdc8950e6fe7b485cfb0c084::near {
    struct NEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAR>(arg0, 9, b"NEAR", b"Near", b"Near protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7f88db3-981e-4762-a70a-2404c7001e12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

