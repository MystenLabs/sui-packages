module 0x99fa27a2283088102698505c1763f74b5da808a99066bf9c3c2fe420beba946a::catto {
    struct CATTO has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x82044a5ff43cb7ad41c1693493991a8cf240704cab3b124d4d07e042b9662cd4
    }

    fun init(arg0: CATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CATTO>(arg0, 9, 0x1::string::utf8(b"CATTO"), 0x1::string::utf8(b"Cattoo"), 0x1::string::utf8(b"Meme"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeifdbxqkepnicgydbo63fugezdaipgsyu4l2elodgnbndhysrxxn5q"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CATTO>>(0x2::coin_registry::finalize<CATTO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

