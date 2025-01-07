module 0xf6db609a88c59375b45e12f7f875390dedec2569e3fc1e223cc5ce48a7760415::mcoin {
    struct MCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOIN>(arg0, 9, b"MCOIN", b"MAMICOIN", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e606f257-f1af-46ea-865b-ec4cc80a68f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

