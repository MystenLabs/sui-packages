module 0x1d0eeee334f32b7bfbedf2824c6030bd6f751d4731987f652ab44296860b1028::ispeed {
    struct ISPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISPEED>(arg0, 9, b"ISPEED", b"IshowSpeed", b"Speed meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6c75a02-1b63-4dfe-9998-c5e04868dd99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

