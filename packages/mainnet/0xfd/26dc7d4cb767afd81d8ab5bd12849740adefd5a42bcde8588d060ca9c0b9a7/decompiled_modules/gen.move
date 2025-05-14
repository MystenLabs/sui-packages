module 0xfd26dc7d4cb767afd81d8ab5bd12849740adefd5a42bcde8588d060ca9c0b9a7::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 6, b"GEN", b"Gen R95", b"A young man with a scavenger soul and finally successful with SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifgjbawsl32wyppuym4fcto6uxspng22i2yg7q4bpvpyzxjgqfabe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

