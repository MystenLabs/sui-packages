module 0x52b019f2e16a7e25abd87a01421174e2d157f6bd921477428b207ddff451eded::ryulp {
    struct RYULP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYULP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYULP>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"RYULP", b"Ryu LP", b"LP token for Ryu autonomous AI market-making vault on Aftermath Perps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYULP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYULP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

