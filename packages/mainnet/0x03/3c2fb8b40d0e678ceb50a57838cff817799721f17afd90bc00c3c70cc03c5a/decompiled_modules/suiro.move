module 0x33c2fb8b40d0e678ceb50a57838cff817799721f17afd90bc00c3c70cc03c5a::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 9, b"SUIRO", b"SUIRO", b"Suiro is an AI-inspired token on the Sui blockchain, offering fast, low-cost transactions and advanced smart contract functionality within a scalable, tech-driven ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1296015409125011457/K2Qw_XRu.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRO>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

