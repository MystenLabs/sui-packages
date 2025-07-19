module 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::custodian_wrapper {
    struct Custodian has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<address, UserPoolConfig>,
        accounts: 0x2::table::Table<address, UserPoolReserveInformation>,
    }

    struct UserPoolConfig has store {
        premium_interest_rate: u128,
        ltv: u128,
        liquidation_threshold: u128,
        recovery_ltv: u128,
        liquidate_buffer: u128,
    }

    struct UserPoolReserveInformation has store {
        timestamp_index: u64,
        collateral: u128,
        debt: u128,
        accumulated_interest: u128,
        claimable_collateral: u128,
    }

    struct PoolCreated has copy, drop {
        user: address,
        premium_interest_rate: u128,
        ltv: u128,
        liquidation_threshold: u128,
        liquidate_buffer: u128,
    }

    struct UserPoolConfigUpdated has copy, drop {
        user: address,
        premium_interest_rate: u128,
        ltv: u128,
        liquidation_threshold: u128,
    }

    public(friend) fun assert_pool_initialized(arg0: address, arg1: &Custodian) {
        assert!(0x2::table::contains<address, UserPoolReserveInformation>(&arg1.accounts, arg0), 1);
    }

    public fun buffer(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0).liquidate_buffer
    }

    public(friend) fun create_account(arg0: address, arg1: &mut Custodian, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::PoolManagerConfig, arg3: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<address, UserPoolReserveInformation>(&arg1.accounts, arg0), 0);
        let v0 = 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::premium_interest_rate(arg2);
        let v1 = 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::ltv(arg2);
        let v2 = 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::liquidation_threshold(arg2);
        let v3 = 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::buffer(arg2);
        let v4 = UserPoolConfig{
            premium_interest_rate : v0,
            ltv                   : v1,
            liquidation_threshold : v2,
            recovery_ltv          : 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config::recovery_ltv(arg2),
            liquidate_buffer      : v3,
        };
        let v5 = UserPoolReserveInformation{
            timestamp_index      : 0x2::clock::timestamp_ms(arg3) / 1000,
            collateral           : 0,
            debt                 : 0,
            accumulated_interest : 0,
            claimable_collateral : 0,
        };
        0x2::table::add<address, UserPoolConfig>(&mut arg1.configs, arg0, v4);
        0x2::table::add<address, UserPoolReserveInformation>(&mut arg1.accounts, arg0, v5);
        let v6 = PoolCreated{
            user                  : arg0,
            premium_interest_rate : v0,
            ltv                   : v1,
            liquidation_threshold : v2,
            liquidate_buffer      : v3,
        };
        0x2::event::emit<PoolCreated>(v6);
    }

    public fun get_user_accumulated_interest(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolReserveInformation>(&arg1.accounts, arg0).accumulated_interest
    }

    public fun get_user_claimable_collateral(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolReserveInformation>(&arg1.accounts, arg0).claimable_collateral
    }

    public fun get_user_collateral(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolReserveInformation>(&arg1.accounts, arg0).collateral
    }

    public fun get_user_debt(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolReserveInformation>(&arg1.accounts, arg0).debt
    }

    public fun get_user_pool_config(arg0: address, arg1: &Custodian) : &UserPoolConfig {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0)
    }

    public fun get_user_reserve_timestamp(arg0: address, arg1: &Custodian) : u64 {
        0x2::table::borrow<address, UserPoolReserveInformation>(&arg1.accounts, arg0).timestamp_index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian{
            id       : 0x2::object::new(arg0),
            configs  : 0x2::table::new<address, UserPoolConfig>(arg0),
            accounts : 0x2::table::new<address, UserPoolReserveInformation>(arg0),
        };
        0x2::transfer::share_object<Custodian>(v0);
    }

    public fun liquidation_threshold(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0).liquidation_threshold
    }

    public fun ltv(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0).ltv
    }

    public fun premium_interest_rate(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0).premium_interest_rate
    }

    public fun recovery_ltv(arg0: address, arg1: &Custodian) : u128 {
        0x2::table::borrow<address, UserPoolConfig>(&arg1.configs, arg0).recovery_ltv
    }

    public(friend) fun set_user_pool_config(arg0: address, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut Custodian) {
        assert!(arg1 < 2000, 2);
        let v0 = if (arg2 < arg4) {
            if (arg4 < arg3) {
                arg3 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x2::table::borrow_mut<address, UserPoolConfig>(&mut arg5.configs, arg0);
        v1.premium_interest_rate = arg1;
        v1.liquidation_threshold = arg3;
        v1.ltv = arg2;
        v1.recovery_ltv = arg4;
        let v2 = UserPoolConfigUpdated{
            user                  : arg0,
            premium_interest_rate : arg1,
            ltv                   : arg2,
            liquidation_threshold : arg3,
        };
        0x2::event::emit<UserPoolConfigUpdated>(v2);
    }

    public(friend) fun update_user_accumulated_interest(arg0: address, arg1: u128, arg2: &mut Custodian) {
        0x2::table::borrow_mut<address, UserPoolReserveInformation>(&mut arg2.accounts, arg0).accumulated_interest = arg1;
    }

    public(friend) fun update_user_claimable_collateral(arg0: address, arg1: u128, arg2: &mut Custodian) {
        0x2::table::borrow_mut<address, UserPoolReserveInformation>(&mut arg2.accounts, arg0).claimable_collateral = arg1;
    }

    public(friend) fun update_user_collateral(arg0: address, arg1: u128, arg2: &mut Custodian) : u128 {
        let v0 = 0x2::table::borrow_mut<address, UserPoolReserveInformation>(&mut arg2.accounts, arg0);
        v0.collateral = arg1;
        v0.collateral
    }

    public(friend) fun update_user_debt(arg0: address, arg1: u128, arg2: &mut Custodian) {
        0x2::table::borrow_mut<address, UserPoolReserveInformation>(&mut arg2.accounts, arg0).debt = arg1;
    }

    public(friend) fun update_user_reserve(arg0: address, arg1: u128, arg2: u128, arg3: &mut Custodian, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, UserPoolReserveInformation>(&mut arg3.accounts, arg0);
        v0.accumulated_interest = v0.accumulated_interest + arg1;
        v0.debt = arg2;
        v0.timestamp_index = 0x2::clock::timestamp_ms(arg4) / 1000;
    }

    // decompiled from Move bytecode v6
}

