module 0x18d0d5e1c57c0efbd659f2340cab1e8697f3b1cf0e82e9a1b646340b5227b19b::b_metapod {
    struct B_METAPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_METAPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_METAPOD>(arg0, 9, b"bMETAPOD", b"bToken METAPOD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_METAPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_METAPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

