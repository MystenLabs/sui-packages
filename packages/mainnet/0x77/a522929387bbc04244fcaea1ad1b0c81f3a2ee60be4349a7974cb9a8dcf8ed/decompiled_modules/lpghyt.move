module 0x77a522929387bbc04244fcaea1ad1b0c81f3a2ee60be4349a7974cb9a8dcf8ed::lpghyt {
    struct LPGHYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPGHYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPGHYT>(arg0, 9, b"LPGHYT", b"dfhhtdgd", b"bnhtyujk8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e83b610-07b3-49a7-aa4d-ca922ca8f734.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPGHYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPGHYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

