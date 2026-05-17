module 0x641850ee2958ad83552e32f6ca281823757ddd04aaafb82ea5a5c89b772d49c9::pbtc {
    struct PBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<PBTC>(arg0, 6, b"PBTC", b"Purple Bitcoin ", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

