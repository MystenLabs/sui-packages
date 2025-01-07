module 0x62681601ba3124ce7e74d25f89f7af3b3d14cd5cb28e7f99b868a59e76805a6e::wcoin_22 {
    struct WCOIN_22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCOIN_22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCOIN_22>(arg0, 9, b"WCOIN_22", b"Wcoin", b"Wcoin game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48cef887-ccd3-42c0-ae57-78e9b3d5ea6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCOIN_22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCOIN_22>>(v1);
    }

    // decompiled from Move bytecode v6
}

