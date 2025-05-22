module 0x5645e4198f8c926e96c16d0a11ebfdcb592f7d580537d477b43e2fb2b572b8a3::staking_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        user_deposits: 0x2::table::Table<address, u64>,
        user_withdrawals: 0x2::table::Table<address, u64>,
        staked_objects: 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>,
        next_stake_id: u64,
        total_staked: u64,
        total_deposited: u64,
        total_withdrawn: u64,
        validator_address: address,
        admin: address,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        stake_id: u64,
        amount: u64,
        owner: address,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        total_user_deposits: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        total_user_withdrawals: u64,
    }

    struct AdminStakeEvent has copy, drop {
        admin: address,
        amount: u64,
        stake_id: u64,
    }

    struct AdminUnstakeEvent has copy, drop {
        admin: address,
        amount: u64,
        stake_id: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    public entry fun admin_stake(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 5);
        let v0 = arg0.next_stake_id;
        arg0.next_stake_id = arg0.next_stake_id + 1;
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.staked_objects, v0, 0x3::sui_system::request_add_stake_non_entry(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg4), arg0.validator_address, arg4));
        arg0.total_staked = arg0.total_staked + arg2;
        let v1 = AdminStakeEvent{
            admin    : 0x2::tx_context::sender(arg4),
            amount   : arg2,
            stake_id : v0,
        };
        0x2::event::emit<AdminStakeEvent>(v1);
    }

    public entry fun admin_unstake(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        assert!(0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(&arg0.staked_objects, arg2), 2);
        let v0 = 0x3::sui_system::request_withdraw_stake_non_entry(arg3, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg0.staked_objects, arg2), arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v0);
        let v2 = if (arg0.total_staked >= v1) {
            arg0.total_staked - v1
        } else {
            0
        };
        arg0.total_staked = v2;
        let v3 = AdminUnstakeEvent{
            admin    : 0x2::tx_context::sender(arg4),
            amount   : v1,
            stake_id : arg2,
        };
        0x2::event::emit<AdminUnstakeEvent>(v3);
    }

    public entry fun admin_unstake_all(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        let v0 = 0;
        while (v0 < arg0.next_stake_id) {
            if (0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(&arg0.staked_objects, v0)) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg0.staked_objects, v0), arg3));
            };
            v0 = v0 + 1;
        };
        arg0.total_staked = 0;
    }

    public entry fun admin_withdraw(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3), arg0.admin);
        let v0 = AdminWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<AdminWithdrawEvent>(v0);
    }

    public entry fun create_staking_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StakingPool{
            id                : 0x2::object::new(arg1),
            sui_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            user_deposits     : 0x2::table::new<address, u64>(arg1),
            user_withdrawals  : 0x2::table::new<address, u64>(arg1),
            staked_objects    : 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg1),
            next_stake_id     : 0,
            total_staked      : 0,
            total_deposited   : 0,
            total_withdrawn   : 0,
            validator_address : arg0,
            admin             : v0,
        };
        let v2 = AdminCap{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::uid_to_address(&v1.id),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<StakingPool>(v1);
    }

    public entry fun deposit(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 6);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_deposits, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, v1)
        } else {
            0
        };
        let v3 = v2 + v0;
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v1) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_deposits, v1, v3);
        };
        arg0.total_deposited = arg0.total_deposited + v0;
        let v4 = DepositEvent{
            user                : v1,
            amount              : v0,
            total_user_deposits : v3,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun get_admin(arg0: &StakingPool) : address {
        arg0.admin
    }

    public fun get_pool_stats(arg0: &StakingPool) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.total_staked, arg0.total_deposited, arg0.total_withdrawn, arg0.next_stake_id)
    }

    public fun get_user_balance(arg0: &StakingPool, arg1: address) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        } else {
            0
        };
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_withdrawals, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_withdrawals, arg1)
        } else {
            0
        };
        v0 - v1
    }

    public fun get_user_total_deposits(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        } else {
            0
        }
    }

    public fun get_user_total_withdrawals(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_withdrawals, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_withdrawals, arg1)
        } else {
            0
        }
    }

    public fun get_validator_address(arg0: &StakingPool) : address {
        arg0.validator_address
    }

    public entry fun update_validator_address(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.validator_address = arg2;
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.user_deposits, v0), 5);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_withdrawals, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_withdrawals, v0)
        } else {
            0
        };
        assert!(arg1 <= *0x2::table::borrow<address, u64>(&arg0.user_deposits, v0) - v1, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 5);
        let v2 = v1 + arg1;
        if (0x2::table::contains<address, u64>(&arg0.user_withdrawals, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_withdrawals, v0) = v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_withdrawals, v0, v2);
        };
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), v0);
        let v3 = WithdrawEvent{
            user                   : v0,
            amount                 : arg1,
            total_user_withdrawals : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

