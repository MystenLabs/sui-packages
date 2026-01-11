module 0x406f93ea48ef7eedc7de4c3e7d50c367c606f0979e0e0990311df3b4e4e8a6f2::b_slz {
    struct B_SLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SLZ>(arg0, 9, b"bSLZ", b"bToken SLZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

