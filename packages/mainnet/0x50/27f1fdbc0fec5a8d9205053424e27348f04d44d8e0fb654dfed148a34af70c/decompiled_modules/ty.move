module 0x5027f1fdbc0fec5a8d9205053424e27348f04d44d8e0fb654dfed148a34af70c::ty {
    struct TY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TY>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"TY", b"Trendy", b"A systematic, rule-based approach to crypto trading with dynamic risk management", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

