module 0x1b1c020000cb3c14ee127656c954aa6d3d3c342347af2e3a7510484779515211::jowh {
    struct JOWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOWH>(arg0, 6, b"JOWH", b"JollyWhale", b"JollyWhale is more than a meme token its a catalyst for change. By donating a portion of each transaction to a different charity each month through a community votemaking every trade not only profitable but impactful. Join us and make a splash for g...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicrtqraq2hxv7tdsjn6mvtot2u57oxymfapmt5p3wnn5qogiwdpzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOWH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

