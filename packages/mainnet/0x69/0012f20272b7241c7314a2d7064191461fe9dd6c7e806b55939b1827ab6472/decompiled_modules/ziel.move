module 0x690012f20272b7241c7314a2d7064191461fe9dd6c7e806b55939b1827ab6472::ziel {
    struct ZIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIEL>(arg0, 9, b"ZIEL", b"Ziel Smile", b"Ziel smile paint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adabcbfb-4ffe-4fe6-9f29-c736489f1e7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

