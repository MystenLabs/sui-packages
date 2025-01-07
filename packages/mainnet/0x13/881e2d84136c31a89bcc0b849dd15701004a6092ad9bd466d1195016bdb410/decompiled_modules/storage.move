module 0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::storage {
    struct ProcessingState has store {
        is_totals_calculating: bool,
        total_sui_amount: u64,
        total_rewards_amount: u64,
        pool_id_opt: 0x1::option::Option<0x2::object::ID>,
        stake_number: u64,
        is_sorting_processing: bool,
        inactive_pools_amount: u64,
    }

    struct StorageStateV1 has store, key {
        id: 0x2::object::UID,
        stakes: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>,
        unstaking_deque: 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::LinkedSet<0x2::object::ID>,
        inactive_pools_amount: u64,
        sorting_sandbox: vector<0x2::object::ID>,
        sorting_keys: vector<u64>,
        processing_state: ProcessingState,
        is_sandbox_sorted: bool,
    }

    struct Storage has store {
        id: 0x2::object::UID,
    }

    fun borrow_state(arg0: &Storage) : &StorageStateV1 {
        0x2::dynamic_object_field::borrow<u64, StorageStateV1>(&arg0.id, 0)
    }

    fun borrow_state_mut(arg0: &mut Storage) : &mut StorageStateV1 {
        0x2::dynamic_object_field::borrow_mut<u64, StorageStateV1>(&mut arg0.id, 0)
    }

    public(friend) fun calculate_total_amounts(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut u64) : (bool, u64, u64) {
        let v0 = borrow_state_mut(arg0);
        if (!v0.processing_state.is_totals_calculating) {
            v0.processing_state.is_totals_calculating = true;
            v0.processing_state.total_sui_amount = 0;
            v0.processing_state.total_rewards_amount = 0;
            v0.processing_state.stake_number = 0;
            v0.processing_state.pool_id_opt = *0x2::linked_table::front<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&v0.stakes);
        };
        while (*arg4 < arg3 && 0x1::option::is_some<0x2::object::ID>(&v0.processing_state.pool_id_opt)) {
            let v1 = *0x1::option::borrow<0x2::object::ID>(&v0.processing_state.pool_id_opt);
            *arg4 = *arg4 + 1;
            let (v2, v3, v4, v5) = calculate_total_pool_amounts(0x2::linked_table::borrow<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&v0.stakes, v1), arg1, arg2, arg3, arg4, v0.processing_state.stake_number);
            v0.processing_state.total_sui_amount = v0.processing_state.total_sui_amount + v3;
            v0.processing_state.total_rewards_amount = v0.processing_state.total_rewards_amount + v4;
            v0.processing_state.stake_number = v5;
            if (!v2) {
                break
            };
            v0.processing_state.pool_id_opt = *0x2::linked_table::next<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&v0.stakes, v1);
        };
        if (!0x1::option::is_some<0x2::object::ID>(&v0.processing_state.pool_id_opt)) {
            v0.processing_state.is_totals_calculating = false;
            return (true, v0.processing_state.total_sui_amount, v0.processing_state.total_rewards_amount)
        };
        (false, 0, 0)
    }

    fun calculate_total_pool_amounts(arg0: &0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: &mut u64, arg5: u64) : (bool, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (*arg4 < arg3 && arg5 < 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg0)) {
            let v2 = 0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg0, arg5);
            let v3 = 0x8e6adb40c50cf2ce81d7dd12d240fb881df715343ab61233124aadb87a9fd1fd::sui_system_utils::calculate_rewards_at_epoch(arg1, v2, arg2);
            v0 = v0 + v3;
            let v4 = v1 + 0x3::staking_pool::staked_sui_amount(v2);
            v1 = v4 + v3;
            arg5 = arg5 + 1;
            *arg4 = *arg4 + 3;
        };
        if (arg5 == 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg0)) {
            return (true, v1, v0, 0)
        };
        (false, v1, v0, arg5)
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Storage {
        let v0 = Storage{id: 0x2::object::new(arg0)};
        let v1 = ProcessingState{
            is_totals_calculating : false,
            total_sui_amount      : 0,
            total_rewards_amount  : 0,
            pool_id_opt           : 0x1::option::none<0x2::object::ID>(),
            stake_number          : 0,
            is_sorting_processing : false,
            inactive_pools_amount : 0,
        };
        let v2 = StorageStateV1{
            id                    : 0x2::object::new(arg0),
            stakes                : 0x2::linked_table::new<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(arg0),
            unstaking_deque       : 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::empty<0x2::object::ID>(arg0),
            inactive_pools_amount : 0,
            sorting_sandbox       : 0x1::vector::empty<0x2::object::ID>(),
            sorting_keys          : 0x1::vector::empty<u64>(),
            processing_state      : v1,
            is_sandbox_sorted     : false,
        };
        0x2::dynamic_object_field::add<u64, StorageStateV1>(&mut v0.id, 0, v2);
        v0
    }

    fun is_pool_empty(arg0: &StorageStateV1, arg1: 0x2::object::ID) : bool {
        0x2::table_vec::is_empty<0x3::staking_pool::StakedSui>(0x2::linked_table::borrow<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&arg0.stakes, arg1))
    }

    fun move_sorting_sandbox_to_unstaking_deque(arg0: &mut StorageStateV1, arg1: u64, arg2: &mut u64) : bool {
        while (*arg2 < arg1 && !0x1::vector::is_empty<0x2::object::ID>(&arg0.sorting_sandbox)) {
            0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_back<0x2::object::ID>(&mut arg0.unstaking_deque, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.sorting_sandbox));
            *arg2 = *arg2 + 1;
        };
        if (0x1::vector::is_empty<0x2::object::ID>(&arg0.sorting_sandbox)) {
            return true
        };
        false
    }

    fun move_unstaking_deque_to_sorting_sandbox_and_calc_keys(arg0: &mut StorageStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut u64) : bool {
        while (*arg5 < arg4 && !0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::is_empty<0x2::object::ID>(&arg0.unstaking_deque)) {
            let v0 = 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::pop_back<0x2::object::ID>(&mut arg0.unstaking_deque);
            *arg5 = *arg5 + 1;
            let v1 = sorting_key(arg1, v0, arg2, arg3, arg5);
            if (v1 == 0) {
                arg0.processing_state.inactive_pools_amount = arg0.processing_state.inactive_pools_amount + 1;
            };
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.sorting_sandbox, v0);
            0x1::vector::push_back<u64>(&mut arg0.sorting_keys, v1);
        };
        if (0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::is_empty<0x2::object::ID>(&arg0.unstaking_deque)) {
            return true
        };
        false
    }

    public(friend) fun push_stake(arg0: &mut Storage, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_state_mut(arg0);
        push_stake_inner(v0, arg1, arg2);
    }

    fun push_stake_inner(arg0: &mut StorageStateV1, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::staking_pool::pool_id(&arg1);
        register_staking_pool(arg0, v0, arg2);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&mut arg0.stakes, v0);
        let v2 = 0x2::table_vec::length<0x3::staking_pool::StakedSui>(v1);
        if (v2 > 0) {
            let v3 = 0x2::table_vec::borrow_mut<0x3::staking_pool::StakedSui>(v1, v2 - 1);
            if (0x3::staking_pool::stake_activation_epoch(v3) == 0x3::staking_pool::stake_activation_epoch(&arg1)) {
                0x3::staking_pool::join_staked_sui(v3, arg1);
                return
            };
        };
        0x2::table_vec::push_back<0x3::staking_pool::StakedSui>(v1, arg1);
    }

    fun register_staking_pool(arg0: &mut StorageStateV1, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::linked_table::contains<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&arg0.stakes, arg1)) {
            0x2::linked_table::push_back<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&mut arg0.stakes, arg1, 0x2::table_vec::empty<0x3::staking_pool::StakedSui>(arg2));
            if (!0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::contains<0x2::object::ID>(&arg0.unstaking_deque, arg1)) {
                0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_back<0x2::object::ID>(&mut arg0.unstaking_deque, arg1);
            };
            return true
        };
        false
    }

    fun sort_sandbox(arg0: &mut StorageStateV1) {
        0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::sort::shell_sort_desc<0x2::object::ID>(&mut arg0.sorting_keys, &mut arg0.sorting_sandbox);
        arg0.sorting_keys = vector[];
    }

    public(friend) fun sort_unstaking_deque(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut u64) : bool {
        let v0 = borrow_state_mut(arg0);
        if (!v0.processing_state.is_sorting_processing) {
            v0.processing_state.is_sorting_processing = true;
        };
        if (!v0.is_sandbox_sorted) {
            if (move_unstaking_deque_to_sorting_sandbox_and_calc_keys(v0, arg1, arg2, arg3, arg4, arg5)) {
                v0.is_sandbox_sorted = true;
                sort_sandbox(v0);
            };
        };
        if (v0.is_sandbox_sorted) {
            let v1 = move_sorting_sandbox_to_unstaking_deque(v0, arg4, arg5);
            if (v1) {
                v0.is_sandbox_sorted = false;
                v0.inactive_pools_amount = v0.processing_state.inactive_pools_amount;
                v0.processing_state.is_sorting_processing = false;
                v0.processing_state.inactive_pools_amount = 0;
            };
            return v1
        };
        false
    }

    fun sorting_key(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut u64) : u64 {
        let v0 = 0x3::sui_system::pool_exchange_rates(arg0, &arg1);
        if (!0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2);
        *arg4 = *arg4 + 1;
        let v2 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2 - arg3);
        *arg4 = *arg4 + 1;
        if ((0x3::staking_pool::pool_token_amount(v1) as u256) * (0x3::staking_pool::sui_amount(v2) as u256) == 0) {
            return 0
        };
        (((0x3::staking_pool::sui_amount(v1) as u256) * (0x3::staking_pool::pool_token_amount(v2) as u256) * 10000000000 / (0x3::staking_pool::pool_token_amount(v1) as u256) * (0x3::staking_pool::sui_amount(v2) as u256)) as u64)
    }

    fun unregister_staking_pool(arg0: &mut StorageStateV1, arg1: 0x2::object::ID) : bool {
        if (0x2::linked_table::contains<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&arg0.stakes, arg1)) {
            if (0x2::table_vec::is_empty<0x3::staking_pool::StakedSui>(0x2::linked_table::borrow<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&arg0.stakes, arg1))) {
                0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::remove<0x2::object::ID>(&mut arg0.unstaking_deque, arg1);
                0x2::table_vec::destroy_empty<0x3::staking_pool::StakedSui>(0x2::linked_table::remove<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&mut arg0.stakes, arg1));
                if (arg0.inactive_pools_amount > 0) {
                    arg0.inactive_pools_amount = arg0.inactive_pools_amount - 1;
                };
                return true
            };
        };
        false
    }

    public(friend) fun unstake(arg0: &mut Storage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = borrow_state_mut(arg0);
        let v1 = 0;
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::front<0x2::object::ID>(&v0.unstaking_deque);
        while (*arg6 < arg5 && v1 < arg2 && 0x1::option::is_some<0x2::object::ID>(0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::front<0x2::object::ID>(&v0.unstaking_deque))) {
            let v4 = *0x1::option::borrow<0x2::object::ID>(v3);
            let v5 = if (v0.inactive_pools_amount == 0) {
                0x2::math::min(0x2::math::max(arg2 / 0x2::math::max(0x2::math::min(0x2::linked_table::length<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&v0.stakes), arg3), 1), arg4), arg2 - v1)
            } else {
                arg2 - v1
            };
            let v6 = unstake_from_pool(v0, arg1, v4, 0x2::math::max(v5, arg4), arg4, arg5, arg6, arg7);
            v1 = v1 + 0x2::balance::value<0x2::sui::SUI>(&v6);
            0x2::balance::join<0x2::sui::SUI>(&mut v2, v6);
            let v7 = 0x1::option::none<0x2::object::ID>();
            v3 = &v7;
            if (0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::contains<0x2::object::ID>(&v0.unstaking_deque, v4)) {
                v3 = 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::next<0x2::object::ID>(&v0.unstaking_deque, v4);
                *arg6 = *arg6 + 1;
            };
            if (!0x1::option::is_some<0x2::object::ID>(v3)) {
                v3 = 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::front<0x2::object::ID>(&v0.unstaking_deque);
            };
        };
        v2
    }

    fun unstake_from_pool(arg0: &mut StorageStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &mut u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0;
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        while (*arg6 < arg5 && v0 < arg3 && !is_pool_empty(arg0, arg2)) {
            *arg6 = *arg6 + 1;
            let v2 = 0x2::table_vec::pop_back<0x3::staking_pool::StakedSui>(0x2::linked_table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>>(&mut arg0.stakes, arg2));
            *arg6 = *arg6 + 1;
            let (v3, v4) = 0x8e6adb40c50cf2ce81d7dd12d240fb881df715343ab61233124aadb87a9fd1fd::sui_system_utils::staked_sui_principal_and_rewards(arg1, &v2, arg7);
            let v5 = ((arg3 - v0) as u128) * (v3 as u128);
            let v6 = ((v4 + v3) as u128);
            let v7 = if (v5 % v6 == 0) {
                0
            } else {
                1
            };
            let v8 = 0x2::math::min(0x2::math::max(((v5 / v6 + v7) as u64), arg4), v3);
            let v9 = if (v8 < v3 && v3 - v8 >= arg4) {
                let v9 = 0x3::staking_pool::split(&mut v2, v8, arg7);
                push_stake_inner(arg0, v2, arg7);
                *arg6 = *arg6 + 3;
                v9
            } else {
                v2
            };
            let v10 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v9, arg7);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            v0 = v0 + 0x2::balance::value<0x2::sui::SUI>(&v10);
        };
        if (is_pool_empty(arg0, arg2)) {
            unregister_staking_pool(arg0, arg2);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

