module 0x42970f3c4f966235618d660f26c0dd0f4688f6f67aaeab1dab03e99e7257c842::nibbles {
    struct NIBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIBBLES>(arg0, 9, b"NIBBLES", b"Nibbles", b"Meet Nibbles, a 100% fair launched project for a curious red panda who yearned for more than his daily routine of bamboo feedings andschedulednaps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWRS5CwWjfn1EJRAACRgfgDN7qD5SnwAzvunVQPCj9rYx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIBBLES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIBBLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIBBLES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

