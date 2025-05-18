module 0xdda84cf09f11102c8ba1cad1c2d5e48531da416506ae18c8268957ee84cd7b80::suimonn {
    struct SUIMONN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONN>(arg0, 9, b"SUIMONN", b"SUIMON", x"0a4d656d6520746f205574696c6974792045766f6c7574696f6e0a0a4149204167656e742c2047616d696e672c204e4654732c20416c6c20696e204f6e652045636f73797374656d0a0a0a0a5375696d6f6e204149204167656e74202d204f6e65206f6620497473204b696e642c20546865204269727468206f662061204e6578742d4c6576656c205574696c69747920436f696e21e29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/47f45db42053638d103660d2cf1b1411blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMONN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

