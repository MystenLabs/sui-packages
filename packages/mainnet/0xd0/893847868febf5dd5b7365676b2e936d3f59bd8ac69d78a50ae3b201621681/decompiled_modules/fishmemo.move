module 0xd0893847868febf5dd5b7365676b2e936d3f59bd8ac69d78a50ae3b201621681::fishmemo {
    struct FISHMEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMEMO>(arg0, 9, b"FISHMEMO", b"MEMO", b"meme coin adaption from fish memo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edc5c488-62f3-4b17-b737-fefcba5439e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHMEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

