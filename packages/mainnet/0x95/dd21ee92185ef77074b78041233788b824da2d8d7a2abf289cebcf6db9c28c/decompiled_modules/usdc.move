module 0x95dd21ee92185ef77074b78041233788b824da2d8d7a2abf289cebcf6db9c28c::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"USDC", b"Circle stable", b"For test run, if all goes as intend we'll open with good value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

