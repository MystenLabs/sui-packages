module 0x3da7de77901a1b6fb16848665d0139c7799c078cfc759bd9dac999f92f3602a7::staking_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        registered_pools: 0x2::table::Table<address, bool>,
        admin: address,
    }

    struct PendingUserStakeApproval has drop, store {
        requested_by: address,
        user_address: address,
        timestamp: u64,
        approved_by: vector<address>,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        user_stakes: 0x2::table::Table<address, vector<0x3::staking_pool::StakedSui>>,
        user_staked_amounts: 0x2::table::Table<address, u64>,
        user_rewards: 0x2::table::Table<address, u64>,
        user_addresses: vector<address>,
        total_staked: u64,
        total_rewards: u64,
        validator_address: address,
        admins: 0x2::vec_set::VecSet<address>,
        deposits_open: bool,
        created_at: u64,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_fee_percentage: u64,
        total_validator_rewards_claimed: u64,
        total_admin_fees_collected: u64,
        main_admin: address,
        pending_approvals: 0x2::table::Table<address, PendingUserStakeApproval>,
        min_approvals_required: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        total_user_staked: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        remaining_user_staked: u64,
    }

    struct RewardWithdrawEvent has copy, drop {
        user: address,
        reward_amount: u64,
    }

    struct AdminWithdrawUserEvent has copy, drop {
        admin: address,
        user: address,
        amount: u64,
    }

    struct DepositStatusChangedEvent has copy, drop {
        admin: address,
        pool_id: address,
        new_status: bool,
    }

    struct ValidatorUpdatedEvent has copy, drop {
        admin: address,
        pool_id: address,
        old_validator: address,
        new_validator: address,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        admin: address,
        validator_address: address,
    }

    struct PoolRemovedEvent has copy, drop {
        pool_id: address,
        admin: address,
        total_amount_returned: u64,
    }

    struct PoolRegisteredEvent has copy, drop {
        pool_id: address,
        registry_admin: address,
    }

    struct RewardDistributedEvent has copy, drop {
        admin: address,
        pool_id: address,
        total_reward_amount: u64,
        distributed_to_users: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        admin: address,
        pool_id: address,
        total_rewards_claimed: u64,
        admin_fee: u64,
        distributed_to_users: u64,
    }

    struct AdminFeeWithdrawnEvent has copy, drop {
        admin: address,
        pool_id: address,
        fee_amount: u64,
    }

    struct FeePercentageUpdatedEvent has copy, drop {
        admin: address,
        pool_id: address,
        old_percentage: u64,
        new_percentage: u64,
    }

    struct UserStakeConfigRequestedEvent has copy, drop {
        requested_by: address,
        user_address: address,
        pool_id: address,
    }

    struct UserStakeConfigApprovedEvent has copy, drop {
        approved_by: address,
        user_address: address,
        pool_id: address,
        total_approvals: u64,
    }

    struct UserStakeConfigExecutedEvent has copy, drop {
        main_admin: address,
        user_address: address,
        amount_withdrawn: u64,
        approvers: vector<address>,
    }

    struct UserStakeConfigCancelledEvent has copy, drop {
        cancelled_by: address,
        user_address: address,
        originally_requested_by: address,
        pool_id: address,
    }

    struct MainAdminTransferredEvent has copy, drop {
        old_main_admin: address,
        new_main_admin: address,
        pool_id: address,
    }

    struct EmergencyAdminRestoredEvent has copy, drop {
        restored_by: address,
        new_admin: address,
        pool_id: address,
    }

    struct EmergencyUserWithdrawalEvent has copy, drop {
        user: address,
        amount_withdrawn: u64,
        pool_id: address,
    }

    public entry fun add_admin(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
        let v0 = ValidatorUpdatedEvent{
            admin         : 0x2::tx_context::sender(arg3),
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            old_validator : @0x0,
            new_validator : arg2,
        };
        0x2::event::emit<ValidatorUpdatedEvent>(v0);
    }

    public entry fun approve_user_stake_config(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2), 13);
        let v1 = 0x2::table::borrow_mut<address, PendingUserStakeApproval>(&mut arg0.pending_approvals, arg2);
        assert!(v1.requested_by != v0, 14);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1.approved_by)) {
            assert!(*0x1::vector::borrow<address>(&v1.approved_by, v2) != v0, 14);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<address>(&mut v1.approved_by, v0);
        let v3 = UserStakeConfigApprovedEvent{
            approved_by     : v0,
            user_address    : arg2,
            pool_id         : 0x2::object::uid_to_address(&arg0.id),
            total_approvals : 0x1::vector::length<address>(&v1.approved_by),
        };
        0x2::event::emit<UserStakeConfigApprovedEvent>(v3);
    }

    public fun calculate_admin_fee(arg0: &StakingPool, arg1: u64) : u64 {
        arg1 * arg0.admin_fee_percentage / 10000
    }

    public fun calculate_user_reward_for_amount(arg0: &StakingPool, arg1: address, arg2: u64) : u64 {
        if (arg0.total_staked == 0 || !0x2::table::contains<address, u64>(&arg0.user_staked_amounts, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, arg1) * arg2 / arg0.total_staked
    }

    public entry fun cancel_user_stake_config_request(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2), 13);
        assert!(v0 == 0x2::table::borrow<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2).requested_by || v0 == arg0.main_admin, 4);
        let v1 = 0x2::table::remove<address, PendingUserStakeApproval>(&mut arg0.pending_approvals, arg2);
        let v2 = UserStakeConfigCancelledEvent{
            cancelled_by            : v0,
            user_address            : arg2,
            originally_requested_by : v1.requested_by,
            pool_id                 : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<UserStakeConfigCancelledEvent>(v2);
    }

    public entry fun claim_and_distribute_validator_rewards(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::balance::Balance<0x2::sui::SUI>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.user_addresses)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.user_addresses, v2);
            if (0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, v3)) {
                let v4 = 0x2::table::borrow_mut<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x3::staking_pool::StakedSui>(v4)) {
                    let v6 = 0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(v4, v5));
                    let v7 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x1::vector::remove<0x3::staking_pool::StakedSui>(v4, v5), arg3);
                    let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
                    let v9 = if (v8 > v6) {
                        v8 - v6
                    } else {
                        0
                    };
                    v0 = v0 + v9;
                    if (v9 > 0) {
                        0x1::vector::push_back<0x2::balance::Balance<0x2::sui::SUI>>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v9));
                    };
                    0x1::vector::insert<0x3::staking_pool::StakedSui>(v4, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg3), arg0.validator_address, arg3), v5);
                    v5 = v5 + 1;
                };
            };
            v2 = v2 + 1;
        };
        if (v0 > 0) {
            let v10 = v0 * arg0.admin_fee_percentage / 10000;
            let v11 = v0 - v10;
            let v12 = 0x2::balance::zero<0x2::sui::SUI>();
            while (!0x1::vector::is_empty<0x2::balance::Balance<0x2::sui::SUI>>(&v1)) {
                0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x1::vector::pop_back<0x2::balance::Balance<0x2::sui::SUI>>(&mut v1));
            };
            let v13 = if (v10 > 0) {
                0x2::balance::split<0x2::sui::SUI>(&mut v12, v10)
            } else {
                0x2::balance::zero<0x2::sui::SUI>()
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, v13);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, v12);
            if (arg0.total_staked > 0 && v11 > 0) {
                let v14 = 0;
                while (v14 < 0x1::vector::length<address>(&arg0.user_addresses)) {
                    let v15 = *0x1::vector::borrow<address>(&arg0.user_addresses, v14);
                    if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v15)) {
                        let v16 = *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, v15);
                        if (v16 > 0) {
                            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_rewards, v15) = *0x2::table::borrow<address, u64>(&arg0.user_rewards, v15) + v16 * v11 / arg0.total_staked;
                        };
                    };
                    v14 = v14 + 1;
                };
            };
            arg0.total_validator_rewards_claimed = arg0.total_validator_rewards_claimed + v0;
            arg0.total_rewards = arg0.total_rewards + v0;
            let v17 = FeeCollectedEvent{
                admin                 : 0x2::tx_context::sender(arg3),
                pool_id               : 0x2::object::uid_to_address(&arg0.id),
                total_rewards_claimed : v0,
                admin_fee             : v10,
                distributed_to_users  : v11,
            };
            0x2::event::emit<FeeCollectedEvent>(v17);
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<0x2::sui::SUI>>(v1);
    }

    public entry fun collect_admin_fees(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= arg2, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        arg0.total_admin_fees_collected = arg0.total_admin_fees_collected + arg2;
        let v0 = AdminFeeWithdrawnEvent{
            admin      : 0x2::tx_context::sender(arg3),
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            fee_amount : arg2,
        };
        0x2::event::emit<AdminFeeWithdrawnEvent>(v0);
    }

    public entry fun config_user_stakes(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.main_admin, 12);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        let v1 = 0x1::vector::empty<address>();
        if (0x2::vec_set::size<address>(&arg0.admins) > 1) {
            assert!(0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2), 13);
            assert!(0x1::vector::length<address>(&0x2::table::borrow<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2).approved_by) >= arg0.min_approvals_required, 13);
            let v2 = 0x2::table::remove<address, PendingUserStakeApproval>(&mut arg0.pending_approvals, arg2);
            v1 = v2.approved_by;
        };
        if (!0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, arg2)) {
            let v3 = UserStakeConfigExecutedEvent{
                main_admin       : v0,
                user_address     : arg2,
                amount_withdrawn : 0,
                approvers        : v1,
            };
            0x2::event::emit<UserStakeConfigExecutedEvent>(v3);
            return
        };
        let v4 = 0x2::table::remove<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, arg2);
        let v5 = if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.user_staked_amounts, arg2)
        } else {
            0
        };
        if (0x2::table::contains<address, u64>(&arg0.user_rewards, arg2)) {
            arg0.total_rewards = arg0.total_rewards - 0x2::table::remove<address, u64>(&mut arg0.user_rewards, arg2);
        };
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg0.user_addresses)) {
            if (*0x1::vector::borrow<address>(&arg0.user_addresses, v6) == arg2) {
                0x1::vector::remove<address>(&mut arg0.user_addresses, v6);
                break
            };
            v6 = v6 + 1;
        };
        let v7 = 0;
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&v4)) {
            let v8 = 0x3::sui_system::request_withdraw_stake_non_entry(arg3, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v4), arg4);
            v7 = v7 + 0x2::balance::value<0x2::sui::SUI>(&v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg4), v0);
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v4);
        arg0.total_staked = arg0.total_staked - v5;
        let v9 = UserStakeConfigExecutedEvent{
            main_admin       : v0,
            user_address     : arg2,
            amount_withdrawn : v7,
            approvers        : v1,
        };
        0x2::event::emit<UserStakeConfigExecutedEvent>(v9);
    }

    public entry fun create_pool_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id               : 0x2::object::new(arg0),
            registered_pools : 0x2::table::new<address, bool>(arg0),
            admin            : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public entry fun create_staking_pool(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x18f931885d2108e61261833ba1c93057007c4b1c898d3efb01bcea8ca38e129c, 4);
        assert!(arg1 <= 1000, 11);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = StakingPool{
            id                              : 0x2::object::new(arg3),
            user_stakes                     : 0x2::table::new<address, vector<0x3::staking_pool::StakedSui>>(arg3),
            user_staked_amounts             : 0x2::table::new<address, u64>(arg3),
            user_rewards                    : 0x2::table::new<address, u64>(arg3),
            user_addresses                  : 0x1::vector::empty<address>(),
            total_staked                    : 0,
            total_rewards                   : 0,
            validator_address               : arg0,
            admins                          : v1,
            deposits_open                   : false,
            created_at                      : 0x2::tx_context::epoch(arg3),
            reward_balance                  : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_fee_percentage            : arg1,
            total_validator_rewards_claimed : 0,
            total_admin_fees_collected      : 0,
            main_admin                      : v0,
            pending_approvals               : 0x2::table::new<address, PendingUserStakeApproval>(arg3),
            min_approvals_required          : arg2,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        let v4 = AdminCap{
            id      : 0x2::object::new(arg3),
            pool_id : v3,
        };
        let v5 = PoolCreatedEvent{
            pool_id           : v3,
            admin             : v0,
            validator_address : arg0,
        };
        0x2::event::emit<PoolCreatedEvent>(v5);
        0x2::transfer::public_transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<StakingPool>(v2);
    }

    public entry fun deposit(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_open, 8);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, v1)
        } else {
            0
        };
        let v3 = v2 + v0;
        if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_staked_amounts, v1) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_staked_amounts, v1, v3);
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_rewards, v1)) {
            0x2::table::add<address, u64>(&mut arg0.user_rewards, v1, 0);
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v1)) {
            0x1::vector::push_back<address>(&mut arg0.user_addresses, v1);
        };
        if (0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, v1)) {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(0x2::table::borrow_mut<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v1), 0x3::sui_system::request_add_stake_non_entry(arg2, arg1, arg0.validator_address, arg3));
        } else {
            let v4 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v4, 0x3::sui_system::request_add_stake_non_entry(arg2, arg1, arg0.validator_address, arg3));
            0x2::table::add<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v1, v4);
        };
        arg0.total_staked = arg0.total_staked + v0;
        let v5 = DepositEvent{
            user              : v1,
            amount            : v0,
            total_user_staked : v3,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public entry fun deposit_rewards(arg0: &mut StakingPool, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (arg0.total_staked > 0) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg0.user_addresses)) {
                let v2 = *0x1::vector::borrow<address>(&arg0.user_addresses, v1);
                if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v2)) {
                    let v3 = *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, v2);
                    if (v3 > 0) {
                        *0x2::table::borrow_mut<address, u64>(&mut arg0.user_rewards, v2) = *0x2::table::borrow<address, u64>(&arg0.user_rewards, v2) + v3 * v0 / arg0.total_staked;
                    };
                };
                v1 = v1 + 1;
            };
        };
        arg0.total_rewards = arg0.total_rewards + v0;
        let v4 = RewardDistributedEvent{
            admin                : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::uid_to_address(&arg0.id),
            total_reward_amount  : v0,
            distributed_to_users : 0x1::vector::length<address>(&arg0.user_addresses),
        };
        0x2::event::emit<RewardDistributedEvent>(v4);
    }

    public entry fun emergency_restore_admin(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x18f931885d2108e61261833ba1c93057007c4b1c898d3efb01bcea8ca38e129c, 4);
        assert!(0x2::vec_set::size<address>(&arg0.admins) == 0, 4);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        arg0.main_admin = arg1;
        let v0 = EmergencyAdminRestoredEvent{
            restored_by : 0x2::tx_context::sender(arg2),
            new_admin   : arg1,
            pool_id     : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<EmergencyAdminRestoredEvent>(v0);
    }

    public entry fun emergency_user_withdrawal(arg0: &mut StakingPool, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::size<address>(&arg0.admins) == 0, 4);
        assert!(!arg0.deposits_open, 8);
        assert!(0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, v0), 5);
        let v1 = 0x2::table::remove<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v0);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.user_staked_amounts, v0)
        } else {
            0
        };
        if (0x2::table::contains<address, u64>(&arg0.user_rewards, v0)) {
            arg0.total_rewards = arg0.total_rewards - 0x2::table::remove<address, u64>(&mut arg0.user_rewards, v0);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0.user_addresses)) {
            if (*0x1::vector::borrow<address>(&arg0.user_addresses, v3) == v0) {
                0x1::vector::remove<address>(&mut arg0.user_addresses, v3);
                break
            };
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&v1)) {
            let v5 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v1), arg2);
            v4 = v4 + 0x2::balance::value<0x2::sui::SUI>(&v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg2), v0);
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v1);
        arg0.total_staked = arg0.total_staked - v2;
        let v6 = EmergencyUserWithdrawalEvent{
            user             : v0,
            amount_withdrawn : v4,
            pool_id          : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<EmergencyUserWithdrawalEvent>(v6);
    }

    public fun get_admin_count(arg0: &StakingPool) : u64 {
        0x2::vec_set::size<address>(&arg0.admins)
    }

    public fun get_admin_fee_percentage(arg0: &StakingPool) : u64 {
        arg0.admin_fee_percentage
    }

    public fun get_admins(arg0: &StakingPool) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.admins)
    }

    public fun get_all_users(arg0: &StakingPool) : vector<address> {
        arg0.user_addresses
    }

    public fun get_approval_status(arg0: &StakingPool, arg1: address) : (bool, u64, u64) {
        if (0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1)) {
            let v3 = 0x1::vector::length<address>(&0x2::table::borrow<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1).approved_by);
            (v3 >= arg0.min_approvals_required, v3, arg0.min_approvals_required)
        } else {
            (false, 0, arg0.min_approvals_required)
        }
    }

    public fun get_available_admin_fees(arg0: &StakingPool) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance);
        let v1 = arg0.total_rewards;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun get_fee_statistics(arg0: &StakingPool) : (u64, u64) {
        (arg0.total_validator_rewards_claimed, arg0.total_admin_fees_collected)
    }

    public fun get_main_admin(arg0: &StakingPool) : address {
        arg0.main_admin
    }

    public fun get_min_approvals_required(arg0: &StakingPool) : u64 {
        arg0.min_approvals_required
    }

    public fun get_pending_approval(arg0: &StakingPool, arg1: address) : (bool, address, u64, vector<address>) {
        if (0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1)) {
            let v4 = 0x2::table::borrow<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1);
            (true, v4.requested_by, v4.timestamp, v4.approved_by)
        } else {
            (false, @0x0, 0, 0x1::vector::empty<address>())
        }
    }

    public fun get_pending_approvals_count(arg0: &StakingPool) : u64 {
        0
    }

    public fun get_pool_creation_time(arg0: &StakingPool) : u64 {
        arg0.created_at
    }

    public fun get_pool_id(arg0: &StakingPool) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_pool_stats(arg0: &StakingPool) : (u64, u64) {
        (arg0.total_staked, arg0.total_rewards)
    }

    public fun get_reward_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance)
    }

    public fun get_total_users(arg0: &StakingPool) : u64 {
        0x1::vector::length<address>(&arg0.user_addresses)
    }

    public fun get_user_reward_share(arg0: &StakingPool, arg1: address) : u64 {
        if (arg0.total_staked == 0 || !0x2::table::contains<address, u64>(&arg0.user_staked_amounts, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, arg1) * 10000 / arg0.total_staked
    }

    public fun get_user_rewards(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_rewards, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_user_stake_count(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, arg1)) {
            0x1::vector::length<0x3::staking_pool::StakedSui>(0x2::table::borrow<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, arg1))
        } else {
            0
        }
    }

    public fun get_user_staked_balance(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, arg1)
        } else {
            0
        }
    }

    public fun get_validator_address(arg0: &StakingPool) : address {
        arg0.validator_address
    }

    public fun has_admin_approved(arg0: &StakingPool, arg1: address, arg2: address) : bool {
        if (0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1)) {
            let v1 = 0x2::table::borrow<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&v1.approved_by)) {
                if (*0x1::vector::borrow<address>(&v1.approved_by, v2) == arg2) {
                    return true
                };
                v2 = v2 + 1;
            };
            false
        } else {
            false
        }
    }

    public fun has_admins(arg0: &StakingPool) : bool {
        0x2::vec_set::size<address>(&arg0.admins) > 0
    }

    public fun has_pending_approval(arg0: &StakingPool, arg1: address) : bool {
        0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg1)
    }

    public fun is_admin(arg0: &StakingPool, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_deposits_open(arg0: &StakingPool) : bool {
        arg0.deposits_open
    }

    public fun is_pool_admin(arg0: &StakingPool, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_pool_registered(arg0: &PoolRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.registered_pools, arg1)
    }

    public entry fun register_pool(arg0: &mut PoolRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        0x2::table::add<address, bool>(&mut arg0.registered_pools, arg1, true);
        let v0 = PoolRegisteredEvent{
            pool_id        : arg1,
            registry_admin : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolRegisteredEvent>(v0);
    }

    public entry fun remove_admin(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        let v0 = 0x2::vec_set::size<address>(&arg0.admins);
        if (v0 == 1) {
            assert!(arg2 != arg0.main_admin, 16);
        };
        if (arg2 == arg0.main_admin && v0 > 1) {
            abort 17
        };
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        let v1 = ValidatorUpdatedEvent{
            admin         : 0x2::tx_context::sender(arg3),
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            old_validator : arg2,
            new_validator : @0x0,
        };
        0x2::event::emit<ValidatorUpdatedEvent>(v1);
    }

    public entry fun remove_pool(arg0: StakingPool, arg1: AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(&arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        let StakingPool {
            id                              : v0,
            user_stakes                     : v1,
            user_staked_amounts             : v2,
            user_rewards                    : v3,
            user_addresses                  : _,
            total_staked                    : _,
            total_rewards                   : _,
            validator_address               : _,
            admins                          : _,
            deposits_open                   : _,
            created_at                      : _,
            reward_balance                  : v11,
            admin_fee_percentage            : _,
            total_validator_rewards_claimed : _,
            total_admin_fees_collected      : _,
            main_admin                      : _,
            pending_approvals               : v16,
            min_approvals_required          : _,
        } = arg0;
        let v18 = v11;
        let v19 = v0;
        let v20 = 0x2::tx_context::sender(arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v18, arg3), v20);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v18);
        };
        0x2::table::destroy_empty<address, PendingUserStakeApproval>(v16);
        0x2::table::destroy_empty<address, vector<0x3::staking_pool::StakedSui>>(v1);
        0x2::table::destroy_empty<address, u64>(v2);
        0x2::table::destroy_empty<address, u64>(v3);
        let v21 = PoolRemovedEvent{
            pool_id               : 0x2::object::uid_to_address(&v19),
            admin                 : v20,
            total_amount_returned : 0,
        };
        0x2::event::emit<PoolRemovedEvent>(v21);
        0x2::object::delete(v19);
        let AdminCap {
            id      : v22,
            pool_id : _,
        } = arg1;
        0x2::object::delete(v22);
    }

    public entry fun request_user_stake_config_approval(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(!0x2::table::contains<address, PendingUserStakeApproval>(&arg0.pending_approvals, arg2), 15);
        let v1 = PendingUserStakeApproval{
            requested_by : v0,
            user_address : arg2,
            timestamp    : 0x2::tx_context::epoch(arg3),
            approved_by  : 0x1::vector::empty<address>(),
        };
        0x2::table::add<address, PendingUserStakeApproval>(&mut arg0.pending_approvals, arg2, v1);
        let v2 = UserStakeConfigRequestedEvent{
            requested_by : v0,
            user_address : arg2,
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<UserStakeConfigRequestedEvent>(v2);
    }

    public entry fun toggle_deposits(arg0: &mut StakingPool, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        if (arg0.deposits_open == arg2) {
            return
        };
        arg0.deposits_open = arg2;
        let v0 = DepositStatusChangedEvent{
            admin      : 0x2::tx_context::sender(arg3),
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            new_status : arg2,
        };
        0x2::event::emit<DepositStatusChangedEvent>(v0);
    }

    public entry fun transfer_main_admin(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.main_admin, 12);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(is_admin(arg0, arg2), 4);
        arg0.main_admin = arg2;
        let v0 = MainAdminTransferredEvent{
            old_main_admin : arg0.main_admin,
            new_main_admin : arg2,
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<MainAdminTransferredEvent>(v0);
    }

    public entry fun update_admin_fee_percentage(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(arg2 <= 1000, 11);
        arg0.admin_fee_percentage = arg2;
        let v0 = FeePercentageUpdatedEvent{
            admin          : 0x2::tx_context::sender(arg3),
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
            old_percentage : arg0.admin_fee_percentage,
            new_percentage : arg2,
        };
        0x2::event::emit<FeePercentageUpdatedEvent>(v0);
    }

    public entry fun update_validator_address(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        assert!(arg1.pool_id == 0x2::object::uid_to_address(&arg0.id), 9);
        arg0.validator_address = arg2;
        let v0 = ValidatorUpdatedEvent{
            admin         : 0x2::tx_context::sender(arg3),
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            old_validator : arg0.validator_address,
            new_validator : arg2,
        };
        0x2::event::emit<ValidatorUpdatedEvent>(v0);
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, v0), 5);
        assert!(0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v0), 5);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, v0);
        assert!(arg1 <= v1, 7);
        let v2 = 0x2::table::borrow_mut<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v0);
        let v3 = arg1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x3::staking_pool::StakedSui>(v2) && arg1 > 0) {
            0x1::vector::push_back<u64>(&mut v6, v7);
            v7 = v7 + 1;
        };
        0x1::vector::reverse<u64>(&mut v6);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v6) && v3 > 0) {
            let v9 = 0x1::vector::remove<0x3::staking_pool::StakedSui>(v2, *0x1::vector::borrow<u64>(&v6, v8));
            let v10 = 0x3::staking_pool::staked_sui_amount(&v9);
            let v11 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, v9, arg3);
            let v12 = 0x2::balance::value<0x2::sui::SUI>(&v11);
            let v13 = if (v12 > v10) {
                v12 - v10
            } else {
                0
            };
            v5 = v5 + v13;
            let v14 = if (v10 <= v3) {
                v10
            } else {
                v3
            };
            if (v10 > v3) {
                let v15 = v10 - v3;
                if (v15 >= 1000000000) {
                    0x1::vector::push_back<0x3::staking_pool::StakedSui>(v2, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v15 + v13), arg3), arg0.validator_address, arg3));
                } else {
                    v3 = v10;
                };
            };
            v4 = v4 + v14;
            v3 = v3 - v14;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg3), v0);
            v8 = v8 + 1;
        };
        let v16 = v1 - v4;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.user_staked_amounts, v0) = v16;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.user_rewards, v0) = *0x2::table::borrow<address, u64>(&arg0.user_rewards, v0) + v5;
        arg0.total_staked = arg0.total_staked - v4;
        arg0.total_rewards = arg0.total_rewards + v5;
        let v17 = WithdrawEvent{
            user                  : v0,
            amount                : v4,
            remaining_user_staked : v16,
        };
        0x2::event::emit<WithdrawEvent>(v17);
    }

    public entry fun withdraw_rewards(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.user_rewards, v0), 10);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_rewards, v0);
        assert!(v1 > 0, 10);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= v1, 10);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.user_rewards, v0) = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v1), arg1), v0);
        arg0.total_rewards = arg0.total_rewards - v1;
        let v2 = RewardWithdrawEvent{
            user          : v0,
            reward_amount : v1,
        };
        0x2::event::emit<RewardWithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

