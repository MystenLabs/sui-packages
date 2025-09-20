module 0xe5d6fb59b8af5c40163739581c386045bd7a5eb5287411a8c8990b7bdcff090c::b_tabc {
    struct B_TABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TABC>(arg0, 9, b"bTABC", b"bToken TABC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

