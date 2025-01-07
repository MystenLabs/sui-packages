module 0x59e985f364d58d810294c46277ae53c5a0b39aeb128538dfc450f9ea584d7d4d::em {
    struct EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EM>(arg0, 9, b"EM", b"Elon musk", x"456c6f6e206d75736b20636f696e20f09faa99205465736c61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d0f22ab-f535-4802-816e-0a26c605cfbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EM>>(v1);
    }

    // decompiled from Move bytecode v6
}

