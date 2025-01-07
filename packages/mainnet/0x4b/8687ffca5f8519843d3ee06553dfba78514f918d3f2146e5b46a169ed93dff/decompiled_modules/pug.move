module 0x4b8687ffca5f8519843d3ee06553dfba78514f918d3f2146e5b46a169ed93dff::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 9, b"PUG", b"Pug", b"Just a Pug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/xMSZsXf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

