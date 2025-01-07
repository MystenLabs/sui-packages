module 0xa81ed528802a077fc5dc5d97b23fed6e08cce0e1de5b03034df5e51375c99f58::ffdgdfgfgf {
    struct FFDGDFGFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFDGDFGFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFDGDFGFGF>(arg0, 9, b"FFDGDFGFGF", b"hjfguyfgjg", b"dfdfdfdgfbvcvvc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/571e73b9-9d35-4793-a1a0-f236c97be1a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFDGDFGFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFDGDFGFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

