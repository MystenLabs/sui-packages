module 0x16a989afbefa77ac752b62d7205bfc7b6b70dcc38006bad00ca8a011d531f60::b_oink_sui {
    struct B_OINK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OINK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OINK_SUI>(arg0, 9, b"boinkSUI", b"bToken oinkSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OINK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OINK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

