module 0x19367eee7e9cc20806f22db29968f1972d7152a60a1d084da0b2c1535815af1c::referral_vault {
    struct ReferralVault has key {
        id: 0x2::object::UID,
        version: u64,
        referrer_addresses: 0x2::table::Table<address, address>,
        rebates: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    // decompiled from Move bytecode v6
}

