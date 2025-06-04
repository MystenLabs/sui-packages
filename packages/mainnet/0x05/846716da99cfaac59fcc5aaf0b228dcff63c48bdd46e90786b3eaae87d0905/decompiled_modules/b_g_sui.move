module 0x5846716da99cfaac59fcc5aaf0b228dcff63c48bdd46e90786b3eaae87d0905::b_g_sui {
    struct B_G_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_G_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_G_SUI>(arg0, 9, b"bgSUI", b"bToken gSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_G_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_G_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

