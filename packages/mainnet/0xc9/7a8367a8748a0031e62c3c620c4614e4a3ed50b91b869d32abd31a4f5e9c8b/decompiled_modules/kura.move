module 0xc97a8367a8748a0031e62c3c620c4614e4a3ed50b91b869d32abd31a4f5e9c8b::kura {
    struct KURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURA>(arg0, 9, b"KURA", b"KURAKURA", b"KURA LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e05fec00-88e1-4952-96dc-0238a19395df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

