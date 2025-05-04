module 0x23eab9ad29b51d82c83c128c4c15038c2a2fef4a48ccb94c1c631d142701c25e::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSE>(arg0, 6, b"HOUSE", b"Housecoin", b"The housing market will fail again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiei4shwwzm3x6chf5kjo7dbg3nox3d5peets7g5rjixewwvxulceu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

