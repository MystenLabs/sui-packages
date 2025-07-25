module 0x4d9416421453b649722cde3a996eb11c0ad2f2580c3168cd5eacc7913c8ec04d::arceus {
    struct ARCEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCEUS>(arg0, 6, b"Arceus", b"The Pokemon God", x"4b6e6f776e20617320546865204f726967696e616c204f6e652c2041726365757320637265617465642074686520506f6bc3a96d6f6e20756e6976657273652c2073686170696e672074696d652c2073706163652c20616e64206d6174746572207769746820646976696e6520707265636973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5pbpmmk775rv3drnc6fc5itvvkewmlbtuy7mrv6r4tadqn2fwdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARCEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

