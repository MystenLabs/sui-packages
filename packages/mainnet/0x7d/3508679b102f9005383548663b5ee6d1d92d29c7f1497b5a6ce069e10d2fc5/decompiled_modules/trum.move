module 0x7d3508679b102f9005383548663b5ee6d1d92d29c7f1497b5a6ce069e10d2fc5::trum {
    struct TRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUM>(arg0, 9, b"TRUM", b"TRUMP", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/5f8726c7-766a-4bdf-9be3-45f7652b55ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

