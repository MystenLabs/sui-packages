module 0xeaa3e44d0d3e1a10d117785a0177f3647ff7a578c6d921f235958f1d28de3398::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 9, b"FAUCET", b"Sui faucet", b"A place to move your Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c73ceb9f-232e-473f-8d8c-1bf41a05f981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

