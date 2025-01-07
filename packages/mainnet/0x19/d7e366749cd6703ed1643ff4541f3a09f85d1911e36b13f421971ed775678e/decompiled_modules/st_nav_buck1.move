module 0x19d7e366749cd6703ed1643ff4541f3a09f85d1911e36b13f421971ed775678e::st_nav_buck1 {
    struct ST_NAV_BUCK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_NAV_BUCK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_NAV_BUCK1>(arg0, 9, b"ST_NAV_BUCK1", b"Navi stablecoin Strategy with Bucket and Strater", b"An LP token representing a strategy that involves depositing USDT, borrowing USDC, and staking the combined assets into a strater saving pool to optimize yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcwJmwsx1q4MEbx4fdBwb2mDHed7nBAEQmacY1pYXiXFT")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_NAV_BUCK1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_NAV_BUCK1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

