module 0x601d91055a84fb5c63ac4a09e379c8110cad9a7ffff329893c1aca94ef74b7fb::anarchy {
    struct ANARCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANARCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANARCHY>(arg0, 6, b"ANARCHY", b"Anarchy World", b"Anarchy World , become a Wizard in the strange world and fight with dragons and zombies to earn SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidru5yagubtb4mje4pdaddey3njdsxxvz7qfijx3ilmisw2wd3qva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANARCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANARCHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

