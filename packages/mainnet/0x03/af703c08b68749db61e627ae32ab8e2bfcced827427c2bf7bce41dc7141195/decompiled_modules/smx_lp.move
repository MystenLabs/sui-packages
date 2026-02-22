module 0x3af703c08b68749db61e627ae32ab8e2bfcced827427c2bf7bce41dc7141195::smx_lp {
    struct SMX_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMX_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMX_LP>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SMX_LP", b"SUI MAX LP", b"SUI MAX Vault LP token on Aftermath Perpetuals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMX_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMX_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

