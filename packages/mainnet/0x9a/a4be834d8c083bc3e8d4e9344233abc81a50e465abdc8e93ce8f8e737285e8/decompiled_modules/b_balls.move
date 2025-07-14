module 0x9aa4be834d8c083bc3e8d4e9344233abc81a50e465abdc8e93ce8f8e737285e8::b_balls {
    struct B_BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BALLS>(arg0, 9, b"bBALLS", b"bToken BALLS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

