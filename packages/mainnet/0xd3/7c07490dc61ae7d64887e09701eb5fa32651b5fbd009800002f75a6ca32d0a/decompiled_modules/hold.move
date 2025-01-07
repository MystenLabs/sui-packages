module 0xd37c07490dc61ae7d64887e09701eb5fa32651b5fbd009800002f75a6ca32d0a::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 9, b"HOLD", b"Big thing ", b"Just for fun buy and hold good news coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dea50a51-00fd-4623-a1d2-d65038d66b2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

