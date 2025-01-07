module 0x65fbb273b1da1f39442675266f8c061c1b5d73a2240615d7fce9b8f96b9d99de::steve {
    struct STEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVE>(arg0, 9, b"STEVE", b"STEVE STEVE", b"Grab the pickaxe - join the cult!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreieenrrke22jze5wqfvorvbhz5oa5eumhzvbijuqvxnw3rillz7tm4.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

