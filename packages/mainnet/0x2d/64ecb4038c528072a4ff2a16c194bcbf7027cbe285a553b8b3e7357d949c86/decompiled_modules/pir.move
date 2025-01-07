module 0x2d64ecb4038c528072a4ff2a16c194bcbf7027cbe285a553b8b3e7357d949c86::pir {
    struct PIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIR>(arg0, 9, b"PIR", b"Pirlo", b"My idol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81c3f19a-b5a4-48f8-b433-ada96a1e8d41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

