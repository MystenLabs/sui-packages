module 0xa912cc1d771d499ac7d53ef9587bdc601c5b0e7d9235d6be56dd87939796f0c8::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 9, b"SUISHIBA", b"Sui Shiba", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/17115/large/shiba-logo-v2_2x.png?1696516675")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

