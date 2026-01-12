module 0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2 {
    struct FAITHGG_STAKING_V2 has drop {
        dummy_field: bool,
    }

    struct FaithStakingAccount has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>,
        tier: u8,
        rewards: u64,
        reward_debt: u256,
        stake_epoch: u64,
        unlock_epoch: u64,
        virtual_amount: u64,
        multiplier_bps: u64,
    }

    struct FaithStakingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FaithStakingPool has store, key {
        id: 0x2::object::UID,
        undistributed_rewards: u64,
        reward_balance: 0x2::balance::Balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>,
        total_virtual_amount: u64,
        accrued_rewards_per_share: u256,
        paused: bool,
        version: u64,
    }

    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct Staked has copy, drop {
        amount: u64,
        tier: u8,
        unlock_epoch: u64,
        virtual_amount: u64,
        multiplier_bps: u64,
    }

    struct Unstaked has copy, drop {
        amount: u64,
        was_early: bool,
        penalty_amount: u64,
    }

    struct RewardsClaimed has copy, drop {
        amount: u64,
        penalty_amount: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u64,
        new_accrued_per_share: u256,
    }

    struct BuybackApplied has copy, drop {
        total: u64,
        burned: u64,
        rewards: u64,
    }

    struct PauseStatus has copy, drop {
        pos0: bool,
    }

    public fun claim(arg0: &mut FaithStakingPool, arg1: &mut FaithStakingAccount, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH> {
        assert_version(arg0);
        assert_is_unpaused(arg0);
        settle_rewards(arg1, arg0, arg2);
        assert!(arg1.rewards > 0, 13836185424069132309);
        let v0 = if (0x2::tx_context::epoch(arg2) < arg1.unlock_epoch) {
            apply_early_penalty(arg1, arg0)
        } else {
            0
        };
        let v1 = 0x1::u64::min(arg1.rewards, 0x2::balance::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.reward_balance));
        arg1.rewards = 0;
        arg1.reward_debt = (((arg1.virtual_amount as u256) * (arg0.accrued_rewards_per_share as u256) / (1000000000000000000 as u256)) as u256);
        let v2 = RewardsClaimed{
            amount         : v1,
            penalty_amount : v0,
        };
        emit_event<RewardsClaimed>(v2);
        0x2::coin::from_balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(0x2::balance::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.reward_balance, v1), arg2)
    }

    public fun account_balance(arg0: &FaithStakingAccount) : u64 {
        0x2::balance::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.balance)
    }

    public fun account_multiplier_bps(arg0: &FaithStakingAccount) : u64 {
        arg0.multiplier_bps
    }

    public fun account_tier(arg0: &FaithStakingAccount) : u8 {
        arg0.tier
    }

    public fun account_unlock_epoch(arg0: &FaithStakingAccount) : u64 {
        arg0.unlock_epoch
    }

    public fun account_virtual_amount(arg0: &FaithStakingAccount) : u64 {
        arg0.virtual_amount
    }

    fun apply_early_penalty(arg0: &mut FaithStakingAccount, arg1: &mut FaithStakingPool) : u64 {
        let v0 = (((arg0.rewards as u256) * (1500 as u256) / 10000) as u64);
        arg0.rewards = arg0.rewards - v0;
        if (v0 > 0 && arg1.total_virtual_amount > 0) {
            arg1.accrued_rewards_per_share = arg1.accrued_rewards_per_share + (((v0 as u256) * (1000000000000000000 as u256) / (arg1.total_virtual_amount as u256)) as u256);
        };
        v0
    }

    fun assert_is_unpaused(arg0: &FaithStakingPool) {
        assert!(!arg0.paused, 13835904404358823955);
    }

    fun assert_version(arg0: &FaithStakingPool) {
        assert!(arg0.version == 1, 13837030321446060059);
    }

    public fun burn90_and_deposit10(arg0: &mut FaithStakingPool, arg1: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg2: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg2);
        assert!(v0 > 0, 13835341604728995855);
        let v1 = (((v0 as u256) * 9000 / 10000) as u64);
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::burn_faith(arg1, 0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg2, v1, arg3));
        deposit_rewards(arg0, arg2);
        let v2 = BuybackApplied{
            total   : v0,
            burned  : v1,
            rewards : v0 - v1,
        };
        emit_event<BuybackApplied>(v2);
    }

    public fun deposit_rewards(arg0: &mut FaithStakingPool, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>) {
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1);
        assert!(v0 > 0, 13835341604728995855);
        0x2::balance::join<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1));
        if (arg0.total_virtual_amount > 0) {
            arg0.undistributed_rewards = 0;
            arg0.accrued_rewards_per_share = arg0.accrued_rewards_per_share + ((((v0 + arg0.undistributed_rewards) as u256) * (1000000000000000000 as u256) / (arg0.total_virtual_amount as u256)) as u256);
        } else {
            arg0.undistributed_rewards = arg0.undistributed_rewards + v0;
        };
        let v1 = RewardsDeposited{
            amount                : v0,
            new_accrued_per_share : arg0.accrued_rewards_per_share,
        };
        emit_event<RewardsDeposited>(v1);
    }

    public fun destroy_account(arg0: FaithStakingAccount) {
        let FaithStakingAccount {
            id             : v0,
            balance        : v1,
            tier           : _,
            rewards        : v3,
            reward_debt    : _,
            stake_epoch    : _,
            unlock_epoch   : _,
            virtual_amount : _,
            multiplier_bps : _,
        } = arg0;
        assert!(v3 == 0, 13836467049369829399);
        0x2::balance::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v1);
        0x2::object::delete(v0);
    }

    fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    fun init(arg0: FAITHGG_STAKING_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FAITHGG_STAKING_V2>(arg0, arg1);
        0x2::display::create_and_keep<FaithStakingAccount>(&v0, arg1);
        let v1 = FaithStakingPool{
            id                        : 0x2::object::new(arg1),
            undistributed_rewards     : 0,
            reward_balance            : 0x2::balance::zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(),
            total_virtual_amount      : 0,
            accrued_rewards_per_share : 0,
            paused                    : true,
            version                   : 1,
        };
        0x2::transfer::share_object<FaithStakingPool>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        let v3 = FaithStakingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<FaithStakingAdminCap>(v3, v2);
    }

    public fun is_locked(arg0: &FaithStakingAccount, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) < arg0.unlock_epoch
    }

    public fun lock_duration(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            30
        } else if (arg0 == 2) {
            60
        } else {
            assert!(arg0 == 3, 13836747712597852185);
            100
        }
    }

    public fun multiplier(arg0: u8) : u64 {
        if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            15000
        } else if (arg0 == 2) {
            20000
        } else {
            assert!(arg0 == 3, 13836747652468310041);
            25000
        }
    }

    public fun pause(arg0: &mut FaithStakingPool, arg1: &FaithStakingAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = true;
        let v0 = PauseStatus{pos0: true};
        emit_event<PauseStatus>(v0);
    }

    public fun pending_rewards(arg0: &FaithStakingAccount, arg1: &FaithStakingPool) : u64 {
        if (arg0.virtual_amount == 0) {
            return arg0.rewards
        };
        let v0 = (((arg0.virtual_amount as u256) * (arg1.accrued_rewards_per_share as u256) / (1000000000000000000 as u256)) as u256);
        let v1 = if (v0 > arg0.reward_debt) {
            ((v0 - arg0.reward_debt) as u64)
        } else {
            0
        };
        arg0.rewards + v1
    }

    public fun pool_reward_balance(arg0: &FaithStakingPool) : u64 {
        0x2::balance::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.reward_balance)
    }

    public fun pool_total_virtual(arg0: &FaithStakingPool) : u64 {
        arg0.total_virtual_amount
    }

    fun settle_rewards(arg0: &mut FaithStakingAccount, arg1: &FaithStakingPool, arg2: &0x2::tx_context::TxContext) {
        if (arg0.virtual_amount == 0) {
            return
        };
        if (0x2::tx_context::epoch(arg2) < arg0.stake_epoch + 1) {
            return
        };
        let v0 = (((arg0.virtual_amount as u256) * (arg1.accrued_rewards_per_share as u256) / (1000000000000000000 as u256)) as u256);
        if (v0 > arg0.reward_debt) {
            arg0.rewards = arg0.rewards + ((v0 - arg0.reward_debt) as u64);
        };
    }

    public fun stake(arg0: &mut FaithStakingPool, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : FaithStakingAccount {
        assert_version(arg0);
        assert_is_unpaused(arg0);
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1);
        assert!(v0 > 0, 13835341604728995855);
        assert!(arg2 <= 3, 13836747983180791833);
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = multiplier(arg2);
        let v3 = lock_duration(arg2);
        let v4 = if (v3 > 0) {
            v1 + v3
        } else {
            0
        };
        let v5 = (((v0 as u256) * (v2 as u256) / (10000 as u256)) as u64);
        arg0.total_virtual_amount = arg0.total_virtual_amount + v5;
        let v6 = Staked{
            amount         : v0,
            tier           : arg2,
            unlock_epoch   : v4,
            virtual_amount : v5,
            multiplier_bps : v2,
        };
        emit_event<Staked>(v6);
        FaithStakingAccount{
            id             : 0x2::object::new(arg3),
            balance        : 0x2::coin::into_balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1),
            tier           : arg2,
            rewards        : 0,
            reward_debt    : (((v5 as u256) * (arg0.accrued_rewards_per_share as u256) / (1000000000000000000 as u256)) as u256),
            stake_epoch    : v1,
            unlock_epoch   : v4,
            virtual_amount : v5,
            multiplier_bps : v2,
        }
    }

    public fun unpause(arg0: &mut FaithStakingPool, arg1: &FaithStakingAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = false;
        let v0 = PauseStatus{pos0: false};
        emit_event<PauseStatus>(v0);
    }

    public fun unstake(arg0: &mut FaithStakingPool, arg1: &mut FaithStakingAccount, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH> {
        assert_version(arg0);
        assert_is_unpaused(arg0);
        assert!(arg2 > 0, 13835340805865078799);
        let v0 = 0x2::balance::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1.balance);
        assert!(v0 >= arg2, 13835622298021789713);
        assert!(0x2::tx_context::epoch(arg3) >= arg1.unlock_epoch, 13837311169357676573);
        settle_rewards(arg1, arg0, arg3);
        let v1 = ((((v0 - arg2) as u256) * (arg1.multiplier_bps as u256) / (10000 as u256)) as u64);
        arg1.virtual_amount = v1;
        arg0.total_virtual_amount = arg0.total_virtual_amount - arg1.virtual_amount + v1;
        arg1.reward_debt = (((v1 as u256) * (arg0.accrued_rewards_per_share as u256) / (1000000000000000000 as u256)) as u256);
        let v2 = Unstaked{
            amount         : arg2,
            was_early      : false,
            penalty_amount : 0,
        };
        emit_event<Unstaked>(v2);
        0x2::coin::from_balance<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(0x2::balance::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

