module 0x39f74fca24bc97e6d78e0d4ecb64a0825da7d116fab837b2edf7b8a865a38dd1::kir {
    struct KIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIR>(arg0, 9, b"KIR", b"KIRA", b"Meme coins that will become gods of the new world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06180106-bb95-459f-aa82-7a7500c2eb8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

