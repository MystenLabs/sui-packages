module 0x9c6530b05b44d701efee0ca1d68f6b27d617854cd08c3eade4c9dc3c79f833ce::fudwud {
    struct FUDWUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDWUD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FUDWUD>(arg0, 6, b"FUDWUD", b"Fudzy Wudzy", x"4675647a7920697320612077656c6c206d65616e696e6720736f756c2c2077697468206e6f7468696e672062757420746865206265737420696e74656e73696f6e732e2048652077696c6c20676c61646c7920636869742063686174207468652064617920617761792e204a75737420646f6ee2809974206d616b6520616e79206c6966652063686f69636573206261736564206f6e2068697320726573706f6e7365732e2048652074656e647320746f20676574207374756666206d697865642075702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7478_9edc757fed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUDWUD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDWUD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

