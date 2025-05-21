module 0x124d647e6c4785e33865410a00385faa5f185a16403fe378687b368b9da4e254::staking_pool {
    struct StakingPool has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        user_stakes: 0x2::table::Table<address, u64>,
        staked_objects: 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>,
        next_stake_id: u64,
        total_staked: u64,
        validator_address: address,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        stake_id: u64,
        amount: u64,
        owner: address,
    }

    struct StakeEvent has copy, drop {
        user: address,
        amount: u64,
        stake_id: u64,
    }

    struct UnstakeEvent has copy, drop {
        user: address,
        amount: u64,
        stake_id: u64,
    }

    public entry fun create_staking_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                : 0x2::object::new(arg1),
            sui_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            user_stakes       : 0x2::table::new<address, u64>(arg1),
            staked_objects    : 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg1),
            next_stake_id     : 0,
            total_staked      : 0,
            validator_address : arg0,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun get_available_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public fun get_user_stake(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_stakes, arg1)
        } else {
            0
        }
    }

    public fun get_validator_address(arg0: &StakingPool) : address {
        arg0.validator_address
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg0.next_stake_id;
        arg0.next_stake_id = arg0.next_stake_id + 1;
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.staked_objects, v2, 0x3::sui_system::request_add_stake_non_entry(arg2, arg1, arg0.validator_address, arg3));
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, v1)) {
            0x2::table::add<address, u64>(&mut arg0.user_stakes, v1, 0x2::table::remove<address, u64>(&mut arg0.user_stakes, v1) + v0);
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_stakes, v1, v0);
        };
        arg0.total_staked = arg0.total_staked + v0;
        let v3 = StakeReceipt{
            id       : 0x2::object::new(arg3),
            pool_id  : 0x2::object::uid_to_address(&arg0.id),
            stake_id : v2,
            amount   : v0,
            owner    : v1,
        };
        0x2::transfer::public_transfer<StakeReceipt>(v3, v1);
        let v4 = StakeEvent{
            user     : v1,
            amount   : v0,
            stake_id : v2,
        };
        0x2::event::emit<StakeEvent>(v4);
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: StakeReceipt, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id       : v0,
            pool_id  : _,
            stake_id : v2,
            amount   : v3,
            owner    : v4,
        } = arg1;
        let v5 = 0x2::tx_context::sender(arg3);
        assert!(v4 == v5, 4);
        assert!(0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(&arg0.staked_objects, v2), 3);
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, v5)) {
            let v6 = 0x2::table::remove<address, u64>(&mut arg0.user_stakes, v5);
            if (v6 > v3) {
                0x2::table::add<address, u64>(&mut arg0.user_stakes, v5, v6 - v3);
            };
        };
        arg0.total_staked = arg0.total_staked - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg0.staked_objects, v2), arg3), arg3), v5);
        0x2::object::delete(v0);
        let v7 = UnstakeEvent{
            user     : v5,
            amount   : v3,
            stake_id : v2,
        };
        0x2::event::emit<UnstakeEvent>(v7);
    }

    public entry fun update_validator_address(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.validator_address = arg1;
    }

    // decompiled from Move bytecode v6
}

