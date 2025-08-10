module 0x3acd96aeedb6ce7d52f29cfcdde59c89bd6978af0a69adca0d6b2ec7f9b6fbd4::navi {
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

    struct OracleProvider has copy, drop, store {
        name: 0x1::ascii::String,
    }

    struct OracleProviderConfig has store {
        provider: OracleProvider,
        enable: bool,
        pair_id: vector<u8>,
    }

    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        vec_feeds: vector<address>,
        feeds: 0x2::table::Table<address, PriceFeed>,
    }

    struct PriceFeed has store {
        id: 0x2::object::UID,
        enable: bool,
        max_timestamp_diff: u64,
        price_diff_threshold1: u64,
        price_diff_threshold2: u64,
        max_duration_within_thresholds: u64,
        diff_threshold2_timer: u64,
        maximum_allowed_span_percentage: u64,
        maximum_effective_price: u256,
        minimum_effective_price: u256,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        primary: OracleProvider,
        secondary: OracleProvider,
        oracle_provider_configs: 0x2::table::Table<OracleProvider, OracleProviderConfig>,
        historical_price_ttl: u64,
        history: History,
    }

    struct History has copy, store {
        price: u256,
        updated_time: u64,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: 0x2::table::Table<u8, Price>,
    }

    struct Price has store {
        value: u256,
        decimal: u8,
        timestamp: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_balance: 0x2::balance::Balance<T0>,
        decimal: u8,
    }

    // decompiled from Move bytecode v6
}

