module 0xd3b6b8905a9da537b781638b68aa7d5969773ad3407548d07ce3add864d4d941::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"W  walrus worm", b"W the ticker - walrus moon - $W ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076244_ae07981475.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W>>(v1);
    }

    // decompiled from Move bytecode v6
}

