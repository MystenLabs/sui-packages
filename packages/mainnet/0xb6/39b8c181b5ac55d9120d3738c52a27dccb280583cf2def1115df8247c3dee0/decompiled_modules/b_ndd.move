module 0xb639b8c181b5ac55d9120d3738c52a27dccb280583cf2def1115df8247c3dee0::b_ndd {
    struct B_NDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NDD>(arg0, 9, b"bNDD", b"bToken NDD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

