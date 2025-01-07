module 0x154ac65ef9c60741681859f0106e25e8f8a541dde836bd3e6967f81c650d7a00::elevnelevn {
    struct ELEVNELEVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEVNELEVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEVNELEVN>(arg0, 6, b"ELEVNELEVN", b"1111", x"456c65766e456c65766e20313131313a20596f7572207469636b657420746f2074686520746f702120f09fa4912046696e616e6369616c2066726565646f6d2c20647265616d206c6966652e2e2e2077697468696e2072656163682120f09f928e20204368616e676520796f7572206c69666521204a6f696e206f7572206d6f6f6e2d626f756e6420636f6d6d756e6974792120f09f9a80204772616220796f757220666f7274756e652120f09f928e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731086453727.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELEVNELEVN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEVNELEVN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

