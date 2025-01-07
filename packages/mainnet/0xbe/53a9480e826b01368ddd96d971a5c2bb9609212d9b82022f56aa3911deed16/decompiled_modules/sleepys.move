module 0xbe53a9480e826b01368ddd96d971a5c2bb9609212d9b82022f56aa3911deed16::sleepys {
    struct SLEEPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEPYS>(arg0, 9, b"SLEEPYS", b"SLEEPY", b"SSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d20a2bf-cb61-4fb5-bdf1-48b5ea41b55c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEEPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

