module 0x68d4b2bdf406321cd4cb379d189fff64f44ce0dd8c0f5eb38d019b01a0b3a99d::aether {
    struct AETHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AETHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AETHER>(arg0, 9, b"aether", b"aether collective", b"Aether is an open-source framework that bridges AI and human innovation, enabling decentralized intelligence through modular systems. Designed for flexibility and collaboration, it empowers developers to build autonomous agents, harness blockchain, and optimize resources seamlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQQqwEpravh9LxBGWdYTHnNgvikcu3z5NJ4mjFXczbxdN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AETHER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AETHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AETHER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

