module 0x215827bd907aa1a0ab8a58c0046de6b2c49df686255270390fa9a2c54ae6f670::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Donald Trump ", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

