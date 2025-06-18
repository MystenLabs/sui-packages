module 0x1f2015525bc1fa5509b1e93f2dd87b7d2c8184477788724ac2847bdce5e9670a::fgh {
    struct FGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGH>(arg0, 6, b"FGH", b"fghfbgv", b"fghfbgvfghfbgvfghfbgv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5fk5k4vdpl33pzesopxldzikuxb6hhpjqqdgsgsk67dvwjkt75u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FGH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

