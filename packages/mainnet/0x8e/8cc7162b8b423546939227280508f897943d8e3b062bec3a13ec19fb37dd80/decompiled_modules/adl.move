module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::adl {
    struct DeleverageParams has copy, drop, store {
        target_amount: u64,
        liquidation_factor_base: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_factor_hourly_drop: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_incentive_base: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_incentive_daily_penalty: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        close_factor: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    // decompiled from Move bytecode v6
}

