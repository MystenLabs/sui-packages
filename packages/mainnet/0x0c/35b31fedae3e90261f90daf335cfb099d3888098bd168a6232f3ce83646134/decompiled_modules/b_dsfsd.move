module 0xc35b31fedae3e90261f90daf335cfb099d3888098bd168a6232f3ce83646134::b_dsfsd {
    struct B_DSFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DSFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DSFSD>(arg0, 9, b"bDSFSD", b"bToken DSFSD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DSFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DSFSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

