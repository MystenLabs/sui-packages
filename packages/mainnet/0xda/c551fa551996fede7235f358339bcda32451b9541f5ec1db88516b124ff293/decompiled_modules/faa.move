module 0xdac551fa551996fede7235f358339bcda32451b9541f5ec1db88516b124ff293::faa {
    struct FAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAA>(arg0, 6, b"FAA", b"fdsa", b"FA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighxf5e3m53fw35qudl2tyib5qkgdfxhizffsgtycj3533ie3crhy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

