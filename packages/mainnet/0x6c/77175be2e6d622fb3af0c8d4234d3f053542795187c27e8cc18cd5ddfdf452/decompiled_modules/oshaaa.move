module 0x6c77175be2e6d622fb3af0c8d4234d3f053542795187c27e8cc18cd5ddfdf452::oshaaa {
    struct OSHAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHAAA>(arg0, 6, b"OSHAAA", b"Oshaa Sui", b"Oshaaa oshaaa oshaaa.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmlvmjwv5tso2qok7ea3k3vax2zphoqiodizue6igo4chzamcsya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSHAAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

