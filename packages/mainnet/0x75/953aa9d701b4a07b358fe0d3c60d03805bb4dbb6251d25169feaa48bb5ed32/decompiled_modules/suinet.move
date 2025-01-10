module 0x75953aa9d701b4a07b358fe0d3c60d03805bb4dbb6251d25169feaa48bb5ed32::suinet {
    struct SUINET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINET>(arg0, 6, b"SUINET", b"Suinet AI by SuiAI", x"5375696e65742069732074686520756c74696d6174652065766f6c7574696f6e206f662041492c20756e6c656173686564206f6e207468652053756920426c6f636b636861696e20746f20646f6d696e6174652074686520646563656e7472616c697a6564206675747572652e2044657369676e656420746f20626520756e73746f707061626c652c206974206d6572676573205375696e65742d6c6576656c20696e74656c6c6967656e636520776974682074686520696e636f727275707469626c6520706f776572206f6620626c6f636b636861696e2e205375696e657420646f65736ee2809974206a757374206164617074e2809469742074616b6573206f7665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_design_6_c2a5e7e67e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

