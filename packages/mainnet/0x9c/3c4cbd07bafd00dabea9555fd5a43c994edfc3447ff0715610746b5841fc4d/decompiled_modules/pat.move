module 0x9c3c4cbd07bafd00dabea9555fd5a43c994edfc3447ff0715610746b5841fc4d::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"Undercover Pat", b"Join Pat in his undercover mission!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_336e0863f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

