module 0xbe818beed89c7d1b86a0666ce6bd033bb5fa56bbfc1eac7198d3b9f090400178::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"Boom Cat", b"\"Boom cat\" can refer to a piece of heavy machinery with a derrick on a Caterpillar tractor, used in strip mining to remove overburden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeided3dm7mxwme2y7r4dbxceqhh2coplseoh5vvez66a4phtmuzv3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

