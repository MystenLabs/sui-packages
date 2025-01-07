module 0xb7bc63ad0cde567fa6e7c4589332513a3b0df3c29e282b011f7532a65bbc1ba5::dgu_eth {
    struct DGU_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGU_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGU_ETH>(arg0, 6, b"dguETH", b"dguETH", b"dguETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGU_ETH>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DGU_ETH>>(v0);
    }

    // decompiled from Move bytecode v6
}

