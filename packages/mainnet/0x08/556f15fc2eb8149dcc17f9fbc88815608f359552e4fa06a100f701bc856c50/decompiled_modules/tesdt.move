module 0x8556f15fc2eb8149dcc17f9fbc88815608f359552e4fa06a100f701bc856c50::tesdt {
    struct TESDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TESDT>(arg0, 6, b"TESDT", b"tested", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

