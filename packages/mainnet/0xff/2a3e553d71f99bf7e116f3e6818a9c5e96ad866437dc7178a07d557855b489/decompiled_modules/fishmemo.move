module 0xff2a3e553d71f99bf7e116f3e6818a9c5e96ad866437dc7178a07d557855b489::fishmemo {
    struct FISHMEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMEMO>(arg0, 9, b"FISHMEMO", b"MEMO", b"meme coin adaption from fish memo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7299332-8bac-4e29-b63c-2ecee416088a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHMEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

