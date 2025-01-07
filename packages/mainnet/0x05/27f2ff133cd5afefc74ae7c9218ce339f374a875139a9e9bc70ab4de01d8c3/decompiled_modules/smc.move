module 0x527f2ff133cd5afefc74ae7c9218ce339f374a875139a9e9bc70ab4de01d8c3::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 9, b"SMC", b"Smile Cat", b"Smile Cat the best meme in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c473dc9a-8256-4a8e-a4ec-dd52ae2f71c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

