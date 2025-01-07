module 0x8922bc3144719a0e34760c5254a23cbb75acb6a27b9d7b8b06a72f1303afc247::estlat {
    struct ESTLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTLAT>(arg0, 9, b"ESTLAT", b"EstlatCoin", b"First coin of Esther ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d11defb-f80e-4850-90a6-3b6cebb843e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

