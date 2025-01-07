module 0x97bbc244ab06ce79f7e72c5046dcf3fe9888b9d7a1a45c2c7cd5f62b8216a318::tiktok111 {
    struct TIKTOK111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTOK111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOK111>(arg0, 9, b"TIKTOK111", b"catayoon", b"cat as moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dffb9d8b-d808-4f81-8771-0078fd16f94f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOK111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKTOK111>>(v1);
    }

    // decompiled from Move bytecode v6
}

