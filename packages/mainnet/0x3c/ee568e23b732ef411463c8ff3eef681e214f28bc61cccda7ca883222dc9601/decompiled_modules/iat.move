module 0x3cee568e23b732ef411463c8ff3eef681e214f28bc61cccda7ca883222dc9601::iat {
    struct IAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAT>(arg0, 6, b"IAT", b"Sui.Ai", x"696e6e6f766174696f6e2069732074686520667574757265206172746966696369616c20696e74656c6c6967656e63650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733882226505.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

