module 0xf0b3ef81d209393ffa0fb52f4d1ff9c8b59d96a02c6fa3558ccda90133a3a75e::b_blazz {
    struct B_BLAZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLAZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLAZZ>(arg0, 9, b"bBLAZZ", b"bToken BLAZZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLAZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLAZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

