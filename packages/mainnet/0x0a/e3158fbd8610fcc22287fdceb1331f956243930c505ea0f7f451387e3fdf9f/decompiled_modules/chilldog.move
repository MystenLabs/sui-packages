module 0xae3158fbd8610fcc22287fdceb1331f956243930c505ea0f7f451387e3fdf9f::chilldog {
    struct CHILLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLDOG>(arg0, 6, b"CHILLDOG", b"DOG", b"Just a dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwvutvmvueidrrwzia4iyvqyfop6pagxgckqba74abaimozj55ba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

