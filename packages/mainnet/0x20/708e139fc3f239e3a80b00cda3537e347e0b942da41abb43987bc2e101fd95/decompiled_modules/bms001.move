module 0x20708e139fc3f239e3a80b00cda3537e347e0b942da41abb43987bc2e101fd95::bms001 {
    struct BMS001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMS001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMS001>(arg0, 9, b"BMS001", b"Bams ", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea91a0f4-dced-4dfe-a087-922a9bbbf077.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMS001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMS001>>(v1);
    }

    // decompiled from Move bytecode v6
}

