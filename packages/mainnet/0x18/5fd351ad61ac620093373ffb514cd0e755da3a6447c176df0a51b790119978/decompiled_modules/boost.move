module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost {
    struct UserRewardInfo has drop, store {
        last_update_reward_index: u256,
        unclaimed_balance: u256,
        claimed_balance: u256,
    }

    struct RewardPoolInfo has store, key {
        id: 0x2::object::UID,
        escrow_fund: 0x2::object::ID,
        start_time: u256,
        end_time: u256,
        reward_index: u256,
        reward_action: u8,
        total_reward: u64,
        dola_pool_id: u16,
        last_update_time: u256,
        reward_per_second: u256,
        user_reward: 0x2::table::Table<u64, UserRewardInfo>,
    }

    struct RewardPoolInfos has store {
        info: vector<RewardPoolInfo>,
        catalog: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        associate_pool: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct UpdatePoolRewardEvent has copy, drop {
        dola_pool_id: u16,
        old_timestamp: u256,
        new_timestamp: u256,
        old_reward_index: u256,
        new_reward_index: u256,
    }

    struct UpdateUserRewardEvent has copy, drop {
        dola_pool_id: u16,
        dola_user_id: u64,
        old_unclaimed_balance: u256,
        new_unclaimed_balance: u256,
        old_reward_index: u256,
        new_reward_index: u256,
    }

    struct ClaimRewardEvent has copy, drop {
        token: 0x1::ascii::String,
        dola_pool_id: u16,
        dola_user_id: u64,
        reward_action: u8,
        amount: u64,
        sender: address,
    }

    public(friend) fun boost_pool(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = arg3;
        if (arg3 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type()) {
            v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type();
        } else if (arg3 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type()) {
            v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type();
        };
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_storage_id(arg0);
        if (0x2::dynamic_field::exists_<u16>(v1, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<u16, RewardPoolInfos>(v1, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<RewardPoolInfo>(&v2.info)) {
                let v4 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut v2.info, v3);
                assert!(arg1 == v4.dola_pool_id, 3);
                if (v0 == v4.reward_action) {
                    update_pool_reward(v4, get_total_scaled_balance(arg0, arg1, v0), arg4);
                    update_user_reward(v4, get_user_scaled_balance(arg0, arg1, arg2, v0), arg2);
                };
                v3 = v3 + 1;
            };
        };
    }

    public(friend) fun claim<T0>(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8, arg4: &mut RewardPool<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_storage_id(arg0);
        let v1 = 0x2::coin::zero<T0>(arg6);
        if (0x2::dynamic_field::exists_<u16>(v0, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<u16, RewardPoolInfos>(v0, arg1);
            if (0x2::table::contains<0x2::object::ID, u64>(&v2.catalog, arg4.associate_pool)) {
                let v3 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut v2.info, *0x2::table::borrow<0x2::object::ID, u64>(&v2.catalog, arg4.associate_pool));
                update_pool_reward(v3, get_total_scaled_balance(arg0, arg1, arg3), arg5);
                update_user_reward(v3, get_user_scaled_balance(arg0, arg1, arg2, arg3), arg2);
                let v4 = claim_reward<T0>(v3, arg4, arg2, arg6);
                0x2::coin::join<T0>(&mut v1, v4);
            };
        };
        let v5 = ClaimRewardEvent{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            dola_pool_id  : arg1,
            dola_user_id  : arg2,
            reward_action : arg3,
            amount        : 0x2::coin::value<T0>(&v1),
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ClaimRewardEvent>(v5);
        v1
    }

    public(friend) fun claim_reward<T0>(arg0: &mut RewardPoolInfo, arg1: &mut RewardPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.escrow_fund == 0x2::object::id<RewardPool<T0>>(arg1), 4);
        assert!(arg1.associate_pool == 0x2::object::id<RewardPoolInfo>(arg0), 4);
        let v0 = 0x2::table::borrow_mut<u64, UserRewardInfo>(&mut arg0.user_reward, arg2);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v0.unclaimed_balance, (0x2::balance::value<T0>(&arg1.balance) as u256));
        v0.unclaimed_balance = v0.unclaimed_balance - v1;
        v0.claimed_balance = v0.claimed_balance + v1;
        let v2 = UpdateUserRewardEvent{
            dola_pool_id          : arg0.dola_pool_id,
            dola_user_id          : arg2,
            old_unclaimed_balance : v0.unclaimed_balance,
            new_unclaimed_balance : v0.unclaimed_balance,
            old_reward_index      : v0.last_update_reward_index,
            new_reward_index      : v0.last_update_reward_index,
        };
        0x2::event::emit<UpdateUserRewardEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, (v1 as u64)), arg3)
    }

    public fun create_reward_pool<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: u256, arg3: u256, arg4: 0x2::coin::Coin<T0>, arg5: u16, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_reward_pool_inner<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_storage_id(arg1);
        if (!0x2::dynamic_field::exists_<u16>(v1, arg5)) {
            let v2 = RewardPoolInfos{
                info    : 0x1::vector::empty<RewardPoolInfo>(),
                catalog : 0x2::table::new<0x2::object::ID, u64>(arg7),
            };
            0x2::dynamic_field::add<u16, RewardPoolInfos>(v1, arg5, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<u16, RewardPoolInfos>(v1, arg5);
        0x2::table::add<0x2::object::ID, u64>(&mut v3.catalog, 0x2::object::id<RewardPoolInfo>(&v0), 0x1::vector::length<RewardPoolInfo>(&v3.info));
        0x1::vector::push_back<RewardPoolInfo>(&mut v3.info, v0);
    }

    fun create_reward_pool_inner<T0>(arg0: u256, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: u16, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : RewardPoolInfo {
        assert!(arg1 > arg0, 0);
        assert!(arg4 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type() || arg4 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(), 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = RewardPool<T0>{
            id             : v2,
            associate_pool : 0x2::object::uid_to_inner(&v1),
            balance        : 0x2::coin::into_balance<T0>(arg2),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v3);
        RewardPoolInfo{
            id                : v1,
            escrow_fund       : 0x2::object::uid_to_inner(&v2),
            start_time        : arg0,
            end_time          : arg1,
            reward_index      : 0,
            reward_action     : arg4,
            total_reward      : v0,
            dola_pool_id      : arg3,
            last_update_time  : arg0,
            reward_per_second : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div((v0 as u256), arg1 - arg0),
            user_reward       : 0x2::table::new<u64, UserRewardInfo>(arg5),
        }
    }

    public(friend) fun destory_reward_pool<T0>(arg0: RewardPoolInfo, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.escrow_fund == 0x2::object::id<RewardPool<T0>>(arg1), 4);
        assert!(arg1.associate_pool == 0x2::object::id<RewardPoolInfo>(&arg0), 4);
        let RewardPoolInfo {
            id                : v0,
            escrow_fund       : _,
            start_time        : _,
            end_time          : _,
            reward_index      : _,
            reward_action     : _,
            total_reward      : _,
            dola_pool_id      : _,
            last_update_time  : _,
            reward_per_second : _,
            user_reward       : v10,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::drop<u64, UserRewardInfo>(v10);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2)
    }

    public fun get_escrow_fund(arg0: &RewardPoolInfo) : &0x2::object::ID {
        &arg0.escrow_fund
    }

    public fun get_reward_action(arg0: &RewardPoolInfo) : u8 {
        arg0.reward_action
    }

    public fun get_reward_per_second(arg0: &RewardPoolInfo) : u256 {
        arg0.reward_per_second
    }

    public fun get_reward_pool(arg0: &RewardPoolInfos, arg1: 0x2::object::ID) : &RewardPoolInfo {
        0x1::vector::borrow<RewardPoolInfo>(&arg0.info, *0x2::table::borrow<0x2::object::ID, u64>(&arg0.catalog, arg1))
    }

    fun get_total_scaled_balance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u8) : u256 {
        if (arg2 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type()) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_otoken_scaled_total_supply_v2(arg0, arg1)
        } else {
            assert!(arg2 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(), 2);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_dtoken_scaled_total_supply_v2(arg0, arg1)
        }
    }

    public fun get_user_reward_info(arg0: &RewardPoolInfo, arg1: u64) : (u256, u256, u256) {
        assert!(0x2::table::contains<u64, UserRewardInfo>(&arg0.user_reward, arg1), 6);
        let v0 = 0x2::table::borrow<u64, UserRewardInfo>(&arg0.user_reward, arg1);
        (v0.unclaimed_balance, v0.claimed_balance, v0.last_update_reward_index)
    }

    fun get_user_scaled_balance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8) : u256 {
        if (arg3 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type()) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_otoken_v2(arg0, arg2, arg1)
        } else {
            assert!(arg3 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(), 2);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_dtoken_v2(arg0, arg2, arg1)
        }
    }

    public fun remove_reward_pool<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut RewardPool<T0>, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_storage_id(arg1);
        assert!(0x2::dynamic_field::exists_<u16>(v0, arg3), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<u16, RewardPoolInfos>(v0, arg3);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v1.catalog, arg2.associate_pool), 5);
        let v2 = 0x2::table::remove<0x2::object::ID, u64>(&mut v1.catalog, arg2.associate_pool);
        let v3 = 0x1::vector::length<RewardPoolInfo>(&v1.info) - 1;
        if (v2 != v3) {
            let v4 = 0x2::object::id<RewardPoolInfo>(0x1::vector::borrow<RewardPoolInfo>(&v1.info, v3));
            0x2::table::remove<0x2::object::ID, u64>(&mut v1.catalog, v4);
            0x2::table::add<0x2::object::ID, u64>(&mut v1.catalog, v4, v2);
        };
        destory_reward_pool<T0>(0x1::vector::swap_remove<RewardPoolInfo>(&mut v1.info, v2), arg2, arg4)
    }

    fun update_pool_reward(arg0: &mut RewardPoolInfo, arg1: u256, arg2: &0x2::clock::Clock) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::max(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_timestamp(arg2), arg0.start_time), arg0.end_time);
        if (arg1 == 0) {
            arg0.reward_index = 0;
        } else {
            arg0.reward_index = arg0.reward_index + arg0.reward_per_second * (v0 - arg0.last_update_time) / arg1;
        };
        arg0.last_update_time = v0;
        let v1 = UpdatePoolRewardEvent{
            dola_pool_id     : arg0.dola_pool_id,
            old_timestamp    : arg0.last_update_time,
            new_timestamp    : arg0.last_update_time,
            old_reward_index : arg0.reward_index,
            new_reward_index : arg0.reward_index,
        };
        0x2::event::emit<UpdatePoolRewardEvent>(v1);
    }

    fun update_user_reward(arg0: &mut RewardPoolInfo, arg1: u256, arg2: u64) {
        if (!0x2::table::contains<u64, UserRewardInfo>(&arg0.user_reward, arg2)) {
            let v0 = UserRewardInfo{
                last_update_reward_index : 0,
                unclaimed_balance        : 0,
                claimed_balance          : 0,
            };
            0x2::table::add<u64, UserRewardInfo>(&mut arg0.user_reward, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<u64, UserRewardInfo>(&mut arg0.user_reward, arg2);
        v1.unclaimed_balance = v1.unclaimed_balance + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg0.reward_index - v1.last_update_reward_index, arg1);
        v1.last_update_reward_index = arg0.reward_index;
        let v2 = UpdateUserRewardEvent{
            dola_pool_id          : arg0.dola_pool_id,
            dola_user_id          : arg2,
            old_unclaimed_balance : v1.unclaimed_balance,
            new_unclaimed_balance : v1.unclaimed_balance,
            old_reward_index      : v1.last_update_reward_index,
            new_reward_index      : v1.last_update_reward_index,
        };
        0x2::event::emit<UpdateUserRewardEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

