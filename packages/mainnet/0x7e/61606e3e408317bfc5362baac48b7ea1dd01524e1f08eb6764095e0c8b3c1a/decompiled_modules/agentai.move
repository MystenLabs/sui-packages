module 0x7e61606e3e408317bfc5362baac48b7ea1dd01524e1f08eb6764095e0c8b3c1a::agentai {
    struct AGENTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://ipfs.io/ipfs/bafkreidjp5e64xyhum3emvm5xbj4hxopmhekgnxfs2gvmdplngtqyeud4a";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<AGENTAI>(arg0, 9, b"AGENT AI", b"AGNAI", x"4e6569726f20414920e2809320546865206d656d65636f696e207265766f6c7574696f6e20706f77657265642062792053756920426c6f636b636861696e2e204120706c617966756c2079657420696e74656c6c6967656e7420746f6b656e2c20626c656e64696e6720414920696e6e6f766174696f6e207769746820626c6f636b636861696e20707265636973696f6e2e2044657369676e656420746f20626520796f75722072656c6961626c6520636f6d70616e696f6e20696e20746865206469676974616c2065636f6e6f6d792e", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<AGENTAI>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENTAI>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AGENTAI>>(v4);
    }

    // decompiled from Move bytecode v6
}

