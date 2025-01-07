module 0xf51f456213b1d0296b0d523074311c72e322e41ce2607519cd083a2225f70131::happycatty {
    struct HAPPYCATTY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYCATTY>, arg1: 0x2::coin::Coin<HAPPYCATTY>) {
        0x2::coin::burn<HAPPYCATTY>(arg0, arg1);
    }

    fun init(arg0: HAPPYCATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYCATTY>(arg0, 6, b"HAPPYCATTY", b"Happy Catty", b"This is a happy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://f4.bcbits.com/img/a4226911043_10.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYCATTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYCATTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYCATTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYCATTY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

