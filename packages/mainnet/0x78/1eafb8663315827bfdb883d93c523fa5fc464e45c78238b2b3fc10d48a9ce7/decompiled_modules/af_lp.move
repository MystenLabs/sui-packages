module 0x781eafb8663315827bfdb883d93c523fa5fc464e45c78238b2b3fc10d48a9ce7::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_LP>(arg0, 0xe2c31b248b3495b9c41e2ed6080b23ea9cfa1b0c615e2a5e4984548e2a316972::constants::lp_decimals(), b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/af-lp.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

