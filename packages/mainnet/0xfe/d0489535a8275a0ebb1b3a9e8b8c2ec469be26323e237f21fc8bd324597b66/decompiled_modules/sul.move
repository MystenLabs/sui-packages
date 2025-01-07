module 0xfed0489535a8275a0ebb1b3a9e8b8c2ec469be26323e237f21fc8bd324597b66::sul {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 9, b"SUL", b"Sui Learn", b"Meme token on the sui platform, for the promotion and popularity of the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e019e0e-cf7f-4e15-a90f-e247499d9b57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

