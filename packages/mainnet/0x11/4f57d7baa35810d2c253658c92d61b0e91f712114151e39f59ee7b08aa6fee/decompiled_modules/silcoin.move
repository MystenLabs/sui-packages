module 0x114f57d7baa35810d2c253658c92d61b0e91f712114151e39f59ee7b08aa6fee::silcoin {
    struct SILCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILCOIN>(arg0, 9, b"SILCOIN", b"SilverGold", b"SilVer Gold trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de47b843-297d-4b20-b512-7fb2acca8f81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

