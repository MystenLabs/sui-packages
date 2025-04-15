module 0xc080fed7cc0022b8e6c6a2d54a8e101f6364f950acdc5ef137516b85fedab579::dragon_test_154 {
    struct DRAGON_TEST_154 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON_TEST_154, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON_TEST_154>(arg0, 6, b"Dragon_test_154", b"Dragon_test", b"Dragon_test_154s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiblefnzylqapid43vgrdaoupivxanbvgark7kylhmzqhyxqcg2p44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON_TEST_154>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGON_TEST_154>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

