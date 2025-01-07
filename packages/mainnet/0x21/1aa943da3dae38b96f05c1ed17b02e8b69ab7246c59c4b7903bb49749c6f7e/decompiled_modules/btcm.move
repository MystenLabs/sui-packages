module 0x211aa943da3dae38b96f05c1ed17b02e8b69ab7246c59c4b7903bb49749c6f7e::btcm {
    struct BTCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCM>(arg0, 9, b"BTCM", b"bitcoinm", b"Bitcoin small ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a6a0a1d-497d-4bc2-8f28-a1703311dba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

