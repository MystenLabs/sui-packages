module 0xf2794aabda8a49d40d56abce4c550fa36495f5b406376f920765eb46e2721288::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 6, b"BUB", b"BUBA", x"546865204368616f74696320476f6f642057697a617264206f66207468652053554920426c6f636b636861696e2e0a43617374207370656c6c732e20537461636b20626167732e20456d6272616365207468652077656972642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicljueagupsxwyalsabeprd2evw5ic2lkinwfkwdclqdk2vsh3pri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

