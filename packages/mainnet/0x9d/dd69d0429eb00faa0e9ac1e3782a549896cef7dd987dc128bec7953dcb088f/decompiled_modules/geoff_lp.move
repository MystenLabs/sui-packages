module 0x9ddd69d0429eb00faa0e9ac1e3782a549896cef7dd987dc128bec7953dcb088f::geoff_lp {
    struct GEOFF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEOFF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEOFF_LP>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"GEOFF_LP", b"geofflp", b"GEOFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEOFF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEOFF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

