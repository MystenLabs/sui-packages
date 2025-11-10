module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::user_v1 {
    struct CreateEvent has copy, drop {
        ve_token_id: address,
        user: address,
        amount: u64,
        unbond_at: u64,
        bond_mode: u8,
        staked: bool,
    }

    struct AddBalanceEvent has copy, drop {
        ve_token_id: address,
        user: address,
        add_amount: u64,
    }

    struct ExtendEvent has copy, drop {
        ve_token_id: address,
        user: address,
        old_unbond_at: u64,
        new_unbond_at: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        ve_token_id: address,
        user: address,
        reward_amount: u64,
    }

    struct MergeEvent has copy, drop {
        primary_id: address,
        merged_id: address,
        user: address,
        merged_amount: u64,
    }

    struct SplitEvent has copy, drop {
        original_id: address,
        new_id: address,
        user: address,
        split_amount: u64,
    }

    struct DepositEvent has copy, drop {
        ve_token_id: address,
        user: address,
        deposit_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        ve_token_id: address,
        user: address,
        withdraw_amount: u64,
    }

    struct UnbondEvent has copy, drop {
        ve_token_id: address,
        user: address,
        unbond_amount: u64,
    }

    struct SetMaxBondEvent has copy, drop {
        ve_token_id: address,
        balance_before: u64,
        bond_mode_before: u8,
        bond_mode_after: u8,
        unbond_at_before: u64,
        unbond_at_after: u64,
        user: address,
    }

    struct SetNormalEvent has copy, drop {
        ve_token_id: address,
        balance_before: u64,
        bond_mode_before: u8,
        bond_mode_after: u8,
        unbond_at_before: u64,
        unbond_at_after: u64,
        user: address,
    }

    public fun claim_reward(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_not_staked());
        let v0 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::claim_reward(arg1, arg0, arg2, arg3);
        let v1 = ClaimRewardEvent{
            ve_token_id   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg4),
            reward_amount : 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&v0),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<ClaimRewardEvent>(v1);
        v0
    }

    public fun claim_reward_single_epoch(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_not_staked());
        let v0 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::claim_reward_single_epoch(arg1, arg0, arg2, arg3);
        let v1 = ClaimRewardEvent{
            ve_token_id   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg4),
            reward_amount : 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&v0),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<ClaimRewardEvent>(v1);
        v0
    }

    public fun deposit(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg3);
        let v0 = DepositEvent{
            ve_token_id    : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            user           : 0x2::tx_context::sender(arg4),
            deposit_amount : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::balance(arg2),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<DepositEvent>(v0);
    }

    public fun withdraw(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode(arg2) == 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode_normal(), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_bond_mode());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg3);
        let v0 = WithdrawEvent{
            ve_token_id     : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            user            : 0x2::tx_context::sender(arg4),
            withdraw_amount : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::balance(arg2),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<WithdrawEvent>(v0);
    }

    public fun add_balance(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg3: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let v0 = 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg2);
        assert!(v0 > 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_amount());
        if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg3)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg3, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::deposit(arg3, arg2);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg3, arg4);
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::deposit(arg3, arg2);
        };
        let v1 = AddBalanceEvent{
            ve_token_id : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg3),
            user        : 0x2::tx_context::sender(arg5),
            add_amount  : v0,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<AddBalanceEvent>(v1);
    }

    public fun create(arg0: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: u64, arg2: u8, arg3: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let v0 = 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg3);
        assert!(v0 > 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_amount());
        let v1 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::create(arg0, arg3, arg1, arg2, arg4, arg5);
        let v2 = CreateEvent{
            ve_token_id : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(&v1),
            user        : 0x2::tx_context::sender(arg5),
            amount      : v0,
            unbond_at   : arg1,
            bond_mode   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode(&v1),
            staked      : false,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<CreateEvent>(v2);
        v1
    }

    public fun create_with_stake(arg0: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: u64, arg3: u8, arg4: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let v0 = 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg4);
        assert!(v0 > 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_amount());
        let v1 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::create(arg0, arg4, arg2, arg3, arg5, arg6);
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, &mut v1, arg5);
        let v2 = CreateEvent{
            ve_token_id : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(&v1),
            user        : 0x2::tx_context::sender(arg6),
            amount      : v0,
            unbond_at   : arg2,
            bond_mode   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode(&v1),
            staked      : true,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<CreateEvent>(v2);
        v1
    }

    public fun extend(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch::is_epoch_start(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::ep_config(arg0), arg3), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_unbond_at());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode(arg2) == 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode_normal(), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_bond_mode());
        if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::extend(arg2, arg0, arg3, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg4);
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::extend(arg2, arg0, arg3, arg4);
        };
        let v0 = ExtendEvent{
            ve_token_id   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            user          : 0x2::tx_context::sender(arg5),
            old_unbond_at : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::unbond_at(arg2),
            new_unbond_at : arg3,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<ExtendEvent>(v0);
    }

    public fun merge(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2) == 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(&arg3), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_merge());
        if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, &mut arg3, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::merge(arg2, arg3);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg4);
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::merge(arg2, arg3);
        };
        let v0 = MergeEvent{
            primary_id    : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            merged_id     : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(&arg3),
            user          : 0x2::tx_context::sender(arg5),
            merged_amount : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::balance(&arg3),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<MergeEvent>(v0);
    }

    public fun set_max_bond(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let (v0, v1, v2) = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_info(arg2);
        if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg3);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::set_max_bond(arg2);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg3);
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::set_max_bond(arg2);
        };
        let (_, v4, v5) = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_info(arg2);
        let v6 = SetMaxBondEvent{
            ve_token_id      : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            balance_before   : v0,
            bond_mode_before : v1,
            bond_mode_after  : v4,
            unbond_at_before : v2,
            unbond_at_after  : v5,
            user             : 0x2::tx_context::sender(arg4),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SetMaxBondEvent>(v6);
    }

    public fun set_normal(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let (v0, v1, v2) = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_info(arg2);
        if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg3);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::set_normal(arg2, arg0, arg3);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg3);
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::set_normal(arg2, arg0, arg3);
        };
        let (_, v4, v5) = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_info(arg2);
        let v6 = SetNormalEvent{
            ve_token_id      : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            balance_before   : v0,
            bond_mode_before : v1,
            bond_mode_after  : v4,
            unbond_at_before : v2,
            unbond_at_after  : v5,
            user             : 0x2::tx_context::sender(arg4),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SetNormalEvent>(v6);
    }

    public fun split(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        let v0 = if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, arg2, arg4);
            let v1 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::split(arg2, arg3, arg5);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, arg2, arg4);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::deposit(arg1, arg0, &mut v1, arg4);
            v1
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::split(arg2, arg3, arg5)
        };
        let v2 = v0;
        let v3 = SplitEvent{
            original_id  : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(arg2),
            new_id       : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(&v2),
            user         : 0x2::tx_context::sender(arg5),
            split_amount : arg3,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SplitEvent>(v3);
        v2
    }

    public fun unbond(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode(&arg2) == 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode_normal(), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_bond_mode());
        let v0 = if (0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::is_ve_staked(&arg2)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::withdraw(arg1, arg0, &mut arg2, arg3);
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::unbond(arg2, arg3)
        } else {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::unbond(arg2, arg3)
        };
        let v1 = v0;
        let v2 = UnbondEvent{
            ve_token_id   : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::id(&arg2),
            user          : 0x2::tx_context::sender(arg4),
            unbond_amount : 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&v1),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<UnbondEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

