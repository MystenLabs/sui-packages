module 0x6d21ad04775c41a31d44a0a57fb1ac561abc7fea005ebe033c5b10c7722baeac::babyyoda {
    struct BABYYODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYYODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYYODA>(arg0, 9, b"BABYYODA", b"Baby Yoda", b"You ever forget what you're doing and you just stand there loading...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5f5bc8e-a096-418d-8c8e-1211fb59511e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYYODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYYODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

