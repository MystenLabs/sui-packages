module 0x505aa6120738e177402d8c0589a717a7f01cb5a1ebb8149d4a0c2f467f3c0a76::yky {
    struct YKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YKY>(arg0, 9, b"YKY", b"yongkray", b"hai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/494e9390-75d8-42c6-a33a-7227b1f5b5df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

