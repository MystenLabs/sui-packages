module 0xa9059150a1ea1785ab503b98019e46e4678dca1a04d367c1b535bf1d3dadbaff::b_epi {
    struct B_EPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EPI>(arg0, 9, b"bEPI", b"bToken EPI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

