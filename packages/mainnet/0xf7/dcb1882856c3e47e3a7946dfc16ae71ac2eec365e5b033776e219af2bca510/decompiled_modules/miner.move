module 0xf7dcb1882856c3e47e3a7946dfc16ae71ac2eec365e5b033776e219af2bca510::miner {
    struct MINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINER>(arg0, 6, b"Miner", b"depths Miner", x"46726f6d207468652064657074687320746f2074686520544f50f09f928e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734515359698.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

