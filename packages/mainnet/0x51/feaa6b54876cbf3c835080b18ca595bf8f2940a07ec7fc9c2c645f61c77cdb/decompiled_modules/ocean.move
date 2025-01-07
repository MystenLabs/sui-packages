module 0x51feaa6b54876cbf3c835080b18ca595bf8f2940a07ec7fc9c2c645f61c77cdb::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 9, b"OCEAN", b"OCEAN ", b"OCEAN back King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef48c690-8a24-4670-aa80-cd6cc10337bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

