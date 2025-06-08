module 0x71324bcdb86fa361e1841d1553774633d08b5a412e6c0dbd09dbb00c933d4b6c::thehype {
    struct THEHYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEHYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEHYPE>(arg0, 6, b"THEHYPE", b"The Hyperbolic Review", b"The Hyperbolic Review is a magazine of mathematical poetry, aimed in the pursuit of beauty and elegance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4eboreugwzz44r4vdsttfizpokykop2x6n3kyp4iaoktc6whpr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEHYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THEHYPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

