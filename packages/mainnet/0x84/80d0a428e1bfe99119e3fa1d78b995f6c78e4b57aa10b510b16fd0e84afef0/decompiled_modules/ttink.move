module 0x8480d0a428e1bfe99119e3fa1d78b995f6c78e4b57aa10b510b16fd0e84afef0::ttink {
    struct TTINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTINK>(arg0, 6, b"TTINK", b"TOBIE TINKER", b"TOBIE TINKER TOBIE TINKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkjceku66fco7zgb73g4ju6fd46y2nwjjszsmszofc7jhkq5hbve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

