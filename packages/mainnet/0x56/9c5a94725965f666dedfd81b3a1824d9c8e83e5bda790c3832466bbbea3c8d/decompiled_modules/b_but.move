module 0x569c5a94725965f666dedfd81b3a1824d9c8e83e5bda790c3832466bbbea3c8d::b_but {
    struct B_BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BUT>(arg0, 9, b"bBUT", b"bToken BUT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

