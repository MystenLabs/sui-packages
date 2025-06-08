module 0x2876f80fb5012a85f21a62a1a533dec533acd6953930e8eb6dc800fb1fc10042::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 6, b"HYPER", b"The Hyperbolic Review", b"The Hyperbolic Review is a magazine of mathematical poetry, aimed in the pursuit of beauty and elegance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4eboreugwzz44r4vdsttfizpokykop2x6n3kyp4iaoktc6whpr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HYPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

