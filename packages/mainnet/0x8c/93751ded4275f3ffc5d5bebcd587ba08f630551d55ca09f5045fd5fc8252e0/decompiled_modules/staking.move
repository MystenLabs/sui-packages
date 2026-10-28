module 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::staking {
    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct ParchKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ParchRewards has store {
        acc: u256,
        balance: 0x2::balance::Balance<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>,
        remaining: u64,
        last_ms: u64,
        end_ms: u64,
        debts: 0x2::table::Table<address, u256>,
    }

    struct StreamBaseKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ParchBaseKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StreamBase has copy, drop, store {
        base: u64,
        start_ms: u64,
    }

    struct CarryKey has copy, drop, store {
        pos0: u8,
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
        sink: 0x1::option::Option<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>,
        total_staked: u64,
        acc_reward_per_share: u256,
        stream_remaining: u64,
        stream_last_ms: u64,
        stream_end_ms: u64,
        reward_stream_ms: u64,
        min_stake_lock_ms: u64,
        rewards: 0x2::balance::Balance<T0>,
        referral_reserve: 0x2::balance::Balance<T0>,
        referral_owed: 0x2::table::Table<address, u64>,
        referral_owed_total: u64,
        staked_coins: 0x2::balance::Balance<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>,
        stakes: 0x2::table::Table<address, Stake>,
        referrer_of: 0x2::table::Table<address, address>,
        ever_claimed: 0x2::table::Table<address, bool>,
    }

    fun assert_unpaused<T0>(arg0: &StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: u8) {
        assert!(state<T0>(arg0).config_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 13838437550300594201);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg1, arg2);
    }

    fun assert_version<T0>(arg0: &StakingPool<T0>) {
        assert!(arg0.version == 1, 13835061654464757761);
    }

    public fun acc_reward_per_share<T0>(arg0: &StakingPool<T0>) : u256 {
        state<T0>(arg0).acc_reward_per_share
    }

    fun accrue<T0>(arg0: &mut PoolStateV1<T0>, arg1: u64) {
        accrue_parch<T0>(arg0, arg1);
        let v0 = arg0.stream_remaining;
        let v1 = arg0.stream_last_ms;
        if (arg1 <= v1) {
            return
        };
        let v2 = StreamBaseKey{dummy_field: false};
        let v3 = base_of<StreamBaseKey>(&arg0.id, v2, v0, v1);
        let (v4, v5, v6) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::accrue_step(v3.base, v3.start_ms, arg0.stream_end_ms, v0, v1, arg1, arg0.total_staked > 0);
        let v7 = rem_of(&arg0.id, 2);
        let (v8, v9) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::index_step(v6, arg0.total_staked, v7);
        if (v9 != v7) {
            let v10 = &mut arg0.id;
            set_rem(v10, 2, v9);
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + v8;
        arg0.stream_remaining = v0 - v6;
        arg0.stream_end_ms = v5;
        arg0.stream_last_ms = arg1;
        let v11 = &mut arg0.id;
        let v12 = StreamBaseKey{dummy_field: false};
        keep_base<StreamBaseKey>(v11, v12, v3, v4, v0);
    }

    fun accrue_parch<T0>(arg0: &mut PoolStateV1<T0>, arg1: u64) {
        let v0 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ParchKey>(&arg0.id, v0)) {
            return
        };
        let v1 = arg0.total_staked;
        let v2 = ParchKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&arg0.id, v2);
        let v4 = v3.remaining;
        let v5 = v3.last_ms;
        let v6 = v3.end_ms;
        if (arg1 <= v5) {
            return
        };
        let v7 = ParchBaseKey{dummy_field: false};
        let v8 = base_of<ParchBaseKey>(&arg0.id, v7, v4, v5);
        let (v9, v10, v11) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::accrue_step(v8.base, v8.start_ms, v6, v4, v5, arg1, v1 > 0);
        let v12 = rem_of(&arg0.id, 3);
        let (v13, v14) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::index_step(v11, v1, v12);
        if (v14 != v12) {
            let v15 = &mut arg0.id;
            set_rem(v15, 3, v14);
        };
        let v16 = ParchKey{dummy_field: false};
        let v17 = 0x2::dynamic_field::borrow_mut<ParchKey, ParchRewards>(&mut arg0.id, v16);
        v17.acc = v17.acc + v13;
        v17.remaining = v4 - v11;
        v17.end_ms = v10;
        v17.last_ms = arg1;
        let v18 = &mut arg0.id;
        let v19 = ParchBaseKey{dummy_field: false};
        keep_base<ParchBaseKey>(v18, v19, v8, v9, v4);
    }

    fun accrue_referral<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, address>(&arg0.referrer_of, arg1) || arg2 == 0) {
            return
        };
        let v0 = *0x2::table::borrow<address, address>(&arg0.referrer_of, arg1);
        let (v1, v2) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::referral_bonuses(arg2);
        owe_referrer<T0>(arg0, arg1, v0, 1, arg2, v1);
        if (!0x2::table::contains<address, address>(&arg0.referrer_of, v0)) {
            return
        };
        let v3 = *0x2::table::borrow<address, address>(&arg0.referrer_of, v0);
        if (v3 == arg1) {
            return
        };
        owe_referrer<T0>(arg0, arg1, v3, 2, arg2, v2);
    }

    fun add_position<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = state_mut<T0>(arg0);
        let v1 = 0x2::table::contains<address, Stake>(&v0.stakes, arg1);
        let v2 = if (v1) {
            usdc_debt<T0>(v0, arg1)
        } else {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::zero_debt()
        };
        let v3 = if (v1) {
            0x2::table::borrow<address, Stake>(&v0.stakes, arg1).amount
        } else {
            0
        };
        let v4 = v3 + arg2;
        v0.total_staked = v0.total_staked + arg2;
        if (v1) {
            let v5 = 0x2::table::borrow_mut<address, Stake>(&mut v0.stakes, arg1);
            v5.amount = v4;
            v5.staked_at_ms = arg3;
        } else {
            let v6 = Stake{
                amount       : v4,
                reward_debt  : 0,
                has_claimed  : false,
                staked_at_ms : arg3,
            };
            0x2::table::add<address, Stake>(&mut v0.stakes, arg1, v6);
        };
        let v7 = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_add(v2, arg2, v0.acc_reward_per_share);
        set_usdc_debt<T0>(v0, arg1, v7, arg4);
        move_parch_debt<T0>(v0, arg1, arg2, true, v4, arg4);
    }

    fun assert_admin_of<T0>(arg0: &StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        let v0 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(v0, arg2);
        assert!(state<T0>(arg0).config_id == v0, 13838437588955299865);
    }

    fun assert_usdc<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        assert!(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &v1, 13836469055118770187);
    }

    fun base_of<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0, arg2: u64, arg3: u64) : StreamBase {
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            *0x2::dynamic_field::borrow<T0, StreamBase>(arg0, arg1)
        } else {
            StreamBase{base: arg2, start_ms: arg3}
        }
    }

    public fun bind_referrer<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_referrals());
        bind_referrer_inner<T0>(arg0, arg2, arg3);
    }

    fun bind_referrer_inner<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 13836747957410201613);
        assert!(arg1 != @0x0, 13838718286543061019);
        let v1 = state_mut<T0>(arg0);
        if (0x2::table::contains<address, address>(&v1.referrer_of, arg1)) {
            assert!(*0x2::table::borrow<address, address>(&v1.referrer_of, arg1) != v0, 13836747974590070797);
        };
        assert!(!0x2::table::contains<address, address>(&v1.referrer_of, v0), 13837029458156847119);
        assert!(!0x2::table::contains<address, bool>(&v1.ever_claimed, v0), 13837310937428656145);
        0x2::table::add<address, address>(&mut v1.referrer_of, v0, arg1);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_bind_referrer_event(v0, arg1);
    }

    public fun bind_sink<T0>(arg0: &mut StakingPool<T0>, arg1: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink) {
        assert_version<T0>(arg0);
        let v0 = state_mut<T0>(arg0);
        assert!(0x1::option::is_none<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v0.sink), 13835621851344404485);
        0x1::option::fill<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&mut v0.sink, arg1);
    }

    public fun claim<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_staking_claims());
        claim_inner<T0>(arg0, arg2, arg3)
    }

    fun claim_inner<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = state_mut<T0>(arg0);
        accrue<T0>(v1, 0x2::clock::timestamp_ms(arg1));
        harvest<T0>(arg0, v0, arg2)
    }

    public fun claim_referral_bonus<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_unpaused<T0>(arg0, arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_staking_claims());
        if (referral_owed<T0>(arg0, 0x2::tx_context::sender(arg3)) > referral_reserve<T0>(arg0)) {
            fund_referral_bonuses<T0>(arg0, arg1, arg2);
        };
        pay_referral_bonus<T0>(arg0, arg3)
    }

    public fun config_id<T0>(arg0: &StakingPool<T0>) : 0x2::object::ID {
        state<T0>(arg0).config_id
    }

    public fun create<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg0), arg1);
        assert_usdc<T0>();
        let v0 = create_inner<T0>(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg0), arg2);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_staking_pool_created_event(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg0), 0x2::object::id<StakingPool<T0>>(&v0));
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
            sink                 : 0x1::option::none<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(),
            total_staked         : 0,
            acc_reward_per_share : 0,
            stream_remaining     : 0,
            stream_last_ms       : 0,
            stream_end_ms        : 0,
            reward_stream_ms     : 604800000,
            min_stake_lock_ms    : 0,
            rewards              : 0x2::balance::zero<T0>(),
            referral_reserve     : 0x2::balance::zero<T0>(),
            referral_owed        : 0x2::table::new<address, u64>(arg1),
            referral_owed_total  : 0,
            staked_coins         : 0x2::balance::zero<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(),
            stakes               : 0x2::table::new<address, Stake>(arg1),
            referrer_of          : 0x2::table::new<address, address>(arg1),
            ever_claimed         : 0x2::table::new<address, bool>(arg1),
        };
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::extended_field::add<PoolStateV1<T0>>(&mut v1.id, v0, v2);
        v1
    }

    public fun deposit_reward<T0>(arg0: &mut StakingPool<T0>, arg1: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakerFee<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = state_mut<T0>(arg0);
        assert!(0x1::option::is_some<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v0.sink), 13835340457971941379);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::release_staker_fee<T0>(arg1, 0x1::option::borrow<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v0.sink));
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = state_mut<T0>(arg0);
        0x2::balance::join<T0>(&mut v3.rewards, v1);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        accrue<T0>(v3, v4);
        if (v2 > 0) {
            v3.stream_end_ms = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::merge_end(v3.stream_remaining, 0x1::u64::max(v3.stream_end_ms, v4), v2, v4 + v3.reward_stream_ms);
            v3.stream_remaining = v3.stream_remaining + v2;
            v3.stream_last_ms = v4;
            let v5 = &mut v3.id;
            let v6 = StreamBaseKey{dummy_field: false};
            let v7 = StreamBase{
                base     : v3.stream_remaining,
                start_ms : v4,
            };
            set_base<StreamBaseKey>(v5, v6, v7);
        };
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_deposit_reward_event(0x2::object::id<StakingPool<T0>>(arg0), v2);
    }

    fun drop_debt(arg0: &mut 0x2::object::UID, arg1: u8, arg2: address) {
        let v0 = CarryKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<CarryKey>(arg0, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<CarryKey, 0x2::table::Table<address, u256>>(arg0, v0);
        if (0x2::table::contains<address, u256>(v1, arg2)) {
            0x2::table::remove<address, u256>(v1, arg2);
        };
    }

    public fun fund_referral_bonuses<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        assert_version<T0>(arg0);
        assert!(state<T0>(arg0).config_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 13838438679876993049);
        let v0 = 0x2::object::id<StakingPool<T0>>(arg0);
        let v1 = state_mut<T0>(arg0);
        assert!(0x1::option::is_some<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v1.sink), 13835342468016635907);
        let v2 = v1.referral_owed_total - 0x2::balance::value<T0>(&v1.referral_reserve);
        if (v2 == 0) {
            return 0
        };
        let v3 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::take_referral_funding<T0>(arg1, arg2, 0x1::option::borrow<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v1.sink), v2);
        let v4 = 0x2::balance::value<T0>(&v3);
        0x2::balance::join<T0>(&mut v1.referral_reserve, v3);
        if (v4 > 0) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_referral_bonus_funded_event(v0, v4, v1.referral_owed_total, 0x2::balance::value<T0>(&v1.referral_reserve));
        };
        v4
    }

    fun harvest<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        harvest_parch<T0>(arg0, arg1, arg2);
        let v0 = 0x2::object::id<StakingPool<T0>>(arg0);
        let v1 = pending<T0>(arg0, arg1);
        if (v1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v2 = state_mut<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v2.rewards);
        let v4 = if (v1 > v3) {
            v3
        } else {
            v1
        };
        let v5 = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_harvest(usdc_debt<T0>(v2, arg1), v4);
        set_usdc_debt<T0>(v2, arg1, v5, arg2);
        if (!0x2::table::contains<address, bool>(&v2.ever_claimed, arg1)) {
            0x2::table::add<address, bool>(&mut v2.ever_claimed, arg1, true);
        };
        accrue_referral<T0>(v2, arg1, v4);
        if (v4 > 0) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_claim_reward_event(arg1, v4, v0);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.rewards, v4), arg2)
    }

    fun harvest_parch<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StakingPool<T0>>(arg0);
        let v1 = parch_pending<T0>(arg0, arg1);
        if (v1 == 0) {
            return
        };
        let v2 = state_mut<T0>(arg0);
        let v3 = ParchKey{dummy_field: false};
        let v4 = 0x1::u64::min(v1, 0x2::balance::value<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&v2.id, v3).balance));
        if (v4 == 0) {
            return
        };
        let v5 = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_harvest(parch_debt<T0>(v2, arg1), v4);
        set_parch_debt<T0>(v2, arg1, v5, arg2);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_parch_reward_claimed_event(arg1, v4, v0);
        let v6 = ParchKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>>(0x2::coin::from_balance<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(0x2::balance::split<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&mut 0x2::dynamic_field::borrow_mut<ParchKey, ParchRewards>(&mut v2.id, v6).balance, v4), arg2), arg1);
    }

    fun keep_base<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: StreamBase, arg3: u64, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        if (arg3 != arg2.start_ms || !0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            let v0 = StreamBase{
                base     : arg2.base,
                start_ms : arg3,
            };
            set_base<T0>(arg0, arg1, v0);
        };
    }

    public fun min_stake_lock_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).min_stake_lock_ms
    }

    fun move_parch_debt<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: u64, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ParchKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ParchKey{dummy_field: false};
        if (arg4 == 0) {
            let v2 = &mut arg0.id;
            drop_debt(v2, 1, arg1);
            let v3 = ParchKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<ParchKey, ParchRewards>(&mut arg0.id, v3);
            if (0x2::table::contains<address, u256>(&v4.debts, arg1)) {
                0x2::table::remove<address, u256>(&mut v4.debts, arg1);
            };
            return
        };
        let v5 = if (arg3) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_add(parch_debt<T0>(arg0, arg1), arg2, 0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&arg0.id, v1).acc)
        } else {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_remove(parch_debt<T0>(arg0, arg1), arg2, 0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&arg0.id, v1).acc)
        };
        set_parch_debt<T0>(arg0, arg1, v5, arg5);
    }

    fun owe_referrer<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: address, arg3: u8, arg4: u64, arg5: u64) {
        if (arg5 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.referral_owed, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_owed, arg2);
            *v0 = *v0 + arg5;
        } else {
            0x2::table::add<address, u64>(&mut arg0.referral_owed, arg2, arg5);
        };
        arg0.referral_owed_total = arg0.referral_owed_total + arg5;
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_referral_bonus_accrued_event(arg1, arg2, arg3, arg4, arg5);
    }

    fun parch_debt<T0>(arg0: &PoolStateV1<T0>, arg1: address) : u256 {
        let v0 = CarryKey{pos0: 1};
        if (0x2::dynamic_field::exists<CarryKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<CarryKey, 0x2::table::Table<address, u256>>(&arg0.id, v0);
            if (0x2::table::contains<address, u256>(v1, arg1)) {
                return *0x2::table::borrow<address, u256>(v1, arg1)
            };
        };
        let v2 = ParchKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&arg0.id, v2);
        if (0x2::table::contains<address, u256>(&v3.debts, arg1)) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::scaled_from_whole(*0x2::table::borrow<address, u256>(&v3.debts, arg1))
        } else {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::zero_debt()
        }
    }

    public fun parch_drip_end_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        let v0 = state<T0>(arg0);
        let v1 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ParchKey>(&v0.id, v1)) {
            0
        } else {
            let v3 = ParchKey{dummy_field: false};
            0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&v0.id, v3).end_ms
        }
    }

    public fun parch_drip_remaining<T0>(arg0: &StakingPool<T0>) : u64 {
        let v0 = state<T0>(arg0);
        let v1 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ParchKey>(&v0.id, v1)) {
            0
        } else {
            let v3 = ParchKey{dummy_field: false};
            0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&v0.id, v3).remaining
        }
    }

    public fun parch_pending<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = state<T0>(arg0);
        let v1 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ParchKey>(&v0.id, v1)) {
            return 0
        };
        let v2 = ParchKey{dummy_field: false};
        let v3 = if (0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            0x2::table::borrow<address, Stake>(&v0.stakes, arg1).amount
        } else {
            0
        };
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::pending_of(v3, 0x2::dynamic_field::borrow<ParchKey, ParchRewards>(&v0.id, v2).acc, parch_debt<T0>(v0, arg1))
    }

    fun pay_referral_bonus<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = state_mut<T0>(arg0);
        if (!0x2::table::contains<address, u64>(&v1.referral_owed, v0)) {
            return 0x2::coin::zero<T0>(arg1)
        };
        let v2 = *0x2::table::borrow<address, u64>(&v1.referral_owed, v0);
        let v3 = 0x1::u64::min(v2, 0x2::balance::value<T0>(&v1.referral_reserve));
        let v4 = v2 - v3;
        if (v4 == 0) {
            0x2::table::remove<address, u64>(&mut v1.referral_owed, v0);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut v1.referral_owed, v0) = v4;
        };
        v1.referral_owed_total = v1.referral_owed_total - v3;
        if (v3 > 0) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_referral_bonus_claimed_event(v0, v3, v4);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.referral_reserve, v3), arg1)
    }

    public fun pending<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = state<T0>(arg0);
        if (!0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            return 0
        };
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::pending_of(0x2::table::borrow<address, Stake>(&v0.stakes, arg1).amount, v0.acc_reward_per_share, usdc_debt<T0>(v0, arg1))
    }

    public fun pending_now<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = state<T0>(arg0);
        if (!0x2::table::contains<address, Stake>(&v0.stakes, arg1)) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = StreamBaseKey{dummy_field: false};
        let v3 = base_of<StreamBaseKey>(&v0.id, v2, v0.stream_remaining, v0.stream_last_ms);
        let (_, _, v6) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::accrue_step(v3.base, v3.start_ms, v0.stream_end_ms, v0.stream_remaining, v0.stream_last_ms, v1, v0.total_staked > 0);
        let v7 = if (v1 <= v0.stream_last_ms) {
            v0.acc_reward_per_share
        } else {
            let (v8, _) = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::index_step(v6, v0.total_staked, rem_of(&v0.id, 2));
            v0.acc_reward_per_share + v8
        };
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::pending_of(0x2::table::borrow<address, Stake>(&v0.stakes, arg1).amount, v7, usdc_debt<T0>(v0, arg1))
    }

    fun put_debt(arg0: &mut 0x2::object::UID, arg1: u8, arg2: address, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CarryKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<CarryKey>(arg0, v0)) {
            0x2::dynamic_field::add<CarryKey, 0x2::table::Table<address, u256>>(arg0, v0, 0x2::table::new<address, u256>(arg4));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<CarryKey, 0x2::table::Table<address, u256>>(arg0, v0);
        if (0x2::table::contains<address, u256>(v1, arg2)) {
            *0x2::table::borrow_mut<address, u256>(v1, arg2) = arg3;
        } else {
            0x2::table::add<address, u256>(v1, arg2, arg3);
        };
    }

    public fun referral_owed<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = &state<T0>(arg0).referral_owed;
        if (0x2::table::contains<address, u64>(v0, arg1)) {
            *0x2::table::borrow<address, u64>(v0, arg1)
        } else {
            0
        }
    }

    public fun referral_owed_total<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).referral_owed_total
    }

    public fun referral_reserve<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&state<T0>(arg0).referral_reserve)
    }

    fun rem_of(arg0: &0x2::object::UID, arg1: u8) : u256 {
        let v0 = CarryKey{pos0: arg1};
        if (0x2::dynamic_field::exists<CarryKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow<CarryKey, u256>(arg0, v0)
        } else {
            0
        }
    }

    fun remove_position<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = state_mut<T0>(arg0);
        let v1 = 0x2::table::borrow_mut<address, Stake>(&mut v0.stakes, arg1);
        v1.amount = v1.amount - arg2;
        let v2 = v1.amount;
        v0.total_staked = v0.total_staked - arg2;
        if (v2 == 0) {
            let Stake {
                amount       : _,
                reward_debt  : _,
                has_claimed  : _,
                staked_at_ms : _,
            } = 0x2::table::remove<address, Stake>(&mut v0.stakes, arg1);
            let v7 = &mut v0.id;
            drop_debt(v7, 0, arg1);
        } else {
            let v8 = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::debt_after_remove(usdc_debt<T0>(v0, arg1), arg2, v0.acc_reward_per_share);
            set_usdc_debt<T0>(v0, arg1, v8, arg3);
        };
        move_parch_debt<T0>(v0, arg1, arg2, false, v2, arg3);
    }

    public fun reward_stream_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).reward_stream_ms
    }

    fun set_base<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: StreamBase) {
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            *0x2::dynamic_field::borrow_mut<T0, StreamBase>(arg0, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<T0, StreamBase>(arg0, arg1, arg2);
        };
    }

    public fun set_min_stake_lock_ms<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        assert_admin_of<T0>(arg0, arg1, arg2);
        assert!(arg3 <= 2592000000, 13837874557397237781);
        let v0 = state_mut<T0>(arg0);
        v0.min_stake_lock_ms = arg3;
        let v1 = 0x2::object::id<StakingPool<T0>>(arg0);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_min_stake_lock_updated_event(v1, arg3);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_staking_admin_action_event(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), v1, 78);
    }

    fun set_parch_debt<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.id;
        put_debt(v0, 1, arg1, arg2, arg3);
        let v1 = ParchKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ParchKey, ParchRewards>(&mut arg0.id, v1);
        if (0x2::table::contains<address, u256>(&v2.debts, arg1)) {
            0x2::table::remove<address, u256>(&mut v2.debts, arg1);
        };
        0x2::table::add<address, u256>(&mut v2.debts, arg1, 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::whole_debt(arg2));
    }

    fun set_rem(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u256) {
        let v0 = CarryKey{pos0: arg1};
        if (0x2::dynamic_field::exists<CarryKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow_mut<CarryKey, u256>(arg0, v0) = arg2;
        } else {
            0x2::dynamic_field::add<CarryKey, u256>(arg0, v0, arg2);
        };
    }

    public fun set_reward_stream_ms<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        assert_admin_of<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 3600000 && arg3 <= 2592000000, 13837593005110984723);
        let v0 = state_mut<T0>(arg0);
        v0.reward_stream_ms = arg3;
        let v1 = 0x2::object::id<StakingPool<T0>>(arg0);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_reward_stream_updated_event(v1, arg3);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_staking_admin_action_event(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), v1, 77);
    }

    fun set_usdc_debt<T0>(arg0: &mut PoolStateV1<T0>, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.id;
        put_debt(v0, 0, arg1, arg2, arg3);
        0x2::table::borrow_mut<address, Stake>(&mut arg0.stakes, arg1).reward_debt = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::whole_debt(arg2);
    }

    public fun share<T0>(arg0: StakingPool<T0>) {
        0x2::transfer::share_object<StakingPool<T0>>(arg0);
    }

    public fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: 0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_stake());
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_staking_claims());
        stake_inner<T0>(arg0, arg2, arg3, arg4)
    }

    fun stake_inner<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&arg1);
        assert!(v0 > 0, 13835903665623662599);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = state_mut<T0>(arg0);
        accrue<T0>(v3, v2);
        let v4 = harvest<T0>(arg0, v1, arg3);
        let v5 = state_mut<T0>(arg0);
        0x2::balance::join<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&mut v5.staked_coins, 0x2::coin::into_balance<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(arg1));
        add_position<T0>(arg0, v1, v0, v2, arg3);
        let v6 = harvest<T0>(arg0, v1, arg3);
        0x2::coin::join<T0>(&mut v4, v6);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_stake_event(v1, v0, 0x2::object::id<StakingPool<T0>>(arg0));
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
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::extended_field::borrow<PoolStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut StakingPool<T0>) : &mut PoolStateV1<T0> {
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::extended_field::borrow_mut<PoolStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun stream_end_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).stream_end_ms
    }

    public fun stream_remaining<T0>(arg0: &StakingPool<T0>) : u64 {
        state<T0>(arg0).stream_remaining
    }

    public fun sweep_forfeits<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::object::id<StakingPool<T0>>(arg0);
        let v2 = state_mut<T0>(arg0);
        assert!(0x1::option::is_some<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v2.sink), 13835341454404354051);
        let v3 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::take_forfeits<T0, 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(arg1, 0x1::option::borrow<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(&v2.sink));
        let v4 = 0x2::balance::value<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&v3);
        let v5 = ParchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ParchKey>(&v2.id, v5)) {
            let v6 = ParchKey{dummy_field: false};
            let v7 = ParchRewards{
                acc       : 0,
                balance   : 0x2::balance::zero<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(),
                remaining : 0,
                last_ms   : v0,
                end_ms    : v0,
                debts     : 0x2::table::new<address, u256>(arg3),
            };
            0x2::dynamic_field::add<ParchKey, ParchRewards>(&mut v2.id, v6, v7);
        };
        accrue_parch<T0>(v2, v0);
        let v8 = ParchKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<ParchKey, ParchRewards>(&mut v2.id, v8);
        0x2::balance::join<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&mut v9.balance, v3);
        if (v4 > 0) {
            v9.end_ms = 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::merge_end(v9.remaining, 0x1::u64::max(v9.end_ms, v0), v4, v0 + 604800000);
            v9.remaining = v9.remaining + v4;
            v9.last_ms = v0;
            let v10 = v9.remaining;
            let v11 = v9.end_ms;
            let v12 = &mut v2.id;
            let v13 = ParchBaseKey{dummy_field: false};
            let v14 = StreamBase{
                base     : v10,
                start_ms : v0,
            };
            set_base<ParchBaseKey>(v12, v13, v14);
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_forfeits_swept_event(v1, v4, v11);
        };
        v4
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

    public fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>, 0x2::coin::Coin<T0>) {
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_unstake());
        assert_unpaused<T0>(arg0, arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_staking_claims());
        unstake_inner<T0>(arg0, arg2, arg3, arg4)
    }

    fun unstake_inner<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>, 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        assert!(arg1 > 0, 13835903794472681479);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(staked<T0>(arg0, v0) >= arg1, 13836185278039457801);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = state<T0>(arg0);
        assert!(0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::unlocked(v1, 0x2::table::borrow<address, Stake>(&v2.stakes, v0).staked_at_ms, v2.min_stake_lock_ms), 13838155620057219095);
        let v3 = state_mut<T0>(arg0);
        accrue<T0>(v3, v1);
        let v4 = harvest<T0>(arg0, v0, arg3);
        remove_position<T0>(arg0, v0, arg1, arg3);
        let v5 = state_mut<T0>(arg0);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_unstake_event(v0, arg1, 0x2::object::id<StakingPool<T0>>(arg0));
        (0x2::coin::from_balance<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(0x2::balance::split<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT>(&mut v5.staked_coins, arg1), arg3), v4)
    }

    fun usdc_debt<T0>(arg0: &PoolStateV1<T0>, arg1: address) : u256 {
        let v0 = CarryKey{pos0: 0};
        if (0x2::dynamic_field::exists<CarryKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<CarryKey, 0x2::table::Table<address, u256>>(&arg0.id, v0);
            if (0x2::table::contains<address, u256>(v1, arg1)) {
                return *0x2::table::borrow<address, u256>(v1, arg1)
            };
        };
        if (0x2::table::contains<address, Stake>(&arg0.stakes, arg1)) {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::scaled_from_whole(0x2::table::borrow<address, Stake>(&arg0.stakes, arg1).reward_debt)
        } else {
            0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math::zero_debt()
        }
    }

    // decompiled from Move bytecode v7
}

