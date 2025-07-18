module 0x36bc08ab31d988f23d8ae41a8991796ab348bbb96f35d081577b0a85f83e67a4::mememe {
    struct MEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEME>(arg0, 6, b"Mememe", b"Meme", b"Me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih53jdezibo3fuawxvtk2n6rijvy3ofucjczkdlzjceqjofu6jis4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

