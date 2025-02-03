module 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::farm {
    struct FarmWitness has drop {
        dummy_field: bool,
    }

    struct Account<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        amount: u64,
        reward_debt: u256,
    }

    struct Farm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        rewards_per_second: u64,
        start_timestamp: u64,
        last_reward_timestamp: u64,
        accrued_rewards_per_share: u256,
        balance_stake_coin: 0x2::balance::Balance<T0>,
        balance_reward_coin: 0x2::balance::Balance<T1>,
        stake_coin_decimal_factor: u64,
        owned_by: 0x2::object::ID,
    }

    struct NewFarm<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct AddReward<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        value: u64,
    }

    struct Stake<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        stake_amount: u64,
        reward_amount: u64,
    }

    struct Unstake<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        unstake_amount: u64,
        reward_amount: u64,
    }

    struct NewRewardRate<phantom T0, phantom T1> has copy, drop {
        farm: 0x2::object::ID,
        rate: u64,
    }

    public fun accrued_rewards_per_share<T0, T1>(arg0: &Farm<T0, T1>) : u256 {
        arg0.accrued_rewards_per_share
    }

    public fun add_rewards<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>) {
        update<T0, T1>(arg0, clock_timestamp_s(arg1));
        let v0 = AddReward<T0, T1>{
            farm  : 0x2::object::id<Farm<T0, T1>>(arg0),
            value : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<AddReward<T0, T1>>(v0);
        0x2::balance::join<T1>(&mut arg0.balance_reward_coin, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun amount<T0, T1>(arg0: &Account<T0, T1>) : u64 {
        arg0.amount
    }

    public fun balance_reward_coin<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_reward_coin)
    }

    public fun balance_stake_coin<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_stake_coin)
    }

    public fun borrow_mut_uid<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness>) : &mut 0x2::object::UID {
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(arg0));
        &mut arg0.id
    }

    fun calculate_accrued_rewards_per_share(arg0: u64, arg1: u256, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u256 {
        arg1 + 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math256::min((arg3 as u256), (arg0 as u256) * (arg5 as u256)) * (arg4 as u256) / (arg2 as u256)
    }

    fun calculate_pending_rewards<T0, T1>(arg0: &Account<T0, T1>, arg1: u64, arg2: u256) : u64 {
        (((arg0.amount as u256) * arg2 / (arg1 as u256) - arg0.reward_debt) as u64)
    }

    fun calculate_reward_debt(arg0: u64, arg1: u64, arg2: u256) : u256 {
        (arg0 as u256) * arg2 / (arg1 as u256)
    }

    fun clock_timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun destroy_zero_account<T0, T1>(arg0: Account<T0, T1>) {
        let Account {
            id          : v0,
            farm_id     : _,
            amount      : v2,
            reward_debt : _,
        } = arg0;
        assert!(v2 == 0, 1);
        0x2::object::delete(v0);
    }

    public fun destroy_zero_farm<T0, T1>(arg0: Farm<T0, T1>, arg1: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness>) {
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(&arg0));
        let Farm {
            id                        : v0,
            rewards_per_second        : _,
            start_timestamp           : _,
            last_reward_timestamp     : _,
            accrued_rewards_per_share : _,
            balance_stake_coin        : v5,
            balance_reward_coin       : v6,
            stake_coin_decimal_factor : _,
            owned_by                  : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T1>(v6);
        0x2::balance::destroy_zero<T0>(v5);
    }

    public fun last_reward_timestamp<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.last_reward_timestamp
    }

    public fun new_account<T0, T1>(arg0: &Farm<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : Account<T0, T1> {
        Account<T0, T1>{
            id          : 0x2::object::new(arg1),
            farm_id     : 0x2::object::id<Farm<T0, T1>>(arg0),
            amount      : 0,
            reward_debt : 0,
        }
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness> {
        let v0 = FarmWitness{dummy_field: false};
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::new<FarmWitness>(v0, 0x1::vector::empty<0x2::object::ID>(), arg0)
    }

    public fun new_farm<T0, T1>(arg0: &mut 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Farm<T0, T1> {
        assert!(arg4 > clock_timestamp_s(arg2), 3);
        let v0 = 0x2::object::id<0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness>>(arg0);
        let v1 = Farm<T0, T1>{
            id                        : 0x2::object::new(arg5),
            rewards_per_second        : arg3,
            start_timestamp           : arg4,
            last_reward_timestamp     : arg4,
            accrued_rewards_per_share : 0,
            balance_stake_coin        : 0x2::balance::zero<T0>(),
            balance_reward_coin       : 0x2::balance::zero<T1>(),
            stake_coin_decimal_factor : 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg1)),
            owned_by                  : v0,
        };
        let v2 = 0x2::object::id<Farm<T0, T1>>(&v1);
        let v3 = FarmWitness{dummy_field: false};
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::add<FarmWitness>(arg0, v3, v2);
        let v4 = NewFarm<T0, T1>{
            farm : v2,
            cap  : v0,
        };
        0x2::event::emit<NewFarm<T0, T1>>(v4);
        v1
    }

    public fun owned_by<T0, T1>(arg0: &Farm<T0, T1>) : 0x2::object::ID {
        arg0.owned_by
    }

    public fun pending_rewards<T0, T1>(arg0: &Farm<T0, T1>, arg1: &Account<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::object::id<Farm<T0, T1>>(arg0) != arg1.farm_id) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.balance_stake_coin);
        let v1 = clock_timestamp_s(arg2);
        let v2 = if (v0 == 0 || arg0.last_reward_timestamp >= v1) {
            arg0.accrued_rewards_per_share
        } else {
            calculate_accrued_rewards_per_share(arg0.rewards_per_second, arg0.accrued_rewards_per_share, v0, 0x2::balance::value<T1>(&arg0.balance_reward_coin), arg0.stake_coin_decimal_factor, v1 - arg0.last_reward_timestamp)
        };
        calculate_pending_rewards<T0, T1>(arg1, arg0.stake_coin_decimal_factor, v2)
    }

    public fun reward_debt<T0, T1>(arg0: &Account<T0, T1>) : u256 {
        arg0.reward_debt
    }

    public fun rewards_per_second<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.rewards_per_second
    }

    public fun stake<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<Farm<T0, T1>>(arg0) == arg1.farm_id, 5);
        update<T0, T1>(arg0, clock_timestamp_s(arg3));
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::zero<T1>(arg4);
        if (arg1.amount != 0) {
            let v2 = 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math64::min(calculate_pending_rewards<T0, T1>(arg1, arg0.stake_coin_decimal_factor, arg0.accrued_rewards_per_share), 0x2::balance::value<T1>(&arg0.balance_reward_coin));
            if (v2 != 0) {
                0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v1), 0x2::balance::split<T1>(&mut arg0.balance_reward_coin, v2));
            };
        };
        if (v0 != 0) {
            0x2::balance::join<T0>(&mut arg0.balance_stake_coin, 0x2::coin::into_balance<T0>(arg2));
            arg1.amount = arg1.amount + v0;
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        arg1.reward_debt = calculate_reward_debt(arg1.amount, arg0.stake_coin_decimal_factor, arg0.accrued_rewards_per_share);
        let v3 = Stake<T0, T1>{
            farm          : 0x2::object::id<Farm<T0, T1>>(arg0),
            stake_amount  : v0,
            reward_amount : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<Stake<T0, T1>>(v3);
        v1
    }

    public fun stake_coin_decimal_factor<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.stake_coin_decimal_factor
    }

    public fun start_timestamp<T0, T1>(arg0: &Farm<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public fun unstake<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut Account<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::object::id<Farm<T0, T1>>(arg0) == arg1.farm_id, 5);
        update<T0, T1>(arg0, clock_timestamp_s(arg3));
        assert!(arg1.amount >= arg2, 0);
        let v0 = calculate_pending_rewards<T0, T1>(arg1, arg0.stake_coin_decimal_factor, arg0.accrued_rewards_per_share);
        let v1 = 0x2::coin::zero<T0>(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        if (arg2 != 0) {
            arg1.amount = arg1.amount - arg2;
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut v1), 0x2::balance::split<T0>(&mut arg0.balance_stake_coin, arg2));
        };
        if (v0 != 0) {
            0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v2), 0x2::balance::split<T1>(&mut arg0.balance_reward_coin, 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math64::min(v0, 0x2::balance::value<T1>(&arg0.balance_reward_coin))));
        };
        arg1.reward_debt = calculate_reward_debt(arg1.amount, arg0.stake_coin_decimal_factor, arg0.accrued_rewards_per_share);
        let v3 = Unstake<T0, T1>{
            farm           : 0x2::object::id<Farm<T0, T1>>(arg0),
            unstake_amount : arg2,
            reward_amount  : v0,
        };
        0x2::event::emit<Unstake<T0, T1>>(v3);
        (v1, v2)
    }

    fun update<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        if (arg0.last_reward_timestamp >= arg1 || arg0.start_timestamp > arg1) {
            return
        };
        let v0 = 0x2::balance::value<T0>(&arg0.balance_stake_coin);
        arg0.last_reward_timestamp = arg1;
        if (v0 == 0) {
            return
        };
        arg0.accrued_rewards_per_share = calculate_accrued_rewards_per_share(arg0.rewards_per_second, arg0.accrued_rewards_per_share, v0, 0x2::balance::value<T1>(&arg0.balance_reward_coin), arg0.stake_coin_decimal_factor, arg1 - arg0.last_reward_timestamp);
    }

    public fun update_rewards_per_second<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<FarmWitness>, arg2: u64, arg3: &0x2::clock::Clock) {
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::assert_ownership<FarmWitness>(arg1, 0x2::object::id<Farm<T0, T1>>(arg0));
        update<T0, T1>(arg0, clock_timestamp_s(arg3));
        arg0.rewards_per_second = arg2;
        let v0 = NewRewardRate<T0, T1>{
            farm : 0x2::object::id<Farm<T0, T1>>(arg0),
            rate : arg2,
        };
        0x2::event::emit<NewRewardRate<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

