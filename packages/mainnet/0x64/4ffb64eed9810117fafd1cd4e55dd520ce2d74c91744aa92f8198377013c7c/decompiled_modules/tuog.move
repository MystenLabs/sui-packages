module 0x644ffb64eed9810117fafd1cd4e55dd520ce2d74c91744aa92f8198377013c7c::tuog {
    struct TUOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUOG>(arg0, 9, b"TUOG", b"FFWP;", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/760c0498-bac1-4a59-a9bd-85c89f5c8b5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

