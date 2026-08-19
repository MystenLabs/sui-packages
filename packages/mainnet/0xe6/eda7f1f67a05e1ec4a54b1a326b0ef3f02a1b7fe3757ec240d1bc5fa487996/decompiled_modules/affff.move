module 0xe6eda7f1f67a05e1ec4a54b1a326b0ef3f02a1b7fe3757ec240d1bc5fa487996::affff {
    struct AFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFFFF>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"AFFFF", b"adf", b"f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

