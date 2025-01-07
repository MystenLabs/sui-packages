module 0xb698945ce666a1a0ca84e40319b36ba2e135c3d32924ea94a84cf80f4f797c0e::kil {
    struct KIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIL>(arg0, 9, b"KIL", b"KILLUA", b"Meme token hunter x hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89c68fe6-f5fe-40e1-8e91-7d3b848a9edd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

