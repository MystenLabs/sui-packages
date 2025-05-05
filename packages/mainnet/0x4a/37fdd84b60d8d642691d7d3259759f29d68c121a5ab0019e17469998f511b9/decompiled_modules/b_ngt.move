module 0x4a37fdd84b60d8d642691d7d3259759f29d68c121a5ab0019e17469998f511b9::b_ngt {
    struct B_NGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NGT>(arg0, 9, b"bNGT", b"bToken NGT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

