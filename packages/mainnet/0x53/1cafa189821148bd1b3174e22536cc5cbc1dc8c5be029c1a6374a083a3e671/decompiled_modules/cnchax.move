module 0x531cafa189821148bd1b3174e22536cc5cbc1dc8c5be029c1a6374a083a3e671::cnchax {
    struct CNCHAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNCHAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNCHAX>(arg0, 9, b"CNCHAX", b"CNC", b"MEME CNCHAX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f9f6a16-b261-4668-93a7-137a0f7b48b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNCHAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNCHAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

