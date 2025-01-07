module 0x2f63c1b7957aaba5a30a4b0a9a8f312d5952e31872476048d984a71b3d61ac92::meme_ai {
    struct MEME_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_AI>(arg0, 9, b"MEME_AI", b"Meme", b"Token MEMEai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8465be5-f9e1-43e7-b911-478c335589cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

