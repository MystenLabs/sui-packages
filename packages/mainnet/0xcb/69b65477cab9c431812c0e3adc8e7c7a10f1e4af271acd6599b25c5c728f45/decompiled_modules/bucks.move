module 0xcb69b65477cab9c431812c0e3adc8e7c7a10f1e4af271acd6599b25c5c728f45::bucks {
    struct BUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKS>(arg0, 9, b"BUCKS", b"BlueBucks", b"BlueBucks is a fun, water-themed token name combining \"blue\" for trust and fluidity with \"bucks\" for money. It suggests a cool, reliable currency that flows smoothly through the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745096851211042816/x93h6qg4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUCKS>(&mut v2, 1200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

