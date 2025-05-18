module 0x972a33452aea11e3e04db83c58a3dc1ee014526b1b58f61308b5b85a2ecc05e4::b_pumpkin_sui {
    struct B_PUMPKIN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PUMPKIN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PUMPKIN_SUI>(arg0, 9, b"bpumpkinSUI", b"bToken pumpkinSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PUMPKIN_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PUMPKIN_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

