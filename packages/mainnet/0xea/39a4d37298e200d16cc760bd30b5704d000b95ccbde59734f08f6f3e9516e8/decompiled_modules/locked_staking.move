module 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::locked_staking {
    struct LockedStakingRequest has key {
        id: 0x2::object::UID,
        amount_staked: 0x2::balance::Balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>,
        staked_at: u64,
        applied_apy_bp: u16,
        applied_staking_window: u64,
        reward: 0x2::balance::Balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>,
        bonus_apy_bp: 0x1::option::Option<u16>,
    }

    struct RestakingVoucher has key {
        id: 0x2::object::UID,
        restakable_staking_window: u64,
        restakeble_amount: u64,
        expired_at: u64,
    }

    struct Staked has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Restaked has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Unstaked has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun new(arg0: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg1: u64, arg2: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg3: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_new(arg0, arg1, 0x1::option::none<u16>(), arg2, arg3, arg4);
        0x2::transfer::transfer<LockedStakingRequest>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun amount_staked(arg0: &LockedStakingRequest) : u64 {
        0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0.amount_staked)
    }

    public fun applied_apy_bp(arg0: &LockedStakingRequest) : u16 {
        arg0.applied_apy_bp
    }

    public fun applied_staking_window(arg0: &LockedStakingRequest) : u64 {
        arg0.applied_staking_window
    }

    public fun bonus_apy_bp(arg0: &LockedStakingRequest) : u16 {
        if (0x1::option::is_some<u16>(&arg0.bonus_apy_bp)) {
            *0x1::option::borrow<u16>(&arg0.bonus_apy_bp)
        } else {
            0
        }
    }

    public fun can_restake(arg0: &RestakingVoucher, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) <= arg0.expired_at
    }

    public fun can_unstake(arg0: &LockedStakingRequest, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) >= arg0.staked_at + arg0.applied_staking_window
    }

    public fun expired_at(arg0: &RestakingVoucher) : u64 {
        arg0.expired_at
    }

    fun internal_calc_reward(arg0: u16, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::precision();
        ((v0 * (arg0 as u256) * (arg2 as u256) / (0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::days_in_year() as u256) * (arg1 as u256) / (0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::max_bps() as u256) / v0) as u64)
    }

    fun internal_new(arg0: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg1: u64, arg2: 0x1::option::Option<u16>, arg3: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg4: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg5: &mut 0x2::tx_context::TxContext) : LockedStakingRequest {
        let v0 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_ls(arg4);
        assert!(is_min_stakable_amount_met(v0, 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0), arg1), 0);
        assert!(is_max_staked_amount_met(v0, arg3, 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0), arg1, arg5), 1);
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::add_total_staked_amount(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::borrow_mut_stats(arg3, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str(), 0x1::option::some<u64>(arg1)), 0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0));
        let v1 = LockedStakingRequest{
            id                     : 0x2::object::new(arg5),
            amount_staked          : 0x2::coin::into_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(arg0),
            staked_at              : 0x2::tx_context::epoch(arg5),
            applied_apy_bp         : 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::ls_apy_bp(v0, arg1),
            applied_staking_window : arg1,
            reward                 : 0x2::balance::zero<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(),
            bonus_apy_bp           : arg2,
        };
        0x2::balance::join<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut v1.reward, 0x2::coin::into_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::take_from_pool(arg3, internal_calc_reward(v1.applied_apy_bp + bonus_apy_bp(&v1), 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v1.amount_staked), v1.applied_staking_window), arg5)));
        let v2 = Staked{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<Staked>(v2);
        v1
    }

    public fun is_max_staked_amount_met(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::LockedStaking, arg1: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : bool {
        arg2 + 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::total_locked_amount(arg1, arg3, arg4) <= 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::ls_max_lockable_amount(arg0, arg3)
    }

    public fun is_min_stakable_amount_met(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::LockedStaking, arg1: u64, arg2: u64) : bool {
        arg1 >= 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::ls_min_stakable_amount(arg0, arg2)
    }

    public fun new_by_admin(arg0: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::AdminCap, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg2: u64, arg3: 0x1::option::Option<u16>, arg4: address, arg5: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg6: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<LockedStakingRequest>(internal_new(arg1, arg2, arg3, arg5, arg6, arg7), arg4);
    }

    public fun restakable_staking_window(arg0: &RestakingVoucher) : u64 {
        arg0.restakable_staking_window
    }

    public fun restake(arg0: RestakingVoucher, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>, arg2: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg3: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(can_restake(&arg0, arg4), 3);
        assert!(0x2::coin::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg1) == arg0.restakeble_amount, 4);
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::sub_reserved_amount(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::borrow_mut_stats(arg2, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str(), 0x1::option::some<u64>(arg0.restakable_staking_window)), arg0.expired_at, arg0.restakeble_amount);
        new(arg1, arg0.restakable_staking_window, arg2, arg3, arg4);
        let v0 = Restaked{id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<Restaked>(v0);
        let RestakingVoucher {
            id                        : v1,
            restakable_staking_window : _,
            restakeble_amount         : _,
            expired_at                : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun restakeble_amount(arg0: &RestakingVoucher) : u64 {
        arg0.restakeble_amount
    }

    public fun reward(arg0: &LockedStakingRequest) : u64 {
        0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0.reward)
    }

    public fun staked_at(arg0: &LockedStakingRequest) : u64 {
        arg0.staked_at
    }

    public fun unstake(arg0: LockedStakingRequest, arg1: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: &0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES> {
        assert!(can_unstake(&arg0, arg3), 2);
        let LockedStakingRequest {
            id                     : v0,
            amount_staked          : v1,
            staked_at              : _,
            applied_apy_bp         : _,
            applied_staking_window : v4,
            reward                 : v5,
            bonus_apy_bp           : _,
        } = arg0;
        let v7 = v5;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x2::tx_context::epoch(arg3) + 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::ls_restakable_window(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config::borrow_ls(arg2), v4);
        let v11 = 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::borrow_mut_stats(arg1, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str(), 0x1::option::some<u64>(v4));
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::sub_total_staked_amount(v11, 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v8));
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::add_reserved_amount(v11, v10, 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v8));
        let v12 = RestakingVoucher{
            id                        : 0x2::object::new(arg3),
            restakable_staking_window : v4,
            restakeble_amount         : 0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&v8),
            expired_at                : v10,
        };
        0x2::transfer::transfer<RestakingVoucher>(v12, 0x2::tx_context::sender(arg3));
        let v13 = Unstaked{id: 0x2::object::uid_to_inner(&v9)};
        0x2::event::emit<Unstaked>(v13);
        0x2::object::delete(v9);
        0x2::balance::join<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut v7, v8);
        0x2::coin::from_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(v7, arg3)
    }

    // decompiled from Move bytecode v6
}

