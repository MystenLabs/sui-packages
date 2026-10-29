module 0x1a8d8b0f56767db534e2e062c7a853152ba8d1cef4a76ba7faca0507d2e84784::ps1 {
    struct PS1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PS1>(arg0, 6, 0x1::string::utf8(b"PS1"), 0x1::string::utf8(b"POPULAR presale test PS1"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PS1>>(0x2::coin_registry::finalize<PS1>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

