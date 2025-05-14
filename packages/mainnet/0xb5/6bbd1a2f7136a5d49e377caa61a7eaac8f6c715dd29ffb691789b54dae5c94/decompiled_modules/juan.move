module 0xb56bbd1a2f7136a5d49e377caa61a7eaac8f6c715dd29ffb691789b54dae5c94::juan {
    struct JUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUAN>(arg0, 6, b"JUAN", b"JUAN CENA", b"Send it!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiecfhijoivqdecvo3p4py22zc5iyhudk3iy5qohnqhye5su63qbne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

