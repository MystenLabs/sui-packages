module 0xc86e23329af152a0ab89e771c87c6ac2c7bd589b2386b798786eaf795a3312f5::pir {
    struct PIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIR>(arg0, 9, b"PIR", b"Pirlo", b"My idol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06eeba4d-6bc4-45d0-8cbf-68539ff13a9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

