module 0x60a93561fe831a0e3f260d359dc2c8415d12d86e2d3f4f9531e5e5e3a77e76ac::dgsg {
    struct DGSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSG>(arg0, 9, b"DGSG", b"SGfh", b"GSGDSgsdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8be8b293-2553-43d7-ba0e-8c9b8e1ba18e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

