module 0x72b388847f1381c86997f5e3449e4fdce14b81e859f6535cad548b5d3c303500::receh {
    struct RECEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECEH>(arg0, 9, b"RECEH", b"UANG", b"UANG RECEH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d3ed6e3-4c9f-4d9d-b159-bd1e09f4a7fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RECEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

