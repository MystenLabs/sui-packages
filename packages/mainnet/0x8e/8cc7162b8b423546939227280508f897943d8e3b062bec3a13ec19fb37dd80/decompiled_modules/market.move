module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market {
    struct FlashLoan<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        liquidity_miner: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_miner::LiquidityMiner<T0>,
    }

    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    // decompiled from Move bytecode v6
}

