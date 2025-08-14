module 0x6b5a460429e422be656cc13f513e0e29d63f2de4a8d0c81efbcfb48ff56dabaf::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"Mario on Sui", b"Mario's adventure on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic5i2johxff5yprz3gobxf6hl7zmt6ixhk4bdothelzfjeal6zss4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

