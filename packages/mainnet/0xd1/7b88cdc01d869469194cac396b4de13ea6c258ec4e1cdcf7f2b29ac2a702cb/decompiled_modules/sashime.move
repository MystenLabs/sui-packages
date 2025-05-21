module 0xd17b88cdc01d869469194cac396b4de13ea6c258ec4e1cdcf7f2b29ac2a702cb::sashime {
    struct SASHIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHIME>(arg0, 6, b"SASHIME", b"SHASHIME the cutest SUSHI", b"Shashime - the cutest sushi is preparing to cook! Not just a plain rice with a fish hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictqsilpknrd63ivp2266u6r3kxxtv3uwhiknc4myt56pf6gmbdcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SASHIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

