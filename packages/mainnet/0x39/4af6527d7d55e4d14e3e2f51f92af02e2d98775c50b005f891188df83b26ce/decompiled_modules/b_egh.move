module 0x394af6527d7d55e4d14e3e2f51f92af02e2d98775c50b005f891188df83b26ce::b_egh {
    struct B_EGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EGH>(arg0, 9, b"bEGH", b"bToken EGH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

