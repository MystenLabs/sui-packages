module 0x57fb8fca84ea4efe3d2d202b153d2126b83a7187bc5a0e4f84d6837b0f0e225a::mxat {
    struct MXAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXAT>(arg0, 9, b"MXAT", b"Meme", b"Usuahsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/639afa34-b861-481e-b367-c695431e6b41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

