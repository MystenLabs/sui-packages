module 0xf36551a2e6e22f0fda8bfbd551c1a4241ffae7b7e6c23e1a2b3bc1e5d3ab5aeb::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_LP>(arg0, 9, b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/af-lp.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

