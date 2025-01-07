module 0xbde2edf32cfd185881efc60ba383f9fbbd5a7253292ac8e2c6c8ea651cd23564::dgsg {
    struct DGSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSG>(arg0, 9, b"DGSG", b"SGfh", b"GSGDSzxfc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5dfd543-abb8-4dcb-8a1b-f0e9402aedee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

