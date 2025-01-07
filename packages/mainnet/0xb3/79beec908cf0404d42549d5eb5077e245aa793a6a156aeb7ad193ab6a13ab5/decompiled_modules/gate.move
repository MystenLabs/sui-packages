module 0xb379beec908cf0404d42549d5eb5077e245aa793a6a156aeb7ad193ab6a13ab5::gate {
    struct GATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATE>(arg0, 9, b"GATE", b"Gate", b"Gate.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8337eea6-ae6e-479a-8ce6-18c5b388c54b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

