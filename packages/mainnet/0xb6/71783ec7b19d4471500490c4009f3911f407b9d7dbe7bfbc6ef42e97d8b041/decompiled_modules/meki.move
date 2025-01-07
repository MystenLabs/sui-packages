module 0xb671783ec7b19d4471500490c4009f3911f407b9d7dbe7bfbc6ef42e97d8b041::meki {
    struct MEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKI>(arg0, 9, b"MEKI", b"Maneki", b"Maneki-Coin (MEKI) is a unique digital collectible token inspired by the Japanese Maneki-Neko (Lucky Cat) legend. MEKI embodies the symbolism of good fortune, prosperity, and success in the cryptocurrency market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a707e9aa-e214-426e-8114-ef0e2e6396b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

