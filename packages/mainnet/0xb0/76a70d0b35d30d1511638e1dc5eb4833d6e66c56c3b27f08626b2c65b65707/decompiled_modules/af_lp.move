module 0xb076a70d0b35d30d1511638e1dc5eb4833d6e66c56c3b27f08626b2c65b65707::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_LP>(arg0, 0x35a7a5dc6879bace4eb02775d13875167f9ac352ebc6b6493122290e42292d44::constants::lp_decimals(), b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/af-lp.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

