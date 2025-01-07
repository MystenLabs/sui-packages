module 0xeea7351adbd71de65bf312a51b98c01f8ba07217aab160cffc4398737fd58ef6::donky {
    struct DONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKY>(arg0, 9, b"DONKY", b"DONKEY ", b"Introducing the world's first Donkey Meme Coin, proudly brought to you by Wave Wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d26f055-ee3e-440c-8889-cdcce1b31195.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

