module 0x76129fd6ea243ef84d6d4a0773faed320a5afeefa533085bdaf6ac2c06c1f43b::b_xsui {
    struct B_XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XSUI>(arg0, 9, b"bxSUI", b"bToken xSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

