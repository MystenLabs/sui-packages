module 0x232f5524d0222ac7fcc388a8f9a2de1024d6aa3bc33ddbc3b37e2fb05b26c9ea::kuntung {
    struct KUNTUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUNTUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNTUNG>(arg0, 9, b"KUNTUNG", b"Kuntung", b"eyyo kuntung on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06fe9440-c417-4555-a68e-ca5007c97202.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNTUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUNTUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

