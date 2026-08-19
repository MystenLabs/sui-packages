module 0x1d13e77321fd47fb1a97b68c3c4bbb79d7763e52f0fa8d2c9ad69da29c3d3dae::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"FFFF", b"ff", b"f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

