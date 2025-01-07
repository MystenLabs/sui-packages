module 0xa07ae784e54533dca782ffc5f82bacf39743355226545e7bf814852e72a0d80a::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 9, b"SMC", b"Smelly cat", b"smelly cat smelly cat what are they feeding you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cf75b74-7712-4288-82b4-d8edec3a5c30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

