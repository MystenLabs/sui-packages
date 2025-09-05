module 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::staking {
    struct Pool has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct PoolInner has store {
        is_paused: bool,
        staked: 0x2::balance::Balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>,
        max_pool_staked_amount: u64,
        min_stake_amount: u64,
        fee_config: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::FeeConfig,
        fees: 0x2::balance::Balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>,
        latest_accounting_timestamp: u64,
        accounting_interval: u64,
    }

    struct Staked has copy, drop {
        total_staked: u64,
        total_fees: u64,
        original_amount: u64,
        amount_after_fee: u64,
        shares: u64,
        fee: u64,
    }

    struct Unstaked has copy, drop {
        total_staked: u64,
        total_fees: u64,
        original_amount: u64,
        amount_after_fee: u64,
        fee: u64,
    }

    struct InterestUpdated has copy, drop {
        previous_total_staked: u64,
        new_total_staked: u64,
        today_interest: u64,
        today_extra_interest: u64,
        interest_to_mint_burn: u64,
        is_positive: bool,
        accounting_timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    struct SetAccountingInterval has copy, drop {
        previous_accounting_interval: u64,
        new_accounting_interval: u64,
    }

    struct SetMaxPoolStakedAmount has copy, drop {
        previous_max_pool_staked_amount: u64,
        new_max_pool_staked_amount: u64,
    }

    struct SetMinStakeAmount has copy, drop {
        previous_min_stake_amount: u64,
        new_min_stake_amount: u64,
    }

    public fun get_stake_fee_bps(arg0: &Pool) : u64 {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::get_stake_fee_bps(&load_inner(arg0).fee_config)
    }

    public fun get_unstake_fee_bps(arg0: &Pool) : u64 {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::get_unstake_fee_bps(&load_inner(arg0).fee_config)
    }

    public fun set_stake_fee_bps(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::set_stake_fee_bps(&mut load_inner_mut(arg0).fee_config, arg2);
    }

    public fun set_unstake_fee_bps(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::set_unstake_fee_bps(&mut load_inner_mut(arg0).fee_config, arg2);
    }

    public fun get_accounting_interval(arg0: &Pool) : u64 {
        load_inner(arg0).accounting_interval
    }

    public fun get_fees(arg0: &Pool) : u64 {
        0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&load_inner(arg0).fees)
    }

    public fun get_latest_accounting_timestamp(arg0: &Pool) : u64 {
        load_inner(arg0).latest_accounting_timestamp
    }

    public fun get_max_pool_staked_amount(arg0: &Pool) : u64 {
        load_inner(arg0).max_pool_staked_amount
    }

    public fun get_min_stake_amount(arg0: &Pool) : u64 {
        load_inner(arg0).min_stake_amount
    }

    public fun get_shares_by_staked(arg0: &Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&load_inner(arg0).staked);
        let v1 = 0x2::coin::total_supply<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(arg1));
        if (v1 == 0 || v0 == 0) {
            return arg2
        };
        (((arg2 as u256) * (v1 as u256) / (v0 as u256)) as u64)
    }

    public fun get_staked(arg0: &Pool) : u64 {
        0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&load_inner(arg0).staked)
    }

    public fun get_staked_by_shares(arg0: &Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&load_inner(arg0).staked);
        let v1 = 0x2::coin::total_supply<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(arg1));
        if (v1 == 0 || v0 == 0) {
            return arg2
        };
        (((arg2 as u256) * (v0 as u256) / (v1 as u256)) as u64)
    }

    public fun handle_oracle_report(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg3: u64, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::OracleCap>(arg1, 0x2::tx_context::sender(arg9));
        assert!(arg6 == b"R25Staking", 5);
        let v0 = load_inner_mut(arg0);
        let v1 = 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v0.staked);
        assert!(arg3 <= v1, 1);
        assert!(arg7 - v0.latest_accounting_timestamp == v0.accounting_interval, 0);
        assert!(0x2::clock::timestamp_ms(arg8) > arg7, 9);
        let (v2, v3) = if (arg5) {
            (arg3 + arg4, true)
        } else {
            let v4 = arg4 >= arg3;
            if (v4) {
                (arg4 - arg3, true)
            } else {
                (arg3 - arg4, false)
            }
        };
        let v5 = v2 > 0;
        if (v5) {
            let v6 = v3;
            if (v6) {
                0x2::balance::join<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v0.staked, 0x2::coin::into_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0x2::coin::mint<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg2), v2, arg9)));
            } else {
                0x2::coin::burn<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg2), 0x2::coin::from_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0x2::balance::split<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v0.staked, v2), arg9));
            };
        };
        v0.latest_accounting_timestamp = arg7;
        let v7 = InterestUpdated{
            previous_total_staked : v1,
            new_total_staked      : 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v0.staked),
            today_interest        : arg3,
            today_extra_interest  : arg4,
            interest_to_mint_burn : v2,
            is_positive           : v3,
            accounting_timestamp  : arg7,
        };
        0x2::event::emit<InterestUpdated>(v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolInner{
            is_paused                   : false,
            staked                      : 0x2::balance::zero<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(),
            max_pool_staked_amount      : 1000000000000000,
            min_stake_amount            : 1000000,
            fee_config                  : 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::new(0, 0),
            fees                        : 0x2::balance::zero<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(),
            latest_accounting_timestamp : 0,
            accounting_interval         : 86400000,
        };
        let v1 = Pool{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<PoolInner>(1, v0, arg0),
        };
        0x2::transfer::share_object<Pool>(v1);
    }

    public fun is_paused(arg0: &Pool) : bool {
        load_inner(arg0).is_paused
    }

    fun load_inner(arg0: &Pool) : &PoolInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 4);
        0x2::versioned::load_value<PoolInner>(&arg0.inner)
    }

    fun load_inner_mut(arg0: &mut Pool) : &mut PoolInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 4);
        0x2::versioned::load_value_mut<PoolInner>(&mut arg0.inner)
    }

    public fun pause(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::OracleCap>(arg1, 0x2::tx_context::sender(arg2));
        load_inner_mut(arg0).is_paused = true;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    public fun set_accounting_interval(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = load_inner(arg0).accounting_interval;
        load_inner_mut(arg0).accounting_interval = arg2;
        let v1 = SetAccountingInterval{
            previous_accounting_interval : v0,
            new_accounting_interval      : arg2,
        };
        0x2::event::emit<SetAccountingInterval>(v1);
    }

    public fun set_max_pool_staked_amount(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = load_inner(arg0).max_pool_staked_amount;
        load_inner_mut(arg0).max_pool_staked_amount = arg2;
        let v1 = SetMaxPoolStakedAmount{
            previous_max_pool_staked_amount : v0,
            new_max_pool_staked_amount      : arg2,
        };
        0x2::event::emit<SetMaxPoolStakedAmount>(v1);
    }

    public fun set_min_stake_amount(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 >= 1000000, 8);
        let v0 = load_inner(arg0).min_stake_amount;
        load_inner_mut(arg0).min_stake_amount = arg2;
        let v1 = SetMinStakeAmount{
            previous_min_stake_amount : v0,
            new_min_stake_amount      : arg2,
        };
        0x2::event::emit<SetMinStakeAmount>(v1);
    }

    public fun stake(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg2: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP> {
        assert!(!is_paused(arg0), 6);
        let v0 = load_inner(arg0);
        assert!(0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg1) >= v0.min_stake_amount, 2);
        assert!(0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v0.staked) + 0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg1) <= v0.max_pool_staked_amount, 7);
        let v1 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::calculate_stake_fee(&v0.fee_config, 0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg1));
        let v2 = 0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg1);
        let v3 = v2 - v1;
        let v4 = get_shares_by_staked(arg0, arg2, v3);
        let v5 = load_inner_mut(arg0);
        0x2::balance::join<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v5.fees, 0x2::coin::into_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0x2::coin::split<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut arg1, v1, arg3)));
        0x2::balance::join<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v5.staked, 0x2::coin::into_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg1));
        let v6 = Staked{
            total_staked     : 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v5.staked),
            total_fees       : 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v5.fees),
            original_amount  : v2,
            amount_after_fee : v3,
            shares           : v4,
            fee              : v1,
        };
        0x2::event::emit<Staked>(v6);
        0x2::coin::mint<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(arg2), v4, arg3)
    }

    public fun unpause(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::OracleCap>(arg1, 0x2::tx_context::sender(arg2));
        load_inner_mut(arg0).is_paused = false;
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    public fun unstake(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>, arg2: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD> {
        assert!(!is_paused(arg0), 6);
        let v0 = 0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = get_staked_by_shares(arg0, arg2, v0);
        let v2 = load_inner_mut(arg0);
        assert!(v1 <= 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v2.staked), 3);
        0x2::coin::burn<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusdp::RCUSDP>(arg2), arg1);
        let v3 = 0x2::balance::split<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v2.staked, v1);
        let v4 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::fees::calculate_unstake_fee(&v2.fee_config, v1);
        0x2::balance::join<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v2.fees, 0x2::balance::split<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v3, v4));
        let v5 = Unstaked{
            total_staked     : 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v2.staked),
            total_fees       : 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v2.fees),
            original_amount  : v0,
            amount_after_fee : v1 - v4,
            fee              : v4,
        };
        0x2::event::emit<Unstaked>(v5);
        0x2::coin::from_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(v3, arg3)
    }

    public fun withdraw(arg0: &mut Pool, arg1: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD> {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg2));
        let v0 = load_inner_mut(arg0);
        let v1 = FeesWithdrawn{amount: 0x2::balance::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&v0.fees)};
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::coin::from_balance<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0x2::balance::withdraw_all<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&mut v0.fees), arg2)
    }

    // decompiled from Move bytecode v6
}

