module 0x45677da26f1bcff9ddc683aceda3c2d9eedee10769161712de9f9cf595d67de9::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"A", b"ff", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

