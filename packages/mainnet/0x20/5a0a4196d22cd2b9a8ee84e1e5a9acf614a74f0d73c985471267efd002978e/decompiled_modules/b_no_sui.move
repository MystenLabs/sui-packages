module 0x205a0a4196d22cd2b9a8ee84e1e5a9acf614a74f0d73c985471267efd002978e::b_no_sui {
    struct B_NO_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NO_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NO_SUI>(arg0, 9, b"bnoSUI", b"bToken noSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NO_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NO_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

