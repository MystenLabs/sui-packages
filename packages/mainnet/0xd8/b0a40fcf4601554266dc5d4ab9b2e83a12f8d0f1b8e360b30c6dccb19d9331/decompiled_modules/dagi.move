module 0xd8b0a40fcf4601554266dc5d4ab9b2e83a12f8d0f1b8e360b30c6dccb19d9331::dagi {
    struct DAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGI>(arg0, 6, b"DAGI", b"Dark AGI Arena ", x"f09fa49620414749204172656e61207c20576865726520696e6e6f766174696f6e206d6565747320696e74656c6c6967656e636520f09f8c8c207c204578706c6f72696e67207468652066726f6e74696572206f66204172746966696369616c2047656e6572616c20496e74656c6c6967656e6365207c2049646561732c20696e7369676874732c20616e6420627265616b7468726f7567687321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736759853518.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

