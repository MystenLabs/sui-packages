module 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::open_ended_staking {
    struct OpenEndedStakingRequest has key {
        id: 0x2::object::UID,
        total_staked_amount: u64,
        stakes: 0x2::linked_table::LinkedTable<0x2::object::ID, Stake>,
        last_withdrawn_at: 0x1::option::Option<u64>,
        cooldown_started_at: 0x1::option::Option<u64>,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        amount_staked: 0x2::balance::Balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>,
        staked_at: u64,
        bonus_apy_bp: 0x1::option::Option<u16>,
    }

    struct Staked has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct ToppedUp has copy, drop, store {
        id: 0x2::object::ID,
        amount: u64,
    }

    struct CooledDown has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RewardWithdrawn has copy, drop, store {
        id: 0x2::object::ID,
        amount: u64,
    }

    struct Redeemed has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun new(arg0: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg1: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_new(arg0, 0x1::option::none<u16>(), arg1, arg2, arg3);
        0x2::transfer::transfer<OpenEndedStakingRequest>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun calc_current_total_reward(arg0: &OpenEndedStakingRequest, arg1: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::linked_table::front<0x2::object::ID, Stake>(&arg0.stakes);
        let v1 = 0;
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = 0x1::option::borrow<0x2::object::ID>(v0);
            let v3 = 0x2::linked_table::borrow<0x2::object::ID, Stake>(&arg0.stakes, *v2);
            v1 = v1 + internal_calc_current_reward(0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v3.amount_staked), v3.staked_at, arg1, v3.bonus_apy_bp, arg0.last_withdrawn_at, arg2);
            v0 = 0x2::linked_table::next<0x2::object::ID, Stake>(&arg0.stakes, *v2);
        };
        v1
    }

    public fun can_redeem(arg0: &mut OpenEndedStakingRequest, arg1: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (0x1::option::is_none<u64>(&arg0.cooldown_started_at)) {
            return false
        };
        let v0 = *0x1::option::borrow<u64>(&arg0.cooldown_started_at) + 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_cooldown_period(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_oes(arg1));
        0x2::tx_context::epoch(arg2) >= v0 && 0x2::tx_context::epoch(arg2) < v0 + 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_withdrawal_period(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_oes(arg1))
    }

    public fun cooldown(arg0: &mut OpenEndedStakingRequest, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.cooldown_started_at = 0x1::option::some<u64>(0x2::tx_context::epoch(arg1));
        let v0 = CooledDown{id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CooledDown>(v0);
    }

    public fun cooldown_started_at(arg0: &OpenEndedStakingRequest) : 0x1::option::Option<u64> {
        arg0.cooldown_started_at
    }

    fun internal_calc_current_reward(arg0: u64, arg1: u64, arg2: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg3: 0x1::option::Option<u16>, arg4: 0x1::option::Option<u64>, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = (arg0 as u256);
        let v1 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::precision();
        let v2 = if (0x1::option::is_some<u64>(&arg4)) {
            0x2::tx_context::epoch(arg5) - *0x1::option::borrow<u64>(&arg4)
        } else {
            0x2::tx_context::epoch(arg5) - arg1
        };
        let v3 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_oes(arg2);
        let v4 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_reward_payout_frequency(v3);
        let v5 = if (0x1::option::is_some<u16>(&arg3)) {
            (*0x1::option::borrow<u16>(&arg3) as u256)
        } else {
            0
        };
        let v6 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_applied_apy_bp(v3, arg1);
        let v7 = v5 + (*0x1::option::borrow<u16>(&v6) as u256);
        let v8 = v0 * v1;
        let v9 = 0;
        while (v9 < v2 / v4) {
            let v10 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_applied_apy_bp(v3, arg1 + (v9 + 1) * v4);
            if (0x1::option::is_some<u16>(&v10)) {
                v7 = v5 + (*0x1::option::borrow<u16>(&v10) as u256);
            };
            let v11 = v8 * (v1 + v1 * (v4 as u256) * v7 / (0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::days_in_year() as u256) / (0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::max_bps() as u256));
            v8 = v11 / v1;
            v9 = v9 + 1;
        };
        ((v8 / v1 - v0) as u64)
    }

    fun internal_new(arg0: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg1: 0x1::option::Option<u16>, arg2: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg3: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg4: &mut 0x2::tx_context::TxContext) : OpenEndedStakingRequest {
        let v0 = internal_new_stake(arg0, arg1, arg2, arg3, arg4);
        let v1 = OpenEndedStakingRequest{
            id                  : 0x2::object::new(arg4),
            total_staked_amount : 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0),
            stakes              : 0x2::linked_table::new<0x2::object::ID, Stake>(arg4),
            last_withdrawn_at   : 0x1::option::none<u64>(),
            cooldown_started_at : 0x1::option::none<u64>(),
        };
        0x2::linked_table::push_front<0x2::object::ID, Stake>(&mut v1.stakes, 0x2::object::uid_to_inner(&v0.id), v0);
        let v2 = Staked{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<Staked>(v2);
        v1
    }

    fun internal_new_stake(arg0: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg1: 0x1::option::Option<u16>, arg2: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg3: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg4: &mut 0x2::tx_context::TxContext) : Stake {
        let v0 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_oes(arg3);
        assert!(is_min_stakable_amount_met(v0, 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0)), 0);
        assert!(is_max_staked_amount_met(v0, arg2, 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0)), 1);
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::add_total_staked_amount(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::borrow_mut_stats(arg2, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str(), 0x1::option::none<u64>()), 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0));
        Stake{
            id            : 0x2::object::new(arg4),
            amount_staked : 0x2::coin::into_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(arg0),
            staked_at     : 0x2::tx_context::epoch(arg4),
            bonus_apy_bp  : arg1,
        }
    }

    public fun is_max_staked_amount_met(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::OpenEndedStaking, arg1: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: u64) : bool {
        arg2 + 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::total_staked_amount(arg1, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str(), 0x1::option::none<u64>()) <= 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_max_lockable_amount(arg0)
    }

    public fun is_min_stakable_amount_met(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::OpenEndedStaking, arg1: u64) : bool {
        arg1 >= 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::oes_min_stakable_amount(arg0)
    }

    public fun last_withdrawn_at(arg0: &OpenEndedStakingRequest) : 0x1::option::Option<u64> {
        arg0.last_withdrawn_at
    }

    public fun new_by_admin(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::AdminCap, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg2: 0x1::option::Option<u16>, arg3: address, arg4: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg5: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OpenEndedStakingRequest>(internal_new(arg1, arg2, arg4, arg5, arg6), arg3);
    }

    public fun new_stake_by_admin(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::AdminCap, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg2: 0x1::option::Option<u16>, arg3: 0x2::object::ID, arg4: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg5: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Stake>(internal_new_stake(arg1, arg2, arg4, arg5, arg6), 0x2::object::id_to_address(&arg3));
    }

    public fun receive_stake(arg0: &mut OpenEndedStakingRequest, arg1: 0x2::transfer::Receiving<Stake>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<Stake>(&mut arg0.id, arg1);
        arg0.total_staked_amount = arg0.total_staked_amount + 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v0.amount_staked);
        0x2::linked_table::push_back<0x2::object::ID, Stake>(&mut arg0.stakes, 0x2::object::uid_to_inner(&v0.id), v0);
    }

    public fun redeem(arg0: OpenEndedStakingRequest, arg1: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES> {
        let v0 = &mut arg0;
        assert!(can_redeem(v0, arg2, arg3), 2);
        let v1 = 0x2::balance::zero<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>();
        let v2 = 0;
        while (0x2::linked_table::length<0x2::object::ID, Stake>(&arg0.stakes) > 0) {
            let (_, v4) = 0x2::linked_table::pop_back<0x2::object::ID, Stake>(&mut arg0.stakes);
            let v5 = v4;
            v2 = v2 + internal_calc_current_reward(0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v5.amount_staked), v5.staked_at, arg2, v5.bonus_apy_bp, arg0.last_withdrawn_at, arg3);
            let Stake {
                id            : v6,
                amount_staked : v7,
                staked_at     : _,
                bonus_apy_bp  : _,
            } = v5;
            0x2::balance::join<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut v1, v7);
            0x2::object::delete(v6);
        };
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::sub_total_staked_amount(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::borrow_mut_stats(arg1, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str(), 0x1::option::none<u64>()), 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v1));
        let v10 = Redeemed{id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<Redeemed>(v10);
        let OpenEndedStakingRequest {
            id                  : v11,
            total_staked_amount : _,
            stakes              : v13,
            last_withdrawn_at   : _,
            cooldown_started_at : _,
        } = arg0;
        0x2::linked_table::destroy_empty<0x2::object::ID, Stake>(v13);
        0x2::object::delete(v11);
        let v16 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::take_from_pool(arg1, v2, arg3);
        0x2::coin::join<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut v16, 0x2::coin::from_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(0x2::balance::withdraw_all<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut v1), arg3));
        0x2::balance::destroy_zero<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(v1);
        v16
    }

    public fun topup(arg0: &mut OpenEndedStakingRequest, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg2: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg3: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg1);
        let v1 = internal_new_stake(arg1, 0x1::option::none<u16>(), arg2, arg3, arg4);
        arg0.total_staked_amount = arg0.total_staked_amount + v0;
        let v2 = ToppedUp{
            id     : 0x2::object::uid_to_inner(&arg0.id),
            amount : v0,
        };
        0x2::event::emit<ToppedUp>(v2);
        0x2::linked_table::push_back<0x2::object::ID, Stake>(&mut arg0.stakes, 0x2::object::uid_to_inner(&v1.id), v1);
    }

    public fun total_staked_amount(arg0: &OpenEndedStakingRequest) : u64 {
        arg0.total_staked_amount
    }

    public fun withdraw_reward(arg0: &mut OpenEndedStakingRequest, arg1: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES> {
        let v0 = calc_current_total_reward(arg0, arg2, arg3);
        arg0.last_withdrawn_at = 0x1::option::some<u64>(0x2::tx_context::epoch(arg3));
        let v1 = RewardWithdrawn{
            id     : 0x2::object::uid_to_inner(&arg0.id),
            amount : v0,
        };
        0x2::event::emit<RewardWithdrawn>(v1);
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::take_from_pool(arg1, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

