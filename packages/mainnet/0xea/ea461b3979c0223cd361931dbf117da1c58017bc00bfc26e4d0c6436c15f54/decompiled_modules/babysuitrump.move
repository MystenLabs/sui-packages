module 0xeaea461b3979c0223cd361931dbf117da1c58017bc00bfc26e4d0c6436c15f54::babysuitrump {
    struct BABYSUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUITRUMP>(arg0, 6, b"BABYSUITRUMP", b"Baby Sui Trump", b"Description in TG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhk4coqiok4ooht7hkwhzm3yizbbjt6qordhzbqyjcpobm7aprza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYSUITRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

