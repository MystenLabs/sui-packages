module 0xaa939fcb72a37abbe8e5a15cc24566ac78f8c1441eac49d1277925e7eec03386::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 6, b"BAG", b"Based grok", b"Cry more. That'll help ppl forget.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwksf4atguo4xku2u5w2t6wwme5ii4zlrw4tdwz6zft5qrlaq6jq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

