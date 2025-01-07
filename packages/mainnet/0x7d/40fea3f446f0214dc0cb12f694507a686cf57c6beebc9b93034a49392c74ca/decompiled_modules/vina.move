module 0x7d40fea3f446f0214dc0cb12f694507a686cf57c6beebc9b93034a49392c74ca::vina {
    struct VINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINA>(arg0, 9, b"VINA", b"Vivonam", x"56c3b520746875e1baad74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e416fcd1-324a-4872-acf8-fcb2e8e6066c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

