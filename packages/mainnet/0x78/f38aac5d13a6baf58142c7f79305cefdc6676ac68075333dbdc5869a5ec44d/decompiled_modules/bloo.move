module 0x78f38aac5d13a6baf58142c7f79305cefdc6676ac68075333dbdc5869a5ec44d::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"Bloo", b"Bloo Sui", b"Fast, fun, and fueled by memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiblyux6osyqb36q7jqg3gbouyqf3gyattzzpeif6weaxs46dwp224")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

