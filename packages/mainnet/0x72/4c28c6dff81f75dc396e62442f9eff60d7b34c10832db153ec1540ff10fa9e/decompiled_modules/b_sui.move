module 0x724c28c6dff81f75dc396e62442f9eff60d7b34c10832db153ec1540ff10fa9e::b_sui {
    struct B_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUI>(arg0, 9, b"bSUI", b"bToken SUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

