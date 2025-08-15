module 0x27cb3b9060da1bd1611345e917deb60227420d72198f28f35c2f5564152d163e::ultra {
    struct ULTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULTRA>(arg0, 6, b"Ultra", b"Ultramen", x"ec82aceab080eb8d94ec9c8420ec82aceab080eb9dbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiawzanpothp7e626lee7trlzsvzzatin4fjudyx7exjczuztl3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULTRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ULTRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

