module 0xe49835e4a3df7b741519181f203da7e74b6e7f249541bc9893bac8c589563098::add {
    struct ADD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADD>(arg0, 9, b"ADD", b"AiDildo", x"41496761746f7244696c646f64696e6920284144442920e280932061206465666c6174696f6e61727920746f6b656e2077697468206175746f2d6275726e2c20636861726974792c20616e64206c69717569646974792066656174757265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee293f21-9ebe-4fff-b347-6c1d25c2bdb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADD>>(v1);
    }

    // decompiled from Move bytecode v6
}

