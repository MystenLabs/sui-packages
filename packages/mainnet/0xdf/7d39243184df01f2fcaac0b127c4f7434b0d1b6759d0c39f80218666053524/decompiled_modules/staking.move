module 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::staking {
    struct LockedV has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>,
        rewards_to_claim: u64,
        locked_for: u64,
        category: u64,
    }

    struct LockDetails has store, key {
        id: 0x2::object::UID,
        locking_details: 0x2::table::Table<u64, CategoryDetails>,
        is_paused: bool,
    }

    struct CategoryDetails has store {
        duration: u64,
        coin_amount: u64,
        rewards_distributed: u64,
        total_rewards: 0x2::balance::Balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>,
        total_staked: u64,
        target_tvl: u64,
        currently_locked: u64,
        stakers: 0x2::table_vec::TableVec<address>,
    }

    struct LockingPeriodUpdated has copy, drop {
        amount: u64,
        period: u64,
        category: u64,
    }

    struct RewardsAdded has copy, drop {
        amount: u64,
        category: u64,
    }

    struct TokensLocked has copy, drop {
        staker: address,
        amount: u64,
        locked_for: u64,
        rewards_to_claim: u64,
    }

    struct TokensUnlocked has copy, drop {
        staker: address,
        amount: u64,
        rewards_claimed: u64,
    }

    struct LockingPeriodAdded has copy, drop {
        amount: u64,
        period: u64,
        category: u64,
    }

    struct StakingPauseChanged has copy, drop {
        is_paused: bool,
    }

    public fun add_locking_details(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: u64, arg3: &mut LockDetails, arg4: u64, arg5: u64, arg6: u64, arg7: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg7, 1);
        assert!(arg3.is_paused, 7);
        let v0 = CategoryDetails{
            duration            : arg4,
            coin_amount         : arg5,
            rewards_distributed : 0,
            total_rewards       : 0x2::balance::zero<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(),
            total_staked        : 0,
            target_tvl          : arg6,
            currently_locked    : 0,
            stakers             : 0x2::table_vec::empty<address>(arg8),
        };
        0x2::table::add<u64, CategoryDetails>(&mut arg3.locking_details, arg2, v0);
        let v1 = LockingPeriodAdded{
            amount   : arg5,
            period   : arg4,
            category : arg2,
        };
        0x2::event::emit<LockingPeriodAdded>(v1);
    }

    public fun add_rewards_in_category(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut LockDetails, arg2: u64, arg3: 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>, arg4: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg4, 1);
        assert!(arg1.is_paused, 7);
        let v0 = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, arg2);
        0x2::balance::join<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut v0.total_rewards, 0x2::coin::into_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(arg3));
        let v1 = RewardsAdded{
            amount   : 0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&v0.total_rewards),
            category : arg2,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    public fun calculate_apr_and_reward(arg0: u64, arg1: &LockDetails) : (u64, u64) {
        let v0 = 0x2::table::borrow<u64, CategoryDetails>(&arg1.locking_details, arg0);
        let v1 = v0.target_tvl;
        let v2 = v0.coin_amount;
        let v3 = v0.total_staked + v2;
        let v4 = v0.duration / 86400000;
        if (v1 <= v3) {
            return (0, 0)
        };
        let v5 = (((v1 - v3) / 365) as u128) * (v4 as u128) * (v2 as u128) / 10000000000000;
        ((((v5 as u128) * 365 * 100 / ((v4 * v2) as u128)) as u64), (v5 as u64))
    }

    public fun change_pause_status(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut LockDetails, arg2: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg2, 1);
        arg1.is_paused = !arg1.is_paused;
        let v0 = StakingPauseChanged{is_paused: arg1.is_paused};
        0x2::event::emit<StakingPauseChanged>(v0);
    }

    public fun get_category_coin_amount(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).coin_amount
    }

    public fun get_category_currently_locked(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).currently_locked
    }

    public fun get_category_duration(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).duration
    }

    public fun get_category_rewards_distributed(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).rewards_distributed
    }

    public fun get_category_target_tvl(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).target_tvl
    }

    public fun get_category_total_staked(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).total_staked
    }

    public fun get_rewards_in_category(arg0: &LockDetails, arg1: u64) : u64 {
        0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&0x2::table::borrow<u64, CategoryDetails>(&arg0.locking_details, arg1).total_rewards)
    }

    public fun get_rewards_to_claim(arg0: &LockedV) : u64 {
        arg0.rewards_to_claim
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockDetails{
            id              : 0x2::object::new(arg0),
            locking_details : 0x2::table::new<u64, CategoryDetails>(arg0),
            is_paused       : true,
        };
        0x2::transfer::share_object<LockDetails>(v0);
    }

    public fun is_paused(arg0: &LockDetails) : bool {
        arg0.is_paused
    }

    public entry fun lock_tokens(arg0: 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>, arg1: u64, arg2: &mut LockDetails, arg3: &0x2::clock::Clock, arg4: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg4, 1);
        assert!(!arg2.is_paused, 2);
        assert!(0x2::table::contains<u64, CategoryDetails>(&arg2.locking_details, arg1), 8);
        assert!(0x2::table::borrow<u64, CategoryDetails>(&arg2.locking_details, arg1).coin_amount == 0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg0), 9);
        assert!(0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&0x2::table::borrow<u64, CategoryDetails>(&arg2.locking_details, arg1).total_rewards) > 0, 10);
        let v0 = 0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).currently_locked = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).currently_locked + v0;
        0x2::table_vec::push_back<address>(&mut 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).stakers, 0x2::tx_context::sender(arg5));
        let (_, v3) = calculate_apr_and_reward(arg1, arg2);
        0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).total_staked = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).total_staked + v0;
        0x2::coin::join<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg0, 0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg1).total_rewards, v3), arg5));
        let v4 = LockedV{
            id               : 0x2::object::new(arg5),
            amount           : 0x2::coin::into_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(arg0),
            rewards_to_claim : v3,
            locked_for       : v1 + 0x2::table::borrow<u64, CategoryDetails>(&arg2.locking_details, arg1).duration,
            category         : arg1,
        };
        0x2::transfer::transfer<LockedV>(v4, 0x2::tx_context::sender(arg5));
        let v5 = TokensLocked{
            staker           : 0x2::tx_context::sender(arg5),
            amount           : v0,
            locked_for       : v1 + 0x2::table::borrow<u64, CategoryDetails>(&arg2.locking_details, arg1).duration,
            rewards_to_claim : v3,
        };
        0x2::event::emit<TokensLocked>(v5);
    }

    public fun unlock_tokens(arg0: LockedV, arg1: &mut LockDetails, arg2: &0x2::clock::Clock, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(!arg1.is_paused, 2);
        let LockedV {
            id               : v0,
            amount           : v1,
            rewards_to_claim : v2,
            locked_for       : v3,
            category         : v4,
        } = arg0;
        let v5 = v1;
        assert!(0x2::clock::timestamp_ms(arg2) >= v3, 6);
        let v6 = 0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&v5) - v2;
        0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, v4).rewards_distributed = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, v4).rewards_distributed + v2;
        0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, v4).currently_locked = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, v4).currently_locked - v6;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(v5, arg4), 0x2::tx_context::sender(arg4));
        let v7 = TokensUnlocked{
            staker          : 0x2::tx_context::sender(arg4),
            amount          : v6,
            rewards_claimed : v2,
        };
        0x2::event::emit<TokensUnlocked>(v7);
    }

    public fun update_locking_details(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &mut LockDetails, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg7, 1);
        assert!(arg2.is_paused, 7);
        let v0 = 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg2.locking_details, arg3);
        v0.coin_amount = arg4;
        v0.duration = arg5;
        v0.target_tvl = arg6;
        let v1 = LockingPeriodUpdated{
            amount   : arg4,
            period   : arg5,
            category : arg3,
        };
        0x2::event::emit<LockingPeriodUpdated>(v1);
    }

    public fun withdraw_rewards(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut LockDetails, arg2: u64, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(arg1.is_paused, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::withdraw_all<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut 0x2::table::borrow_mut<u64, CategoryDetails>(&mut arg1.locking_details, arg2).total_rewards), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

