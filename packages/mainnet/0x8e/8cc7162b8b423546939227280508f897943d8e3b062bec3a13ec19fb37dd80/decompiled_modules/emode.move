module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::emode {
    struct NewEMode has copy, drop, store {
        collateral_factor: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_factor: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_incentive: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        max_borrow_amount: u64,
        borrow_weight: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        flash_loan_fee_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        deposit_limiter: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter::NewLimiter,
        borrow_limiter: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter::NewLimiter,
    }

    // decompiled from Move bytecode v6
}

