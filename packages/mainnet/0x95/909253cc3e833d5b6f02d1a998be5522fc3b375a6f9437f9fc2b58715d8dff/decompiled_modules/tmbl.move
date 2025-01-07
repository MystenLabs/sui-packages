module 0x95909253cc3e833d5b6f02d1a998be5522fc3b375a6f9437f9fc2b58715d8dff::tmbl {
    struct TMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMBL>(arg0, 9, b"TMBL", b"TEAM BULL", b"Team for the Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4055e6a3-07c4-4864-b17f-885a4aa7ef36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

