module 0x7916e4b2c6b677de523216fa2b466ac0df4c6ad3126f7b543b693fd498c0b999::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"HALLOWEEN", b"Halloween", b"HALLOWEEN Coin is a Meme coin, HALLOWEEN released First on SUI blockchain with inspiration and main image from the HALLOWEEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fdfa15d-4b5b-4a47-83b3-18def2857d62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

