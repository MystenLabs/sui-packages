module 0xad44a4fd18aab2baa2ae6fc0c72d89651960167c935c3ef4d5249a0ee752bd3::mando {
    struct MANDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANDO>(arg0, 9, b"MANDO", b"Man", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed517676-43c8-41d3-ae7b-d2f096603ebf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

