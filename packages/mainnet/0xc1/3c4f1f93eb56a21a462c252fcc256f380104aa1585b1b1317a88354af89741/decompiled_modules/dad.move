module 0xc13c4f1f93eb56a21a462c252fcc256f380104aa1585b1b1317a88354af89741::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 6, b"DAD", b"Daily Dose", b"Instead of having fear of losing profits when you are up, you should have hope they go higher.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigh4q7flsziph5jzsiaowsxetleivd26lhcgwvapzgmxqjzbrlhee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

