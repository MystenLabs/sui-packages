module 0xdc2c25b280cd6a852deaf3b715aded8a6b71361c30e07a3cfe9c03a675444e6a::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Tomato AI", x"4d65657420546f6d61746f416c2c20596f75722043727970746f2046696e616e636573206f6e204175746f70696c6f742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738301712071.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

