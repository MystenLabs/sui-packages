module 0x63d9ca8eb93510f8f58b41366b0af7baf90217ac4821e0d274b45940a67054e2::mxat {
    struct MXAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXAT>(arg0, 9, b"MXAT", b"Meme", b"Usuahsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf20de71-7ab8-4fec-b476-c554430a5954.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

