module 0x672cbf6437b314ebdc1a28360bc19af070ed4a6800a5d3747e190ca9984b4370::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_LP>(arg0, 0x4e590134a0fb4644e842d55e558b74435084dd7a43de290072221d8c37d351b9::constants::lp_decimals(), b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/af-lp.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

