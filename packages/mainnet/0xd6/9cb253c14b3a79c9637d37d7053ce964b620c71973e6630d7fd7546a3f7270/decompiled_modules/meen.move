module 0xd69cb253c14b3a79c9637d37d7053ce964b620c71973e6630d7fd7546a3f7270::meen {
    struct MEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEN>(arg0, 9, b"MEEN", b"Meen sui", b"Meme meen on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce2fa414-767c-4bc2-9203-c323578b74c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

