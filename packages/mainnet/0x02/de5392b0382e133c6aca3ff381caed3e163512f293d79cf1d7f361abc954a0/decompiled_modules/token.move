module 0x2de5392b0382e133c6aca3ff381caed3e163512f293d79cf1d7f361abc954a0::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        total_supply: u64,
        circulating_supply: u64,
        distribution: TokenDistribution,
        creator_reward_pool: 0x2::balance::Balance<TOKEN>,
        staking_pool: u64,
        revenue_pool_usd: u64,
        total_staking_rewards: u64,
        burned_tokens: u64,
    }

    struct TokenDistribution has store {
        developer_fund: u64,
        early_contributors: u64,
        reserve_fund: u64,
        seed_investors: u64,
        staking_rewards: u64,
        public_sale_and_liquidity: u64,
    }

    struct RateLimiter has store {
        user_stakes: 0x2::table::Table<address, u64>,
        hourly_counts: 0x2::table::Table<address, u64>,
        last_reset: u64,
    }

    struct CreatorProfile has store, key {
        id: 0x2::object::UID,
        creator_address: address,
        writing_style_hash: 0x1::string::String,
        verification_status: bool,
        total_earnings_epai: u64,
        total_earnings_usd: u64,
        usage_count: u64,
        revenue_share_rate: u64,
        staked_tokens: u64,
        staking_rewards: u64,
    }

    struct CreatorRegistry has key {
        id: 0x2::object::UID,
        creators: 0x2::table::Table<address, CreatorProfile>,
        total_creators: u64,
        total_revenue_distributed: u64,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        staker: address,
        amount: u64,
        stake_timestamp: u64,
        lock_end_timestamp: u64,
        rewards_earned: u64,
    }

    struct StakingSystem has key {
        id: 0x2::object::UID,
        reward_pool: 0x2::balance::Balance<TOKEN>,
        total_staked: u64,
        active_stake_count: u64,
        total_rewards_distributed: u64,
        reward_pool_depleted: bool,
        rate_limiter: RateLimiter,
    }

    struct CreatorRegistered has copy, drop {
        creator: address,
        style_hash: 0x1::string::String,
    }

    struct RevenueDistributed has copy, drop {
        creator: address,
        amount: u64,
        usage_type: 0x1::string::String,
        timestamp: u64,
    }

    struct TokensStaked has copy, drop {
        staker: address,
        amount: u64,
        timestamp: u64,
    }

    struct StakingRewardsClaimed has copy, drop {
        staker: address,
        reward_amount: u64,
        timestamp: u64,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    public entry fun admin_burn_tokens(arg0: &mut TokenTreasury, arg1: 0x2::coin::Coin<TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<TOKEN>(&arg1);
        if (v0 == 0) {
            abort 3
        };
        0x2::balance::destroy_zero<TOKEN>(0x2::coin::into_balance<TOKEN>(arg1));
        arg0.burned_tokens = arg0.burned_tokens + v0;
        arg0.circulating_supply = arg0.circulating_supply - v0;
        let v1 = TokensBurned{
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public entry fun claim_staking_rewards(arg0: &mut StakingSystem, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.staker != v0) {
            abort 9
        };
        if (v1 < arg1.lock_end_timestamp) {
            abort 6
        };
        let v2 = arg1.amount * 5 / 100 / 365 * (v1 - arg1.stake_timestamp) / 86400000;
        if (0x2::balance::value<TOKEN>(&arg0.reward_pool) < v2) {
            abort 0
        };
        arg1.rewards_earned = arg1.rewards_earned + v2;
        arg1.stake_timestamp = v1;
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg0.reward_pool, v2), arg3), v0);
        let v3 = StakingRewardsClaimed{
            staker        : v0,
            reward_amount : v2,
            timestamp     : v1,
        };
        0x2::event::emit<StakingRewardsClaimed>(v3);
    }

    public entry fun distribute_revenue(arg0: &mut CreatorRegistry, arg1: &mut TokenTreasury, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, CreatorProfile>(&arg0.creators, arg2)) {
            abort 2
        };
        if (arg3 == 0) {
            abort 3
        };
        let v0 = 0x2::table::borrow_mut<address, CreatorProfile>(&mut arg0.creators, arg2);
        let v1 = arg3 * v0.revenue_share_rate / 10000;
        if (0x2::balance::value<TOKEN>(&arg1.creator_reward_pool) < v1) {
            abort 0
        };
        v0.total_earnings_epai = v0.total_earnings_epai + v1;
        v0.usage_count = v0.usage_count + 1;
        arg0.total_revenue_distributed = arg0.total_revenue_distributed + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg1.creator_reward_pool, v1), arg5), arg2);
        let v2 = RevenueDistributed{
            creator    : arg2,
            amount     : v1,
            usage_type : arg4,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<RevenueDistributed>(v2);
    }

    public fun get_creator_profile(arg0: &CreatorRegistry, arg1: address) : (0x1::string::String, bool, u64, u64, u64) {
        if (!0x2::table::contains<address, CreatorProfile>(&arg0.creators, arg1)) {
            abort 2
        };
        let v0 = 0x2::table::borrow<address, CreatorProfile>(&arg0.creators, arg1);
        (v0.writing_style_hash, v0.verification_status, v0.total_earnings_epai, v0.usage_count, v0.revenue_share_rate)
    }

    public fun get_staking_stats(arg0: &StakingSystem) : (u64, u64, u64, bool) {
        (arg0.total_staked, 0x2::balance::value<TOKEN>(&arg0.reward_pool), arg0.total_rewards_distributed, arg0.reward_pool_depleted)
    }

    public fun get_treasury_stats(arg0: &TokenTreasury) : (u64, u64, u64, u64) {
        (arg0.total_supply, arg0.circulating_supply, arg0.burned_tokens, 0x2::balance::value<TOKEN>(&arg0.creator_reward_pool))
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"EPAI", b"EchoPen AI Token", b"Official token for EchoPen.ai creator revenue sharing and platform access", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<TOKEN>(&mut v2, 3690000000000000000, arg1);
        let v4 = 0x2::coin::split<TOKEN>(&mut v3, 184500000000000000, arg1);
        let v5 = 0x2::coin::split<TOKEN>(&mut v3, 184500000000000000, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v2);
        let v6 = TokenDistribution{
            developer_fund            : 184500000000000000,
            early_contributors        : 184500000000000000,
            reserve_fund              : 184500000000000000,
            seed_investors            : 184500000000000000,
            staking_rewards           : 369000000000000000,
            public_sale_and_liquidity : 2583000000000000000,
        };
        let v7 = TokenTreasury{
            id                    : 0x2::object::new(arg1),
            total_supply          : 3690000000000000000,
            circulating_supply    : 3690000000000000000,
            distribution          : v6,
            creator_reward_pool   : 0x2::coin::into_balance<TOKEN>(v3),
            staking_pool          : 0,
            revenue_pool_usd      : 0,
            total_staking_rewards : 0,
            burned_tokens         : 0,
        };
        let v8 = CreatorRegistry{
            id                        : 0x2::object::new(arg1),
            creators                  : 0x2::table::new<address, CreatorProfile>(arg1),
            total_creators            : 0,
            total_revenue_distributed : 0,
        };
        let v9 = RateLimiter{
            user_stakes   : 0x2::table::new<address, u64>(arg1),
            hourly_counts : 0x2::table::new<address, u64>(arg1),
            last_reset    : 0,
        };
        let v10 = StakingSystem{
            id                        : 0x2::object::new(arg1),
            reward_pool               : 0x2::coin::into_balance<TOKEN>(0x2::coin::split<TOKEN>(&mut v3, 369000000000000000, arg1)),
            total_staked              : 0,
            active_stake_count        : 0,
            total_rewards_distributed : 0,
            reward_pool_depleted      : false,
            rate_limiter              : v9,
        };
        let v11 = @0xdf99f92529af12c657ce49376bdf6da961f1f2cda0100cf0ee2f371ce8626ba7;
        let v12 = 0x2::coin::split<TOKEN>(&mut v5, 184500000000000000, arg1);
        0x2::coin::join<TOKEN>(&mut v12, 0x2::coin::split<TOKEN>(&mut v3, 184500000000000000, arg1));
        0x2::coin::join<TOKEN>(&mut v12, 0x2::coin::split<TOKEN>(&mut v3, 184500000000000000, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(v12, @0xfa15da5e6d8d93d5e808bea986f670617d4e7df124afd654cb267cafaf29802f);
        let v13 = 0x2::coin::split<TOKEN>(&mut v4, 184500000000000000, arg1);
        0x2::coin::join<TOKEN>(&mut v13, 0x2::coin::split<TOKEN>(&mut v3, 2583000000000000000, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(v13, v11);
        0x2::coin::destroy_zero<TOKEN>(v5);
        0x2::coin::destroy_zero<TOKEN>(v4);
        0x2::transfer::transfer<TokenTreasury>(v7, v11);
        0x2::transfer::transfer<CreatorRegistry>(v8, v11);
        0x2::transfer::transfer<StakingSystem>(v10, v11);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, v11);
    }

    public entry fun register_creator(arg0: &mut CreatorRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, CreatorProfile>(&arg0.creators, v0)) {
            abort 1
        };
        let v1 = CreatorProfile{
            id                  : 0x2::object::new(arg2),
            creator_address     : v0,
            writing_style_hash  : arg1,
            verification_status : true,
            total_earnings_epai : 0,
            total_earnings_usd  : 0,
            usage_count         : 0,
            revenue_share_rate  : 8500,
            staked_tokens       : 0,
            staking_rewards     : 0,
        };
        0x2::table::add<address, CreatorProfile>(&mut arg0.creators, v0, v1);
        arg0.total_creators = arg0.total_creators + 1;
        let v2 = CreatorRegistered{
            creator    : v0,
            style_hash : arg1,
        };
        0x2::event::emit<CreatorRegistered>(v2);
    }

    public entry fun stake_tokens(arg0: &mut StakingSystem, arg1: 0x2::coin::Coin<TOKEN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<TOKEN>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v1 == 0) {
            abort 3
        };
        if (arg0.reward_pool_depleted) {
            abort 4
        };
        let v3 = &mut arg0.rate_limiter;
        update_rate_limiter(v3, v0, v2);
        if (0x2::table::contains<address, u64>(&arg0.rate_limiter.hourly_counts, v0)) {
            if (*0x2::table::borrow<address, u64>(&arg0.rate_limiter.hourly_counts, v0) >= 10) {
                abort 7
            };
        };
        let v4 = StakePosition{
            id                 : 0x2::object::new(arg3),
            staker             : v0,
            amount             : v1,
            stake_timestamp    : v2,
            lock_end_timestamp : v2 + 86400000,
            rewards_earned     : 0,
        };
        arg0.total_staked = arg0.total_staked + v1;
        arg0.active_stake_count = arg0.active_stake_count + 1;
        let v5 = &mut arg0.rate_limiter;
        update_stake_count(v5, v0);
        0x2::balance::destroy_zero<TOKEN>(0x2::coin::into_balance<TOKEN>(arg1));
        0x2::transfer::transfer<StakePosition>(v4, v0);
        let v6 = TokensStaked{
            staker    : v0,
            amount    : v1,
            timestamp : v2,
        };
        0x2::event::emit<TokensStaked>(v6);
    }

    fun update_rate_limiter(arg0: &mut RateLimiter, arg1: address, arg2: u64) {
        if (arg2 / 3600000 > arg0.last_reset / 3600000) {
            arg0.last_reset = arg2;
        };
    }

    fun update_stake_count(arg0: &mut RateLimiter, arg1: address) {
        if (0x2::table::contains<address, u64>(&arg0.hourly_counts, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.hourly_counts, arg1, 0x2::table::remove<address, u64>(&mut arg0.hourly_counts, arg1) + 1);
        } else {
            0x2::table::add<address, u64>(&mut arg0.hourly_counts, arg1, 1);
        };
    }

    // decompiled from Move bytecode v6
}

