module 0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::staking {
    struct StakingReceipt has store, key {
        id: 0x2::object::UID,
        amount_staked: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
        staked_at: u64,
        applied_staking_days: u64,
        applied_interest_rate_bp: u16,
        staking_end_at: u64,
        reward: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
    }

    struct GameLiquidityPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
        e4c_staked: u64,
    }

    struct Staked has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct PoolPlaced has copy, drop {
        sender: address,
        amount: u64,
    }

    struct PoolWithdrawn has copy, drop {
        sender: address,
        amount: u64,
    }

    fun calculate_locking_time(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 24 * 60 * 60 * 1000
    }

    fun e4c_tokens_request(arg0: &mut GameLiquidityPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C> {
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.balance), 4);
        let v0 = PoolWithdrawn{
            sender : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<PoolWithdrawn>(v0);
        0x2::coin::take<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.balance, arg1, arg2)
    }

    public fun e4c_tokens_withdraw(arg0: &0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::AdminCap, arg1: &mut GameLiquidityPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C> {
        e4c_tokens_request(arg1, arg2, arg3)
    }

    public fun game_liquidity_pool_balance(arg0: &GameLiquidityPool) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameLiquidityPool{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(),
            e4c_staked : 0,
        };
        0x2::transfer::share_object<GameLiquidityPool>(v0);
    }

    public fun new_staking_receipt(arg0: 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>, arg1: &mut GameLiquidityPool, arg2: &0x2::clock::Clock, arg3: &0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::StakingConfig, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : StakingReceipt {
        let v0 = 0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::get_staking_rule(arg3, arg4);
        let (v1, v2) = 0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::staking_quantity_range(v0);
        let v3 = 0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0);
        assert!(v3 > v1, 0);
        assert!(v3 <= v2, 1);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0x2::object::new(arg5);
        let v6 = Staked{
            receipt_id : 0x2::object::uid_to_inner(&v5),
            owner      : 0x2::tx_context::sender(arg5),
            amount     : v3,
        };
        0x2::event::emit<Staked>(v6);
        arg1.e4c_staked = arg1.e4c_staked + v3;
        StakingReceipt{
            id                       : v5,
            amount_staked            : 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(arg0),
            staked_at                : v4,
            applied_staking_days     : arg4,
            applied_interest_rate_bp : 0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::annualized_interest_rate_bp(v0),
            staking_end_at           : calculate_locking_time(v4, arg4),
            reward                   : 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(e4c_tokens_request(arg1, 0x16003f426fd2746f2669813c6b744488a1f5b5cc3c36735a143f0cefc4d201b7::config::staking_reward(arg3, arg4, v3), arg5)),
        }
    }

    public fun place_in_pool(arg0: &mut GameLiquidityPool, arg1: 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg1) > 0, 3);
        let v0 = PoolPlaced{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg1),
        };
        0x2::event::emit<PoolPlaced>(v0);
        0x2::balance::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.balance, 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(arg1));
    }

    public fun staking_receipt_amount(arg0: &StakingReceipt) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.amount_staked)
    }

    public fun staking_receipt_applied_interest_rate_bp(arg0: &StakingReceipt) : u16 {
        arg0.applied_interest_rate_bp
    }

    public fun staking_receipt_applied_staking_days(arg0: &StakingReceipt) : u64 {
        arg0.applied_staking_days
    }

    public fun staking_receipt_reward(arg0: &StakingReceipt) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.reward)
    }

    public fun staking_receipt_staked_at(arg0: &StakingReceipt) : u64 {
        arg0.staked_at
    }

    public fun staking_receipt_staking_end_at(arg0: &StakingReceipt) : u64 {
        arg0.staking_end_at
    }

    public fun staking_receipt_staking_remain_period(arg0: &StakingReceipt, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.staking_end_at;
        if (v0 < v1) {
            v1 - v0
        } else {
            0
        }
    }

    public fun staking_receipt_total_reward_amount(arg0: &StakingReceipt) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.amount_staked) + 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.reward)
    }

    public fun unstake(arg0: StakingReceipt, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C> {
        assert!(arg0.staking_end_at <= 0x2::clock::timestamp_ms(arg1), 2);
        let StakingReceipt {
            id                       : v0,
            amount_staked            : v1,
            staked_at                : _,
            applied_staking_days     : _,
            applied_interest_rate_bp : _,
            staking_end_at           : _,
            reward                   : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v1;
        let v9 = v0;
        let v10 = Unstaked{
            receipt_id : 0x2::object::uid_to_inner(&v9),
            owner      : 0x2::tx_context::sender(arg2),
            amount     : 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&v8) + 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&v7),
        };
        0x2::event::emit<Unstaked>(v10);
        0x2::object::delete(v9);
        let v11 = 0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(v8, arg2);
        0x2::coin::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut v11, 0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(v7, arg2));
        v11
    }

    // decompiled from Move bytecode v6
}

