module 0xc822fc383fdf632f0d7aba3f07df9ec1b09ff21ae8b83dbac20fa34d7a0abb2::slk22 {
    struct SLK22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLK22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLK22>(arg0, 9, b"SLK22", b"Salenko22", b"This is meme token developed on Wave wallet and Sui network for its diversity and scalability with the other token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c05ac29b-0790-47c6-ac65-928b0b171502.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLK22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLK22>>(v1);
    }

    // decompiled from Move bytecode v6
}

