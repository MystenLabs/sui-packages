module 0xfe22c1ae4030e61d5ceec5efe7fad2fe8b1a9ef54b43a81df7d6e1e01f9efa95::pym {
    struct PYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYM>(arg0, 9, b"PYM", b"Peyman", b"My first token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e0fc4c6-886d-4f91-8052-4524d4420323.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

