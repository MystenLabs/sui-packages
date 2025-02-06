module 0x61886761b37cb8a96aca3a603f6472bedd9a902d336dfb21195e77939b65efd1::staking {
    struct StakeEvent has copy, drop {
        staker: address,
        amount: u64,
        lock_duration_hours: u64,
        points: u64,
        stake_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        staker: address,
        amount: u64,
        stake_id: 0x2::object::ID,
    }

    struct StakePositionInfo has copy, drop {
        stake_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        lock_duration_hours: u64,
        lock_start_time: u64,
        lock_end_time: u64,
        current_points: u64,
        tier: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        total_staked: 0x2::balance::Balance<T0>,
        total_unstaked: u64,
        total_karma: u64,
        stake_count: u64,
        stake_ids: vector<0x2::object::ID>,
        token_multiplier: u64,
        emergency_mode: bool,
    }

    struct StakeInfo has store, key {
        id: 0x2::object::UID,
        amount: u64,
        lock_duration_hours: u64,
        lock_start_time: u64,
        points_per_hour: u64,
        owner: address,
    }

    struct StakeReceipt has key {
        id: 0x2::object::UID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        lock_duration_hours: u64,
        lock_start_time: u64,
        lock_end_time: u64,
        tier: u8,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct StakeNFTMeta has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun add_stake_record<T0>(arg0: &mut StakingPool<T0>, arg1: StakeInfo) {
        let v0 = 0x2::object::id<StakeInfo>(&arg1);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0), 7);
        0x2::dynamic_field::add<0x2::object::ID, StakeInfo>(&mut arg0.id, v0, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.stake_ids, v0);
        arg0.stake_count = arg0.stake_count + 1;
    }

    public fun calculate_current_points(arg0: &StakeInfo, arg1: u64) : u64 {
        if (arg0.lock_duration_hours == 3) {
            let v0 = (arg1 - arg0.lock_start_time) / 180000 / 3;
            let v1 = if (v0 > 3) {
                3
            } else {
                v0
            };
            return arg0.points_per_hour * v1 / 3
        };
        let v2 = (arg1 - arg0.lock_start_time) / 3600000;
        let v3 = if (v2 > arg0.lock_duration_hours) {
            arg0.lock_duration_hours
        } else {
            v2
        };
        v3 * arg0.points_per_hour
    }

    public entry fun create_config<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        let v0 = StakingPool<T0>{
            id               : 0x2::object::new(arg2),
            admin            : arg0.admin,
            total_staked     : 0x2::balance::zero<T0>(),
            total_unstaked   : 0,
            total_karma      : 0,
            stake_count      : 0,
            stake_ids        : 0x1::vector::empty<0x2::object::ID>(),
            token_multiplier : arg1,
            emergency_mode   : false,
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun early_withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: StakeReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id                  : v0,
            stake_id            : v1,
            owner               : v2,
            amount              : _,
            lock_duration_hours : _,
            lock_start_time     : _,
            lock_end_time       : _,
            tier                : _,
            description         : _,
            image_url           : _,
        } = arg2;
        assert!(v2 == 0x2::tx_context::sender(arg3), 8);
        verify_pool_state<T0>(arg0);
        let v10 = remove_stake_record<T0>(arg0, v1);
        verify_stake_owner(&v10, v2);
        let v11 = v10.amount;
        let v12 = v11 / 4;
        let v13 = v11 - v12;
        assert!(0x2::balance::value<T0>(&arg0.total_staked) >= v11, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v12), arg3), @0xbb96932a438b38eb4fe8491792e2cf5e1d3d5933c6bc2ca5339b5c52ad9034a1);
        arg0.total_unstaked = arg0.total_unstaked + v13;
        arg0.total_karma = arg0.total_karma - v10.points_per_hour;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v13), arg3), v2);
        0x2::object::delete(v0);
        let StakeInfo {
            id                  : v14,
            amount              : _,
            lock_duration_hours : _,
            lock_start_time     : _,
            points_per_hour     : _,
            owner               : _,
        } = v10;
        0x2::object::delete(v14);
        verify_pool_state<T0>(arg0);
        let v20 = WithdrawEvent{
            staker   : 0x2::tx_context::sender(arg3),
            amount   : v13,
            stake_id : v1,
        };
        0x2::event::emit<WithdrawEvent>(v20);
    }

    public entry fun emergency_withdraw_all<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 4);
        assert!(arg0.emergency_mode, 6);
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg0.stake_ids);
        while (v0 < v1) {
            let StakeInfo {
                id                  : v2,
                amount              : v3,
                lock_duration_hours : _,
                lock_start_time     : _,
                points_per_hour     : v6,
                owner               : v7,
            } = 0x2::dynamic_field::remove<0x2::object::ID, StakeInfo>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&arg0.stake_ids, v0));
            arg0.stake_count = arg0.stake_count - 1;
            arg0.total_unstaked = arg0.total_unstaked + v3;
            arg0.total_karma = arg0.total_karma - v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v3), arg2), v7);
            0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.stake_ids, v0);
            v1 = v1 - 1;
            0x2::object::delete(v2);
        };
    }

    public fun get_address_stakes<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<StakePositionInfo> {
        let v0 = get_all_stakes<T0>(arg0, arg2);
        let v1 = 0x1::vector::empty<StakePositionInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakePositionInfo>(&v0)) {
            let v3 = 0x1::vector::borrow<StakePositionInfo>(&v0, v2);
            if (v3.staker == arg1) {
                0x1::vector::push_back<StakePositionInfo>(&mut v1, *v3);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_address_total_points<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_address_stakes<T0>(arg0, arg1, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakePositionInfo>(&v0)) {
            v1 = v1 + 0x1::vector::borrow<StakePositionInfo>(&v0, v2).current_points;
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_all_stakes<T0>(arg0: &StakingPool<T0>, arg1: &0x2::clock::Clock) : vector<StakePositionInfo> {
        let v0 = 0x1::vector::empty<StakePositionInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.stake_ids)) {
            let v2 = 0x2::dynamic_field::borrow<0x2::object::ID, StakeInfo>(&arg0.id, *0x1::vector::borrow<0x2::object::ID>(&arg0.stake_ids, v1));
            let v3 = if (v2.lock_duration_hours == 3) {
                v2.lock_start_time + 180000
            } else {
                v2.lock_start_time + v2.lock_duration_hours * 3600000
            };
            let v4 = if (v2.lock_duration_hours == 3) {
                1
            } else if (v2.lock_duration_hours == 168) {
                2
            } else if (v2.lock_duration_hours == 720) {
                3
            } else if (v2.lock_duration_hours == 2160) {
                4
            } else {
                5
            };
            let v5 = StakePositionInfo{
                stake_id            : 0x2::object::id<StakeInfo>(v2),
                staker              : v2.owner,
                amount              : v2.amount,
                lock_duration_hours : v2.lock_duration_hours,
                lock_start_time     : v2.lock_start_time,
                lock_end_time       : v3,
                current_points      : calculate_current_points(v2, 0x2::clock::timestamp_ms(arg1)),
                tier                : v4,
            };
            0x1::vector::push_back<StakePositionInfo>(&mut v0, v5);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_stake_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, address) {
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, StakeInfo>(&arg0.id, arg1);
        (v0.amount, v0.lock_duration_hours, v0.lock_start_time, calculate_current_points(v0, 0x2::clock::timestamp_ms(arg2)), v0.owner)
    }

    fun get_stake_nft_metadata(arg0: u64, arg1: u64) : StakeNFTMeta {
        let v0 = if (arg0 == 3) {
            1
        } else if (arg0 == 168) {
            2
        } else if (arg0 == 720) {
            3
        } else if (arg0 == 2160) {
            4
        } else {
            5
        };
        let v1 = 0x1::string::utf8(b"Resurrect Stake NFT - Tier ");
        0x1::string::append(&mut v1, 0x1::u8::to_string((v0 as u8)));
        let v2 = 0x1::string::utf8(b"Stake Amount: ");
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" (base units), Lock Duration: "));
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg0));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" hours, Tier: "));
        0x1::string::append(&mut v2, 0x1::u8::to_string((v0 as u8)));
        StakeNFTMeta{
            name        : v1,
            description : v2,
            image_url   : 0x1::string::utf8(b"https://i.ibb.co/93nrvM8/resurrectstake-NFT.png"),
        }
    }

    public fun get_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_staked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun remove_stake_record<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID) : StakeInfo {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.stake_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.stake_ids, v0) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.stake_ids, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 9);
        arg0.stake_count = arg0.stake_count - 1;
        0x2::dynamic_field::remove<0x2::object::ID, StakeInfo>(&mut arg0.id, arg1)
    }

    public entry fun set_emergency<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 4);
        arg0.emergency_mode = true;
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 3) {
            true
        } else if (arg3 == 168) {
            true
        } else if (arg3 == 720) {
            true
        } else if (arg3 == 2160) {
            true
        } else {
            arg3 == 4320
        };
        assert!(v0, 0);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= 1000000000, 1);
        verify_pool_state<T0>(arg0);
        let v2 = if (arg3 == 3) {
            1
        } else if (arg3 == 168) {
            2
        } else if (arg3 == 720) {
            3
        } else if (arg3 == 2160) {
            4
        } else {
            5
        };
        let v3 = v1 * v2 * arg0.token_multiplier;
        let v4 = 0x2::clock::timestamp_ms(arg1);
        let v5 = if (arg3 == 3) {
            v4 + 180000
        } else {
            v4 + arg3 * 3600000
        };
        let v6 = StakeInfo{
            id                  : 0x2::object::new(arg4),
            amount              : v1,
            lock_duration_hours : arg3,
            lock_start_time     : v4,
            points_per_hour     : v3,
            owner               : 0x2::tx_context::sender(arg4),
        };
        let v7 = 0x2::object::id<StakeInfo>(&v6);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg2));
        add_stake_record<T0>(arg0, v6);
        arg0.total_karma = arg0.total_karma + v3;
        let v8 = get_stake_nft_metadata(arg3, v1);
        let v9 = if (arg3 == 3) {
            1
        } else if (arg3 == 168) {
            2
        } else if (arg3 == 720) {
            3
        } else if (arg3 == 2160) {
            4
        } else {
            5
        };
        let v10 = StakeReceipt{
            id                  : 0x2::object::new(arg4),
            stake_id            : v7,
            owner               : 0x2::tx_context::sender(arg4),
            amount              : v1,
            lock_duration_hours : arg3,
            lock_start_time     : v4,
            lock_end_time       : v5,
            tier                : v9,
            description         : v8.description,
            image_url           : v8.image_url,
        };
        0x2::transfer::transfer<StakeReceipt>(v10, 0x2::tx_context::sender(arg4));
        verify_pool_state<T0>(arg0);
        let v11 = StakeEvent{
            staker              : 0x2::tx_context::sender(arg4),
            amount              : v1,
            lock_duration_hours : arg3,
            points              : 0,
            stake_id            : v7,
        };
        0x2::event::emit<StakeEvent>(v11);
    }

    fun verify_pool_state<T0>(arg0: &StakingPool<T0>) {
        assert!(arg0.stake_count == 0x1::vector::length<0x2::object::ID>(&arg0.stake_ids), 10);
    }

    fun verify_stake_owner(arg0: &StakeInfo, arg1: address) {
        assert!(arg0.owner == arg1, 8);
    }

    public entry fun withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: StakeReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id                  : v0,
            stake_id            : v1,
            owner               : v2,
            amount              : _,
            lock_duration_hours : _,
            lock_start_time     : _,
            lock_end_time       : _,
            tier                : _,
            description         : _,
            image_url           : _,
        } = arg2;
        assert!(v2 == 0x2::tx_context::sender(arg3), 8);
        verify_pool_state<T0>(arg0);
        let v10 = 0x2::dynamic_field::borrow<0x2::object::ID, StakeInfo>(&arg0.id, v1);
        verify_stake_owner(v10, v2);
        let v11 = if (v10.lock_duration_hours == 3) {
            v10.lock_start_time + 180000
        } else {
            v10.lock_start_time + v10.lock_duration_hours * 3600000
        };
        assert!(0x2::clock::timestamp_ms(arg1) >= v11, 2);
        let v12 = remove_stake_record<T0>(arg0, v1);
        let v13 = v12.amount;
        assert!(0x2::balance::value<T0>(&arg0.total_staked) >= v13, 11);
        arg0.total_unstaked = arg0.total_unstaked + v13;
        arg0.total_karma = arg0.total_karma - v12.points_per_hour;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v13), arg3), 0x2::tx_context::sender(arg3));
        0x2::object::delete(v0);
        let StakeInfo {
            id                  : v14,
            amount              : _,
            lock_duration_hours : _,
            lock_start_time     : _,
            points_per_hour     : _,
            owner               : _,
        } = v12;
        0x2::object::delete(v14);
        verify_pool_state<T0>(arg0);
        let v20 = WithdrawEvent{
            staker   : 0x2::tx_context::sender(arg3),
            amount   : v13,
            stake_id : v1,
        };
        0x2::event::emit<WithdrawEvent>(v20);
    }

    // decompiled from Move bytecode v6
}

