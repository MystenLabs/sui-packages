module 0x80a00bb2cdbe0f4a5f7e821ed3bb2df990cddebfaf084ce653f998ec170e4c71::hos {
    struct HOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOS>(arg0, 9, b"HOS", b"horse", b"Noble and original", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33f7ec6e-2bc9-4202-8828-93e551445f53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

