module 0x4e017bb803379d0c4d7eaaddd0182c007d53392dfeb0129bf00ad6d8bbd6bc6b::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 9, b"MCAT", b"Meme", b"Hahaha bauiaha. Auajaja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6508ca48-b8a5-4033-bdb9-f797436117b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

