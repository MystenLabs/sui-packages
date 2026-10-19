module 0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::staking {
    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Stake has drop, store {
        amount: u64,
        reward_debt: u256,
        has_claimed: bool,
        staked_at_ms: u64,
    }

    struct PoolStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        sink: 0x1::option::Option<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>,
        total_staked: u64,
        acc_reward_per_share: u256,
        stream_remaining: u64,
        stream_last_ms: u64,
        stream_end_ms: u64,
        reward_stream_ms: u64,
        min_stake_lock_ms: u64,
        rewards: 0x2::balance::Balance<T0>,
        referral_reserve: 0x2::balance::Balance<T0>,
        staked_coins: 0x2::balance::Balance<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>,
        stakes: 0x2::table::Table<address, Stake>,
        referrer_of: 0x2::table::Table<address, address>,
        ever_claimed: 0x2::table::Table<address, bool>,
    }

    fun assert_version<T0>(arg0: &StakingPool<T0>) {
        assert!(arg0.version == 1, 13835060125456400385);
    }

    public fun acc_reward_per_share<T0>(arg0: &StakingPool<T0>) : u256 {
        state<T0>(arg0).acc_reward_per_share
    }

    fun accrue<T0>(arg0: &mut PoolStateV1<T0>, arg1: u64) {
        if (arg1 <= arg0.stream_last_ms) {
            return
        };
        let (v0, v1) = vested_since<T0>(arg0, arg1);
        if (v1) {
            let v2 = if (arg0.stream_end_ms > arg0.stream_last_ms) {
                arg0.stream_end_ms - arg0.stream_last_ms
            } else {
                0
            };
            arg0.stream_end_ms = arg1 + v2;
        } else if (v0 > 0) {
            arg0.acc_reward_per_share = arg0.acc_reward_per_share + index_delta(v0, arg0.total_staked);
            arg0.stream_remaining = arg0.stream_remaining - v0;
        };
        arg0.stream_last_ms = arg1;
    }

    fun add_position<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = state_mut<T0>(arg0);
        let v1 = 0x2::table::contains<address, Stake>(&v0.stakes, arg1);
        let v2 = if (v1) {
            0x2::table::borrow<address, Stake>(&v0.stakes, arg1).amount
        } else {
            0
        };
        let v3 = v2 + arg2;
        v0.total_staked = v0.total_staked + arg2;
        if (v1) {
            let v4 = 0x2::table::borrow_mut<address, Stake>(&mut v0.stakes, arg1);
            v4.amount = v3;
            v4.reward_debt = debt_of(v3, v0.acc_reward_per_share);
            v4.staked_at_ms = arg3;
        } else {
            let v5 = Stake{
                amount       : v3,
                reward_debt  : debt_of(v3, v0.acc_reward_per_share),
                has_claimed  : false,
                staked_at_ms : arg3,
            };
            0x2::table::add<address, Stake>(&mut v0.stakes, arg1, v5);
        };
    }

    fun assert_admin_of<T0>(arg0: &StakingPool<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>) {
        assert_version<T0>(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg1);
        let v0 = 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(v0, arg2);
        assert!(state<T0>(arg0).config_id == v0, 13838437163753537561);
    }

    fun assert_usdc<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        assert!(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &v1, 13836467526110412811);
    }

    public fun bind_referrer<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 13836747695417196557);
        assert!(arg1 != @0x0, 13838718024550055963);
        let v1 = state_mut<T0>(arg0);
        if (0x2::table::contains<address, address>(&v1.referrer_of, arg1)) {
            assert!(*0x2::table::borrow<address, address>(&v1.referrer_of, arg1) != v0, 13836747712597065741);
        };
        assert!(!0x2::table::contains<address, address>(&v1.referrer_of, v0), 13837029196163842063);
        assert!(!0x2::table::contains<address, bool>(&v1.ever_claimed, v0), 13837310675435651089);
        0x2::table::add<address, address>(&mut v1.referrer_of, v0, arg1);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_bind_referrer_event(v0, arg1);
    }

    public fun bind_sink<T0>(arg0: &mut StakingPool<T0>, arg1: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink) {
        assert_version<T0>(arg0);
        let v0 = state_mut<T0>(arg0);
        assert!(0x1::option::is_none<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>(&v0.sink), 13835621576466497541);
        0x1::option::fill<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>(&mut v0.sink, arg1);
    }

    public fun claim<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = state_mut<T0>(arg0);
        accrue<T0>(v1, 0x2::clock::timestamp_ms(arg1));
        harvest<T0>(arg0, v0, arg2)
    }

    public fun config_id<T0>(arg0: &StakingPool<T0>) : 0x2::object::ID {
        state<T0>(arg0).config_id
    }

    public fun create<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), arg1);
        assert_usdc<T0>();
        let v0 = create_inner<T0>(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), arg2);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_staking_pool_created_event(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg0), 0x2::object::id<StakingPool<T0>>(&v0));
        v0
    }

    fun create_inner<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        let v0 = 1;
        let v1 = StakingPool<T0>{
            id      : 0x2::object::new(arg1),
            version : v0,
        };
        let v2 = PoolStateV1<T0>{
            id                   : 0x2::object::new(arg1),
            config_id            : arg0,
            sink                 : 0x1::option::none<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>(),
            total_staked         : 0,
            acc_reward_per_share : 0,
            stream_remaining     : 0,
            stream_last_ms       : 0,
            stream_end_ms        : 0,
            reward_stream_ms     : 604800000,
            min_stake_lock_ms    : 86400000,
            rewards              : 0x2::balance::zero<T0>(),
            referral_reserve     : 0x2::balance::zero<T0>(),
            staked_coins         : 0x2::balance::zero<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(),
            stakes               : 0x2::table::new<address, Stake>(arg1),
            referrer_of          : 0x2::table::new<address, address>(arg1),
            ever_claimed         : 0x2::table::new<address, bool>(arg1),
        };
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::extended_field::add<PoolStateV1<T0>>(&mut v1.id, v0, v2);
        v1
    }

    fun debt_of(arg0: u64, arg1: u256) : u256 {
        let v0 = 1000000000000000000000000000;
        ((arg0 as u256) * arg1 + v0 - 1) / v0
    }

    public fun deposit_reward<T0>(arg0: &mut StakingPool<T0>, arg1: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakerFee<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = state_mut<T0>(arg0);
        assert!(0x1::option::is_some<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>(&v0.sink), 13835340183094034435);
        let v1 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::release_staker_fee<T0>(arg1, 0x1::option::borrow<0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::StakingSink>(&v0.sink));
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = (((v2 as u128) * 11 / 111) as u64);
        let v4 = v2 - v3;
        let v5 = state_mut<T0>(arg0);
        if (v3 > 0) {
            0x2::balance::join<T0>(&mut v5.referral_reserve, 0x2::balance::split<T0>(&mut v1, v3));
        };
        0x2::balance::join<T0>(&mut v5.rewards, v1);
        let v6 = 0x2::clock::timestamp_ms(arg2);
        accrue<T0>(v5, v6);
        if (v4 > 0) {
            let v7 = (v5.stream_remaining as u128);
            let v8 = (v4 as u128);
            let v9 = v7 + v8;
            v5.stream_remaining = v5.stream_remaining + v4;
            v5.stream_last_ms = v6;
            v5.stream_end_ms = (((v7 * (0x1::u64::max(v5.stream_end_ms, v6) as u128) + v8 * ((v6 + v5.reward_stream_ms) as u128) + v9 - 1) / v9) as u64);
        };
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_deposit_reward_event(0x2::object::id<StakingPool<T0>>(arg0), v2);
    }

    fun harvest<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = pending<T0>(arg0, arg1);
        if (v0 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v1 = state_mut<T0>(arg0);
        let v2 = 0x2::table::borrow_mut<address, Stake>(&mut v1.stakes, arg1);
        v2.reward_debt = debt_of(v2.amount, v1.acc_reward_per_share);
        let v3 = 0x2::balance::value<T0>(&v1.rewards);
        let v4 = if (v0 > v3) {
            v3
        } else {
            v0
        };
        if (!0x2::table::contains<address, bool>(&v1.ever_claimed, arg1)) {
            0x2::table::add<address, bool>(&mut v1.ever_claimed, arg1, true);
        };
        pay_referral<T0>(v1, arg1, v4, arg2);
        if (v4 > 0) {
            0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_claim_reward_event(arg1, v4);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.rewards, v4), arg2)
    }

    fun index_delta(arg0: u64, arg1: u64) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            (arg0 as u256) * 1000000000000000000000000000 / (arg1 as u256)
        }
    }

    public fun min_stake_lock_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).min_stake_lock_ms
    }

    fun pay_referral<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, address>(&arg0.referrer_of, arg1) || arg2 == 0) {
            return
        };
        let v0 = *0x2::table::borrow<address, address>(&arg0.referrer_of, arg1);
        let v1 = if (0x2::table::contains<address, address>(&arg0.referrer_of, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrer_of, v0))
        } else {
            0x1::option::none<address>()
        };
        let v2 = v1;
        let v3 = 0x2::balance::value<T0>(&arg0.referral_reserve);
        let v4 = (((arg2 as u128) * 10 / 100) as u64);
        let v5 = if (v4 < v3) {
            v4
        } else {
            v3
        };
        let v6 = v3 - v5;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.referral_reserve, v5), arg3), v0);
        };
        if (0x1::option::is_none<address>(&v2)) {
            return
        };
        let v7 = 0x1::option::destroy_some<address>(v2);
        if (v7 == arg1) {
            return
        };
        let v8 = (((arg2 as u128) * 1 / 100) as u64);
        let v9 = if (v8 < v6) {
            v8
        } else {
            v6
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.referral_reserve, v9), arg3), v7);
        };
    }

    public fun pending<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = state<T0>(arg0);
        if (!0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, Stake>(&v0.stakes, arg1);
        pending_of(v1.amount, v0.acc_reward_per_share, v1.reward_debt)
    }

    public fun pending_now<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = state<T0>(arg0);
        if (!0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            return 0
        };
        let (v1, _) = vested_since<T0>(v0, 0x2::clock::timestamp_ms(arg2));
        let v3 = 0x2::table::borrow<address, Stake>(&v0.stakes, arg1);
        pending_of(v3.amount, v0.acc_reward_per_share + index_delta(v1, v0.total_staked), v3.reward_debt)
    }

    fun pending_of(arg0: u64, arg1: u256, arg2: u256) : u64 {
        let v0 = (arg0 as u256) * arg1 / 1000000000000000000000000000;
        if (v0 <= arg2) {
            0
        } else {
            ((v0 - arg2) as u64)
        }
    }

    fun remove_position<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64) {
        let v0 = state_mut<T0>(arg0);
        let v1 = 0x2::table::borrow_mut<address, Stake>(&mut v0.stakes, arg1);
        v1.amount = v1.amount - arg2;
        v1.reward_debt = debt_of(v1.amount, v0.acc_reward_per_share);
        v0.total_staked = v0.total_staked - arg2;
        if (v1.amount == 0) {
            let Stake {
                amount       : _,
                reward_debt  : _,
                has_claimed  : _,
                staked_at_ms : _,
            } = 0x2::table::remove<address, Stake>(&mut v0.stakes, arg1);
        };
    }

    public fun reward_stream_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).reward_stream_ms
    }

    public fun set_min_stake_lock_ms<T0>(arg0: &mut StakingPool<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg3: u64) {
        assert_admin_of<T0>(arg0, arg1, arg2);
        assert!(arg3 <= 2592000000, 13837874162260246549);
        let v0 = state_mut<T0>(arg0);
        v0.min_stake_lock_ms = arg3;
        let v1 = 0x2::object::id<StakingPool<T0>>(arg0);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_min_stake_lock_updated_event(v1, arg3);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_staking_admin_action_event(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg1), v1, 78);
    }

    public fun set_reward_stream_ms<T0>(arg0: &mut StakingPool<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg3: u64) {
        assert_admin_of<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 3600000 && arg3 <= 2592000000, 13837592609973993491);
        let v0 = state_mut<T0>(arg0);
        v0.reward_stream_ms = arg3;
        let v1 = 0x2::object::id<StakingPool<T0>>(arg0);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_reward_stream_updated_event(v1, arg3);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_staking_admin_action_event(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config>(arg1), v1, 77);
    }

    public fun share<T0>(arg0: StakingPool<T0>) {
        0x2::transfer::share_object<StakingPool<T0>>(arg0);
    }

    public fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(&arg1);
        assert!(v0 > 0, 13835903369270919175);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = state_mut<T0>(arg0);
        accrue<T0>(v3, v2);
        let v4 = harvest<T0>(arg0, v1, arg3);
        let v5 = state_mut<T0>(arg0);
        0x2::balance::join<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(&mut v5.staked_coins, 0x2::coin::into_balance<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(arg1));
        add_position<T0>(arg0, v1, v0, v2);
        0x2::coin::join<T0>(&mut v4, harvest<T0>(arg0, v1, arg3));
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_stake_event(v1, v0);
        v4
    }

    public fun staked<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = &state<T0>(arg0).stakes;
        if (!0x2::table::contains<address, Stake>(v0, arg1)) {
            0
        } else {
            0x2::table::borrow<address, Stake>(v0, arg1).amount
        }
    }

    fun state<T0>(arg0: &StakingPool<T0>) : &PoolStateV1<T0> {
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::extended_field::borrow<PoolStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut StakingPool<T0>) : &mut PoolStateV1<T0> {
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::extended_field::borrow_mut<PoolStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun stream_end_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).stream_end_ms
    }

    public fun stream_remaining<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).stream_remaining
    }

    public fun total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).total_staked
    }

    public fun unlock_at_ms<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = state<T0>(arg0);
        if (!0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            0
        } else {
            0x2::table::borrow<address, Stake>(&v0.stakes, arg1).staked_at_ms + v0.min_stake_lock_ms
        }
    }

    public fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>, 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        assert!(arg1 > 0, 13835903459465232391);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(staked<T0>(arg0, v0) >= arg1, 13836184943032008713);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= unlock_at_ms<T0>(arg0, v0), 13838155276459835415);
        let v2 = state_mut<T0>(arg0);
        accrue<T0>(v2, v1);
        let v3 = harvest<T0>(arg0, v0, arg3);
        remove_position<T0>(arg0, v0, arg1);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_unstake_event(v0, arg1);
        (0x2::coin::from_balance<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(0x2::balance::split<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT>(&mut state_mut<T0>(arg0).staked_coins, arg1), arg3), v3)
    }

    fun vested_since<T0>(arg0: &PoolStateV1<T0>, arg1: u64) : (u64, bool) {
        if (arg0.stream_remaining == 0 || arg1 <= arg0.stream_last_ms) {
            return (0, false)
        };
        if (arg0.total_staked == 0) {
            return (0, true)
        };
        if (arg1 >= arg0.stream_end_ms) {
            return (arg0.stream_remaining, false)
        };
        ((((arg0.stream_remaining as u128) * ((arg1 - arg0.stream_last_ms) as u128) / ((arg0.stream_end_ms - arg0.stream_last_ms) as u128)) as u64), false)
    }

    // decompiled from Move bytecode v7
}

