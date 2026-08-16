module 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        staked: 0x2::balance::Balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>,
        rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        carry: 0x2::balance::Balance<0x2::sui::SUI>,
        acc_reward_per_share: u128,
        total_staked: u64,
        total_pending: u64,
        total_unbonding: u64,
        total_funded: u64,
        total_claimed: u64,
        paused: bool,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        active: u64,
        pending: u64,
        activates_at_ms: u64,
        unbonding: u64,
        unbonds_at_ms: u64,
        reward_debt: u128,
    }

    struct Funded has copy, drop {
        amount: u64,
        total_staked: u64,
        acc: u128,
    }

    struct Deposited has copy, drop {
        who: address,
        amount: u64,
        position: 0x2::object::ID,
        activates_at_ms: u64,
    }

    struct Activated has copy, drop {
        who: address,
        amount: u64,
        position: 0x2::object::ID,
        total_staked: u64,
    }

    struct UnstakeRequested has copy, drop {
        who: address,
        amount: u64,
        position: 0x2::object::ID,
        unbonds_at_ms: u64,
    }

    struct Withdrawn has copy, drop {
        who: address,
        amount: u64,
        position: 0x2::object::ID,
    }

    struct RewardClaimed has copy, drop {
        who: address,
        amount: u64,
        position: 0x2::object::ID,
    }

    struct FundedWhileEmpty has copy, drop {
        amount: u64,
        carry_total: u64,
    }

    struct PausedSet has copy, drop {
        paused: bool,
    }

    public fun activate(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pending > 0, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.activates_at_ms, 4);
        let v0 = arg1.pending;
        arg1.pending = 0;
        arg1.active = arg1.active + v0;
        arg0.total_pending = arg0.total_pending - v0;
        arg0.total_staked = arg0.total_staked + v0;
        arg1.reward_debt = debt_for(arg0, arg1.active) - (pending_rewards(arg0, arg1) as u128);
        let v1 = Activated{
            who          : 0x2::tx_context::sender(arg3),
            amount       : v0,
            position     : 0x2::object::id<StakePosition>(arg1),
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Activated>(v1);
    }

    public fun activates_at_ms(arg0: &StakePosition) : u64 {
        arg0.activates_at_ms
    }

    public fun active_amount(arg0: &StakePosition) : u64 {
        arg0.active
    }

    public fun add_stake(arg0: &mut Vault, arg1: &mut StakePosition, arg2: 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&arg2);
        assert!(v0 > 0, 0);
        0x2::balance::join<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&mut arg0.staked, 0x2::coin::into_balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(arg2));
        arg0.total_pending = arg0.total_pending + v0;
        arg1.pending = arg1.pending + v0;
        arg1.activates_at_ms = 0x2::clock::timestamp_ms(arg3) + 259200000;
        let v1 = Deposited{
            who             : 0x2::tx_context::sender(arg4),
            amount          : v0,
            position        : 0x2::object::id<StakePosition>(arg1),
            activates_at_ms : arg1.activates_at_ms,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun carry_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.carry)
    }

    public fun claim_rewards(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = harvest(arg0, arg1, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) > 0, 2);
        v0
    }

    public fun claim_rewards_entry(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun close_position(arg0: StakePosition) {
        let v0 = if (arg0.active == 0) {
            if (arg0.pending == 0) {
                arg0.unbonding == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        let StakePosition {
            id              : v1,
            active          : _,
            pending         : _,
            activates_at_ms : _,
            unbonding       : _,
            unbonds_at_ms   : _,
            reward_debt     : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    fun debt_for(arg0: &Vault, arg1: u64) : u128 {
        (arg1 as u128) * arg0.acc_reward_per_share / 1000000000000
    }

    public fun fund(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        if (arg0.total_staked == 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.carry, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            let v1 = FundedWhileEmpty{
                amount      : v0,
                carry_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.carry),
            };
            0x2::event::emit<FundedWhileEmpty>(v1);
            return
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.carry);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.carry, v2));
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + (v4 as u128) * 1000000000000 / (arg0.total_staked as u128);
        arg0.total_funded = arg0.total_funded + v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.rewards, v3);
        let v5 = Funded{
            amount       : v4,
            total_staked : arg0.total_staked,
            acc          : arg0.acc_reward_per_share,
        };
        0x2::event::emit<Funded>(v5);
    }

    public fun fund_entry(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        fund(arg0, arg1);
    }

    fun harvest(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = pending_rewards(arg0, arg1);
        arg1.reward_debt = debt_for(arg0, arg1.active);
        if (v0 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg2)
        };
        arg0.total_claimed = arg0.total_claimed + v0;
        let v1 = RewardClaimed{
            who      : 0x2::tx_context::sender(arg2),
            amount   : v0,
            position : 0x2::object::id<StakePosition>(arg1),
        };
        0x2::event::emit<RewardClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rewards, v0), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id                   : 0x2::object::new(arg0),
            staked               : 0x2::balance::zero<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(),
            rewards              : 0x2::balance::zero<0x2::sui::SUI>(),
            carry                : 0x2::balance::zero<0x2::sui::SUI>(),
            acc_reward_per_share : 0,
            total_staked         : 0,
            total_pending        : 0,
            total_unbonding      : 0,
            total_funded         : 0,
            total_claimed        : 0,
            paused               : false,
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun pending_amount(arg0: &StakePosition) : u64 {
        arg0.pending
    }

    public fun pending_rewards(arg0: &Vault, arg1: &StakePosition) : u64 {
        let v0 = (arg1.active as u128) * arg0.acc_reward_per_share / 1000000000000;
        if (v0 <= arg1.reward_debt) {
            0
        } else {
            ((v0 - arg1.reward_debt) as u64)
        }
    }

    public fun request_unstake(arg0: &mut Vault, arg1: &mut StakePosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 3);
        assert!(arg2 > 0, 0);
        assert!(arg1.active >= arg2, 1);
        let v0 = harvest(arg0, arg1, arg4);
        arg1.active = arg1.active - arg2;
        arg0.total_staked = arg0.total_staked - arg2;
        arg1.unbonding = arg1.unbonding + arg2;
        arg0.total_unbonding = arg0.total_unbonding + arg2;
        arg1.unbonds_at_ms = 0x2::clock::timestamp_ms(arg3) + 259200000;
        arg1.reward_debt = debt_for(arg0, arg1.active);
        let v1 = UnstakeRequested{
            who           : 0x2::tx_context::sender(arg4),
            amount        : arg2,
            position      : 0x2::object::id<StakePosition>(arg1),
            unbonds_at_ms : arg1.unbonds_at_ms,
        };
        0x2::event::emit<UnstakeRequested>(v1);
        v0
    }

    public fun request_unstake_entry(arg0: &mut Vault, arg1: &mut StakePosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = request_unstake(arg0, arg1, arg2, arg3, arg4);
        transfer_or_burn_zero(v0, 0x2::tx_context::sender(arg4));
    }

    public fun set_paused(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: &mut Vault, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedSet{paused: arg2};
        0x2::event::emit<PausedSet>(v0);
    }

    public fun stake(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakePosition {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&mut arg0.staked, 0x2::coin::into_balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(arg1));
        arg0.total_pending = arg0.total_pending + v0;
        let v1 = 0x2::clock::timestamp_ms(arg2) + 259200000;
        let v2 = StakePosition{
            id              : 0x2::object::new(arg3),
            active          : 0,
            pending         : v0,
            activates_at_ms : v1,
            unbonding       : 0,
            unbonds_at_ms   : 0,
            reward_debt     : 0,
        };
        let v3 = Deposited{
            who             : 0x2::tx_context::sender(arg3),
            amount          : v0,
            position        : 0x2::object::id<StakePosition>(&v2),
            activates_at_ms : v1,
        };
        0x2::event::emit<Deposited>(v3);
        v2
    }

    public fun stake_entry(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<StakePosition>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun total_claimed(arg0: &Vault) : u64 {
        arg0.total_claimed
    }

    public fun total_funded(arg0: &Vault) : u64 {
        arg0.total_funded
    }

    public fun total_pending(arg0: &Vault) : u64 {
        arg0.total_pending
    }

    public fun total_staked(arg0: &Vault) : u64 {
        arg0.total_staked
    }

    public fun total_unbonding(arg0: &Vault) : u64 {
        arg0.total_unbonding
    }

    fun transfer_or_burn_zero(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        };
    }

    public fun unbonding_amount(arg0: &StakePosition) : u64 {
        arg0.unbonding
    }

    public fun unbonding_ms() : u64 {
        259200000
    }

    public fun unbonds_at_ms(arg0: &StakePosition) : u64 {
        arg0.unbonds_at_ms
    }

    public fun unclaimed_rewards(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.rewards)
    }

    public fun warmup_ms() : u64 {
        259200000
    }

    public fun withdraw(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA> {
        assert!(arg1.unbonding > 0, 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unbonds_at_ms, 6);
        let v0 = arg1.unbonding;
        arg1.unbonding = 0;
        arg0.total_unbonding = arg0.total_unbonding - v0;
        let v1 = Withdrawn{
            who      : 0x2::tx_context::sender(arg3),
            amount   : v0,
            position : 0x2::object::id<StakePosition>(arg1),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(0x2::balance::split<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&mut arg0.staked, v0), arg3)
    }

    public fun withdraw_entry(arg0: &mut Vault, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

