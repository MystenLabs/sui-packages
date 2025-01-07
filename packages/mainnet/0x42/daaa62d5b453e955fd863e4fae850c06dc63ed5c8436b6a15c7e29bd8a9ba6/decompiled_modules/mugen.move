module 0x42daaa62d5b453e955fd863e4fae850c06dc63ed5c8436b6a15c7e29bd8a9ba6::mugen {
    struct MUGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGEN>(arg0, 9, b"MUGEN", b"MUU GEN", b"M UU GEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc5db542-c722-4fd5-bad3-3b84f3f25e2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

