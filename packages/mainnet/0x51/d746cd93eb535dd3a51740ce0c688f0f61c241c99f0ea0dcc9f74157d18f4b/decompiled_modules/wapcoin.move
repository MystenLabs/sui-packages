module 0x51d746cd93eb535dd3a51740ce0c688f0f61c241c99f0ea0dcc9f74157d18f4b::wapcoin {
    struct WAPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPCOIN>(arg0, 6, b"WAPcoin", b"WetAssPussyCoin", b"Tokenizing wet ass pussys in a PG format #WAPcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidin3uts4zlfzlu7ea2kek5juoj33nk4bds7bu2m64br73rkrn7qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAPCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

