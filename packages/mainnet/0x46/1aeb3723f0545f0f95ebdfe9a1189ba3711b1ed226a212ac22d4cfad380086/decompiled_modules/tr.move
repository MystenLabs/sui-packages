module 0x461aeb3723f0545f0f95ebdfe9a1189ba3711b1ed226a212ac22d4cfad380086::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"TR", b"Trend", b"A systematic, rule-based approach to crypto trading with dynamic risk management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/3/33/Cartoon_space_rocket.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

