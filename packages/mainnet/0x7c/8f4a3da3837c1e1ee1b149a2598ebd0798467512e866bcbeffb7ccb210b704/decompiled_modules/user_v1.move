module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::user_v1 {
    struct CreateEvent has copy, drop, store {
        ve_token_id: address,
        user: address,
        amount: u64,
        unbond_at: u64,
        bond_mode: u8,
        staked: bool,
    }

    struct AddBalanceEvent has copy, drop, store {
        ve_token_id: address,
        user: address,
        add_amount: u64,
    }

    struct ExtendEvent has copy, drop, store {
        ve_token_id: address,
        user: address,
        old_unbond_at: u64,
        new_unbond_at: u64,
    }

    struct ClaimRewardEvent has copy, drop, store {
        ve_token_id: address,
        user: address,
        reward_amount: u64,
    }

    struct MergeEvent has copy, drop, store {
        primary_id: address,
        merged_id: address,
        user: address,
        merged_amount: u64,
    }

    struct SplitEvent has copy, drop, store {
        original_id: address,
        new_id: address,
        user: address,
        split_amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        ve_token_id: address,
        user: address,
        withdraw_amount: u64,
    }

    public fun add_balance(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg3: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg4);
        let v0 = 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg2);
        assert!(v0 > 0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_amount());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::deposit(arg3, arg2);
        if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg3)) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::add_balance(arg1, arg0, v0, arg3, arg4);
        };
        let v1 = AddBalanceEvent{
            ve_token_id : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg3),
            user        : 0x2::tx_context::sender(arg5),
            add_amount  : v0,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<AddBalanceEvent>(v1);
    }

    public fun claim_reward(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg2), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_not_staked());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg3);
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::claim_reward(arg1, arg0, arg2, arg3);
        let v1 = ClaimRewardEvent{
            ve_token_id   : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg4),
            reward_amount : 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&v0),
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<ClaimRewardEvent>(v1);
        v0
    }

    public fun claim_reward_single_epoch(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg2), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_not_staked());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg3);
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::claim_reward_single_epoch(arg1, arg0, arg2, arg3);
        let v1 = ClaimRewardEvent{
            ve_token_id   : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg4),
            reward_amount : 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&v0),
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<ClaimRewardEvent>(v1);
        v0
    }

    public fun extend(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::is_epoch_start(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::ep_config(arg0), arg3), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg4);
        if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg2)) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::extend(arg1, arg0, arg2, arg3, arg4);
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::extend(arg2, arg3, arg4);
        let v0 = ExtendEvent{
            ve_token_id   : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg5),
            old_unbond_at : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2),
            new_unbond_at : arg3,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<ExtendEvent>(v0);
    }

    public fun merge(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg4);
        if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg2) && 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(&arg3)) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::merge(arg1, arg0, arg2, arg3, arg4);
        } else {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::merge(arg2, arg3);
        };
        let v0 = MergeEvent{
            primary_id    : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg2),
            merged_id     : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(&arg3),
            user          : 0x2::tx_context::sender(arg5),
            merged_amount : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(&arg3),
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<MergeEvent>(v0);
    }

    public fun split(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg4);
        let v0 = if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(arg2)) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::split(arg1, arg2, arg3, arg4, arg5)
        } else {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::split(arg2, arg3, arg5)
        };
        let v1 = v0;
        let v2 = SplitEvent{
            original_id  : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(arg2),
            new_id       : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(&v1),
            user         : 0x2::tx_context::sender(arg5),
            split_amount : arg3,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<SplitEvent>(v2);
        v1
    }

    public fun withdraw(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg3);
        let v0 = if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::is_staked(&arg2)) {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::withdraw(arg1, arg2, arg3)
        } else {
            0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::withdraw(arg2, arg3)
        };
        let v1 = WithdrawEvent{
            ve_token_id     : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(&arg2),
            user            : 0x2::tx_context::sender(arg4),
            withdraw_amount : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(&arg2),
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<WithdrawEvent>(v1);
        v0
    }

    public fun create(arg0: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::StakingPool, arg2: u64, arg3: u8, arg4: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::is_epoch_start(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::ep_config(arg0), arg2), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::sync_or_advance_epoch(arg1, arg0, arg5);
        let v0 = 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg4);
        assert!(v0 > 0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_amount());
        let v1 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::create(arg0, arg4, arg2, arg3, true, arg5, arg6);
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool::deposit(arg1, arg0, &mut v1, arg5);
        let v2 = CreateEvent{
            ve_token_id : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(&v1),
            user        : 0x2::tx_context::sender(arg6),
            amount      : v0,
            unbond_at   : arg2,
            bond_mode   : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::bond_mode(&v1),
            staked      : true,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<CreateEvent>(v2);
        v1
    }

    public fun create_without_stake(arg0: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: u64, arg2: u8, arg3: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::version(arg0));
        assert!(!0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::is_paused(arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_paused());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::is_epoch_start(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::ep_config(arg0), arg1), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        let v0 = 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg3);
        assert!(v0 > 0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_amount());
        let v1 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::create(arg0, arg3, arg1, arg2, false, arg4, arg5);
        let v2 = CreateEvent{
            ve_token_id : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::id(&v1),
            user        : 0x2::tx_context::sender(arg5),
            amount      : v0,
            unbond_at   : arg1,
            bond_mode   : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::bond_mode(&v1),
            staked      : false,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<CreateEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

