module 0xcc19b01d22548797caf3571c8a8804f8daf9af2c549f7ec25e44f431fd363997::navi {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct StorageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        reserves: 0x2::table::Table<u8, ReserveData>,
        reserves_count: u8,
        users: vector<address>,
        user_info: 0x2::table::Table<address, UserInfo>,
    }

    struct ReserveData has store {
        id: u8,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        is_isolated: bool,
        supply_cap_ceiling: u256,
        borrow_cap_ceiling: u256,
        current_supply_rate: u256,
        current_borrow_rate: u256,
        current_supply_index: u256,
        current_borrow_index: u256,
        supply_balance: TokenBalance,
        borrow_balance: TokenBalance,
        last_update_timestamp: u64,
        ltv: u256,
        treasury_factor: u256,
        treasury_balance: u256,
        borrow_rate_factors: BorrowRateFactors,
        liquidation_factors: LiquidationFactors,
        reserve_field_a: u256,
        reserve_field_b: u256,
        reserve_field_c: u256,
    }

    struct UserInfo has store {
        collaterals: vector<u8>,
        loans: vector<u8>,
    }

    struct ReserveConfigurationMap has copy, store {
        data: u256,
    }

    struct UserConfigurationMap has copy, store {
        data: u256,
    }

    struct TokenBalance has store {
        user_state: 0x2::table::Table<address, u256>,
        total_supply: u256,
    }

    struct BorrowRateFactors has store {
        base_rate: u256,
        multiplier: u256,
        jump_rate_multiplier: u256,
        reserve_factor: u256,
        optimal_utilization: u256,
    }

    struct LiquidationFactors has store {
        ratio: u256,
        bonus: u256,
        threshold: u256,
    }

    struct StorageConfiguratorSetting has copy, drop {
        sender: address,
        configurator: address,
        value: bool,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    // decompiled from Move bytecode v6
}

