module 0xe62aa5da5c124d3c72bd6b634e5460989f1499c0da2bb748482f9d91e776e8f3::ss_af_lp {
    struct SS_AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS_AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS_AF_LP>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SS_AF_LP", b"Super Smart LP", b"Some super smart LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS_AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS_AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

