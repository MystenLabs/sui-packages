module 0xa5779f297b000d4a1723ffab2f8af534ef2f37d7b1b3b8ec89cce8c63596e1fb::lockdrop {
    struct LockdropRewardsCapabilityHolder has key {
        id: 0x2::object::UID,
        capability: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability,
    }

    struct LockdropVault has store, key {
        id: 0x2::object::UID,
        hive_profile: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveProfile,
        user_profile_access_cap: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability,
        krafted_pools: 0x2::table::Table<0x1::string::String, address>,
        sui_total_locked: u64,
        sui_total_weighted_units: u128,
        hive_sui_total_received: u64,
        hive_available: 0x2::balance::Balance<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>,
        total_hive_incentives: u64,
        degenhive_lps_krafted: 0x2::balance::Balance<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>,
        total_lp_krafted: u64,
        are_staked_with_pool_hive: bool,
        dlps_staked_amount: u64,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct BeeFruitDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_index: u256,
        available_bee_fruits: 0x2::balance::Balance<T0>,
        total_bee_fruits_earned: u64,
    }

    // decompiled from Move bytecode v6
}

