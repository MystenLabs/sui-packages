module 0x9fa663a36657e9f8fdb7415e0ce66da0f8ffe7e953386c3bfa665f292712bb::hsuiUSDE {
    struct HSUIUSDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUIUSDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUIUSDE>(arg0, 6, b"hsuiUSDE", b"hsuiUSDE Coin", b"hsuiUSDE Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hsuiusde_03e7c76140_75447.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUIUSDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUIUSDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

