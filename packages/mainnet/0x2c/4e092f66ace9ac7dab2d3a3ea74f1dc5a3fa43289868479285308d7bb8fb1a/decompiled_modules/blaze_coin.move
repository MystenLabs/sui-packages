module 0x2c4e092f66ace9ac7dab2d3a3ea74f1dc5a3fa43289868479285308d7bb8fb1a::blaze_coin {
    struct BLAZE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE_COIN>(arg0, 9, b"BLAZE_COIN", b"Jessyblaze", b"Best meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4c8ef3e-7e23-427b-9aa9-193b7325299f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAZE_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

