module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::asset {
    struct AssetConfig has copy, drop, store {
        min_borrow_amount: u64,
        max_borrow_amount: u64,
        max_deposit_amount: u64,
        repay_fee_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_fee_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    // decompiled from Move bytecode v6
}

