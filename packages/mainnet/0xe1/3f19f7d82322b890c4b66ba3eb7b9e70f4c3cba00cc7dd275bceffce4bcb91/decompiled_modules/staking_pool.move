module 0xe13f19f7d82322b890c4b66ba3eb7b9e70f4c3cba00cc7dd275bceffce4bcb91::staking_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        user_stakes: 0x2::table::Table<address, vector<0x3::staking_pool::StakedSui>>,
        user_staked_amounts: 0x2::table::Table<address, u64>,
        total_staked: u64,
        validator_address: address,
        admin: address,
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

    struct AdminWithdrawUserEvent has copy, drop {
        admin: address,
        user: address,
        amount: u64,
    }

    struct AdminWithdrawAllEvent has copy, drop {
        admin: address,
        total_amount_withdrawn: u64,
    }

    public entry fun admin_withdraw_all(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.total_staked = 0;
        let v0 = AdminWithdrawAllEvent{
            admin                  : 0x2::tx_context::sender(arg2),
            total_amount_withdrawn : 0,
        };
        0x2::event::emit<AdminWithdrawAllEvent>(v0);
    }

    public entry fun admin_withdraw_user_stakes(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        if (!0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, arg2)) {
            return
        };
        let v0 = 0x2::table::remove<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, arg2);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_staked_amounts, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.user_staked_amounts, arg2)
        } else {
            0
        };
        let v2 = 0;
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&v0)) {
            let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg3, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v0), arg4);
            v2 = v2 + 0x2::balance::value<0x2::sui::SUI>(&v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), arg0.admin);
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v0);
        arg0.total_staked = arg0.total_staked - v1;
        let v4 = AdminWithdrawUserEvent{
            admin  : 0x2::tx_context::sender(arg4),
            user   : arg2,
            amount : v2,
        };
        0x2::event::emit<AdminWithdrawUserEvent>(v4);
    }

    public entry fun create_staking_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StakingPool{
            id                  : 0x2::object::new(arg1),
            user_stakes         : 0x2::table::new<address, vector<0x3::staking_pool::StakedSui>>(arg1),
            user_staked_amounts : 0x2::table::new<address, u64>(arg1),
            total_staked        : 0,
            validator_address   : arg0,
            admin               : v0,
        };
        let v2 = AdminCap{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::uid_to_address(&v1.id),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<StakingPool>(v1);
    }

    public entry fun deposit(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
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

    public fun get_admin(arg0: &StakingPool) : address {
        arg0.admin
    }

    public fun get_pool_stats(arg0: &StakingPool) : u64 {
        arg0.total_staked
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

    public entry fun update_validator_address(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.validator_address = arg2;
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<0x3::staking_pool::StakedSui>>(&arg0.user_stakes, v0), 5);
        assert!(0x2::table::contains<address, u64>(&arg0.user_staked_amounts, v0), 5);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_staked_amounts, v0);
        assert!(arg1 <= v1, 7);
        let v2 = 0x2::table::borrow_mut<address, vector<0x3::staking_pool::StakedSui>>(&mut arg0.user_stakes, v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x3::staking_pool::StakedSui>(v2) && arg1 > 0) {
            0x1::vector::push_back<u64>(&mut v4, v5);
            v5 = v5 + 1;
        };
        0x1::vector::reverse<u64>(&mut v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v4) && arg1 > 0) {
            let v7 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x1::vector::remove<0x3::staking_pool::StakedSui>(v2, *0x1::vector::borrow<u64>(&v4, v6)), arg3);
            let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
            let v9 = if (v8 <= arg1) {
                v8
            } else {
                arg1
            };
            if (v8 > arg1) {
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(v2, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, v8 - arg1), arg3), arg0.validator_address, arg3));
            };
            v3 = v3 + v9;
            arg1 = arg1 - v9;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg3), v0);
            v6 = v6 + 1;
        };
        let v10 = v1 - v3;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.user_staked_amounts, v0) = v10;
        arg0.total_staked = arg0.total_staked - v3;
        let v11 = WithdrawEvent{
            user                  : v0,
            amount                : v3,
            remaining_user_staked : v10,
        };
        0x2::event::emit<WithdrawEvent>(v11);
    }

    // decompiled from Move bytecode v6
}

