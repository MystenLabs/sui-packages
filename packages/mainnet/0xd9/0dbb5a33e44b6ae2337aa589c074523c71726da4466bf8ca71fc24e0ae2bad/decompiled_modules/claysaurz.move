module 0xd90dbb5a33e44b6ae2337aa589c074523c71726da4466bf8ca71fc24e0ae2bad::claysaurz {
    struct CLAYSAURZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAYSAURZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAYSAURZ>(arg0, 6, b"Claysaurz", b"Claynosaurz", b"Let your imagination Saur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiamctvs52g7icb2uylip6e5pa4k5nazhyzsttynvuwykrqfea5enm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAYSAURZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLAYSAURZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

