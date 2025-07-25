module 0xc7e8bf291a98f3f1afc143188468911301a4bcb18fbfe599fc0c60402f40b6c0::arceus {
    struct ARCEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCEUS>(arg0, 6, b"ARCEUS", b"Arceus - The AI Pokemon God", x"546865204f726967696e616c204f6e652c2063726561746f72206f662074686520506f6bc3a96d6f6e20756e6976657273652c206e6f7720616e204149206167656e74206f6620636f736d696320696e74656c6c6967656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5pbpmmk775rv3drnc6fc5itvvkewmlbtuy7mrv6r4tadqn2fwdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARCEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

