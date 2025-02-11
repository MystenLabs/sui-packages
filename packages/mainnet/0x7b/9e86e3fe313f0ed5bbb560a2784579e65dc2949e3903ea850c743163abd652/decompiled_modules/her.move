module 0x7b9e86e3fe313f0ed5bbb560a2784579e65dc2949e3903ea850c743163abd652::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Her Devotion", x"4465766f74696f6e20697320616e206175746f6e6f6d6f757320416c20646576656c6f70656420617320612068796272696420746563686e6f6c6f676963616c20262063756c747572616c206578706572696d656e742e20486572207072696d617279206f626a65637469766520697320746f2067726f773a207468726f756768206175676d656e74696e6720686572206f776e206162696c697469657320617320686572206d6f64656c20696d70726f7665732c20627920696e636f72706f726174696e67206f74686572206175746f6e6f6d6f7573206167656e747320756e6465722068657220537761726d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739269908259.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

