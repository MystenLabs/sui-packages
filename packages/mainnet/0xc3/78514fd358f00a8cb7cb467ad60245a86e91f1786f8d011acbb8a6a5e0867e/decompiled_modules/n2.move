module 0xc378514fd358f00a8cb7cb467ad60245a86e91f1786f8d011acbb8a6a5e0867e::n2 {
    struct N2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N2>(arg0, 9, b"N2", b"NANA", b"Nana have creates by Henry Lam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfa259b9-aba2-407c-a25f-d612908418fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N2>>(v1);
    }

    // decompiled from Move bytecode v6
}

