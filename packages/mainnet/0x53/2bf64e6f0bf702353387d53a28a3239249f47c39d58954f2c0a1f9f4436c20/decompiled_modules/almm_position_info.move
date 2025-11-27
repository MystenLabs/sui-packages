module 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_position_info {
    struct PositionInfo has store {
        position_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
        fee_owned_x: u64,
        fee_owned_y: u64,
        bin_start: u32,
        bin_count: u32,
        bin_shares: vector<u64>,
        bin_liquidity: vector<u256>,
        bin_fee_growth_x: vector<u256>,
        bin_fee_growth_y: vector<u256>,
        bin_rewarder_growth: vector<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u256,
        amount_owned: u256,
    }

    struct PositionManager has store {
        size: u64,
        ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        infos: 0x2::vec_map::VecMap<0x2::object::ID, PositionInfo>,
    }

    public fun borrow(arg0: &PositionManager) : &0x2::vec_map::VecMap<0x2::object::ID, PositionInfo> {
        &arg0.infos
    }

    public(friend) fun add_bin_liquidity(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        assert!(has_bin_id(arg0, arg1), 13906834668264620031);
        let v0 = 0x1::vector::borrow_mut<u256>(&mut arg0.bin_liquidity, get_bin_index(arg0, arg1));
        *v0 = *v0 + arg2;
    }

    public(friend) fun add_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 13906834749868998655);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.bin_shares, get_bin_index(arg0, arg1));
        *v0 = *v0 + arg2;
    }

    public(friend) fun add_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: PositionInfo) {
        0x2::vec_map::insert<0x2::object::ID, PositionInfo>(&mut arg0.infos, arg1, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.ids, arg1);
        arg0.size = arg0.size + 1;
    }

    public fun bin_ids(arg0: &PositionInfo) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < arg0.bin_count) {
            0x1::vector::push_back<u32>(&mut v0, arg0.bin_start + v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun bin_liquidity(arg0: &PositionInfo, arg1: u32) : u256 {
        assert!(has_bin_id(arg0, arg1), 13906834548005535743);
        *0x1::vector::borrow<u256>(&arg0.bin_liquidity, get_bin_index(arg0, arg1))
    }

    public fun bin_rewarder_growth(arg0: &PositionInfo, arg1: u32) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward> {
        0x1::vector::borrow<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&arg0.bin_rewarder_growth, get_bin_index(arg0, arg1))
    }

    public fun bin_rewarder_growth_mut(arg0: &mut PositionInfo, arg1: u32) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward> {
        0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, get_bin_index(arg0, arg1))
    }

    public fun bin_share(arg0: &PositionInfo, arg1: u32) : u64 {
        assert!(has_bin_id(arg0, arg1), 13906834565185404927);
        *0x1::vector::borrow<u64>(&arg0.bin_shares, get_bin_index(arg0, arg1))
    }

    fun drop(arg0: PositionInfo) {
        let PositionInfo {
            position_id         : _,
            pair_id             : _,
            fee_owned_x         : _,
            fee_owned_y         : _,
            bin_start           : _,
            bin_count           : _,
            bin_shares          : _,
            bin_liquidity       : _,
            bin_fee_growth_x    : _,
            bin_fee_growth_y    : _,
            bin_rewarder_growth : _,
        } = arg0;
    }

    public(friend) fun extract_fees(arg0: &mut PositionInfo) : (u64, u64) {
        arg0.fee_owned_x = 0;
        arg0.fee_owned_y = 0;
        (arg0.fee_owned_x, arg0.fee_owned_y)
    }

    public fun fee_growth(arg0: &PositionInfo, arg1: u32) : (u256, u256) {
        (*0x1::vector::borrow<u256>(&arg0.bin_fee_growth_x, get_bin_index(arg0, arg1)), *0x1::vector::borrow<u256>(&arg0.bin_fee_growth_y, get_bin_index(arg0, arg1)))
    }

    fun get_bin_index(arg0: &PositionInfo, arg1: u32) : u64 {
        assert!(has_bin_id(arg0, arg1), 13906834393386713087);
        ((arg1 - arg0.bin_start) as u64)
    }

    public(friend) fun get_position_info_bin_fees(arg0: &PositionInfo, arg1: u32, arg2: u256, arg3: u256) : (u64, u64) {
        assert!(has_bin_id(arg0, arg1), 13906835033336840191);
        let v0 = get_bin_index(arg0, arg1);
        let v1 = *0x1::vector::borrow<u256>(&arg0.bin_liquidity, v0);
        (arg0.fee_owned_x + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v1 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()) * (arg2 - *0x1::vector::borrow<u256>(&arg0.bin_fee_growth_x, v0)) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()), arg0.fee_owned_y + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v1 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()) * (arg3 - *0x1::vector::borrow<u256>(&arg0.bin_fee_growth_y, v0)) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()))
    }

    public fun has_bin_id(arg0: &PositionInfo, arg1: u32) : bool {
        arg1 >= arg0.bin_start && arg0.bin_start + arg0.bin_count > arg1
    }

    public fun ids(arg0: &PositionManager) : &vector<0x2::object::ID> {
        0x2::vec_set::keys<0x2::object::ID>(&arg0.ids)
    }

    public fun liquidity(arg0: &PositionInfo) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0.bin_count) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg0.bin_liquidity, (v0 as u64));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun new_position_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &vector<u32>, arg3: &mut 0x2::tx_context::TxContext) : PositionInfo {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            0x1::vector::push_back<u256>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(arg2)) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(arg2)) {
            0x1::vector::push_back<u256>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(arg2)) {
            0x1::vector::push_back<u256>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<u32>(arg2)) {
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut v8, 0x2::vec_map::empty<0x1::type_name::TypeName, PositionReward>());
            v9 = v9 + 1;
        };
        PositionInfo{
            position_id         : arg1,
            pair_id             : arg0,
            fee_owned_x         : 0,
            fee_owned_y         : 0,
            bin_start           : *0x1::vector::borrow<u32>(arg2, 0),
            bin_count           : (0x1::vector::length<u32>(arg2) as u32),
            bin_shares          : v2,
            bin_liquidity       : v0,
            bin_fee_growth_x    : v4,
            bin_fee_growth_y    : v6,
            bin_rewarder_growth : v8,
        }
    }

    public(friend) fun new_position_manager(arg0: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            size  : 0,
            ids   : 0x2::vec_set::empty<0x2::object::ID>(),
            infos : 0x2::vec_map::empty<0x2::object::ID, PositionInfo>(),
        }
    }

    public fun position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        let (_, v1) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, PositionInfo>(&arg0.infos, 0x2::vec_map::get_idx<0x2::object::ID, PositionInfo>(&arg0.infos, &arg1));
        v1
    }

    public(friend) fun position_info_load_rewarder_growth_from_bin(arg0: &mut PositionInfo, arg1: u32, arg2: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>) {
        assert!(has_bin_id(arg0, arg1), 13906834895897886719);
        let v0 = 0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, get_bin_index(arg0, arg1));
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::type_name::TypeName, u256>(arg2)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(arg2, v1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, PositionReward>(v0, v2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, PositionReward>(v0, v2);
            };
            let v6 = PositionReward{
                growth_inside : *v3,
                amount_owned  : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PositionReward>(v0, *v2, v6);
            v1 = v1 + 1;
        };
    }

    public fun position_info_mut(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        0x2::vec_map::get_mut<0x2::object::ID, PositionInfo>(&mut arg0.infos, &arg1)
    }

    public(friend) fun position_info_rewards_remains_zero(arg0: &PositionInfo) : bool {
        let v0 = 0;
        while (v0 < arg0.bin_count) {
            let v1 = 0x1::vector::borrow<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&arg0.bin_rewarder_growth, (v0 as u64));
            let v2 = 0x2::vec_map::keys<0x1::type_name::TypeName, PositionReward>(v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
                if (0x2::vec_map::get<0x1::type_name::TypeName, PositionReward>(v1, 0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3)).amount_owned >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset() > 0) {
                    return false
                };
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
        true
    }

    fun position_info_update_bin_fees_internal(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        let v0 = get_bin_index(arg0, arg1);
        let v1 = *0x1::vector::borrow<u256>(&arg0.bin_liquidity, v0);
        arg0.fee_owned_x = arg0.fee_owned_x + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v1 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()) * (arg2 - *0x1::vector::borrow<u256>(&arg0.bin_fee_growth_x, v0)) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset());
        arg0.fee_owned_y = arg0.fee_owned_y + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v1 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()) * (arg3 - *0x1::vector::borrow<u256>(&arg0.bin_fee_growth_y, v0)) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset());
        set_fee_growth(arg0, arg1, arg2, arg3);
    }

    fun position_info_update_bin_rewarders_internal(arg0: &mut PositionInfo, arg1: u32, arg2: 0x1::type_name::TypeName, arg3: u256) {
        let v0 = get_bin_index(arg0, arg1);
        let v1 = 0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, PositionReward>(v1, &arg2)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionReward>(v1, &arg2);
            v2.amount_owned = v2.amount_owned + (arg3 - v2.growth_inside) * (*0x1::vector::borrow<u256>(&arg0.bin_liquidity, v0) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset());
            v2.growth_inside = arg3;
        } else {
            let v3 = PositionReward{
                growth_inside : arg3,
                amount_owned  : arg3 * (*0x1::vector::borrow<u256>(&arg0.bin_liquidity, v0) >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset()),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PositionReward>(v1, arg2, v3);
        };
    }

    public fun position_reward_amount_owned(arg0: &PositionReward) : u64 {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(arg0.amount_owned >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset())
    }

    public fun position_reward_growth(arg0: &PositionReward) : u256 {
        arg0.growth_inside
    }

    public(friend) fun remove_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) {
        arg0.size = arg0.size - 1;
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.ids, &arg1);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PositionInfo>(&mut arg0.infos, &arg1);
        drop(v1);
    }

    public(friend) fun reset_rewarder(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u32, arg3: 0x1::type_name::TypeName, arg4: u256) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionReward>(bin_rewarder_growth(position_info(arg0, arg1), arg2), &arg3)) {
            let v1 = position_info_mut(arg0, arg1);
            let v2 = PositionReward{
                growth_inside : arg4,
                amount_owned  : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PositionReward>(bin_rewarder_growth_mut(v1, arg2), arg3, v2);
            0
        } else {
            let v3 = position_info_mut(arg0, arg1);
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionReward>(bin_rewarder_growth_mut(v3, arg2), &arg3);
            let v5 = v4.amount_owned;
            v4.growth_inside = arg4;
            if (v5 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset() == 0) {
                0
            } else {
                let v6 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v5 >> 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset());
                v4.amount_owned = v4.amount_owned - ((v6 as u256) << 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::scale_offset());
                v6
            }
        }
    }

    public(friend) fun set_fee_growth(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        assert!(has_bin_id(arg0, arg1), 13906834582365274111);
        let v0 = get_bin_index(arg0, arg1);
        *0x1::vector::borrow_mut<u256>(&mut arg0.bin_fee_growth_x, v0) = arg2;
        *0x1::vector::borrow_mut<u256>(&mut arg0.bin_fee_growth_y, v0) = arg3;
    }

    public(friend) fun set_fee_growth_x(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        assert!(has_bin_id(arg0, arg1), 13906834616725012479);
        *0x1::vector::borrow_mut<u256>(&mut arg0.bin_fee_growth_x, get_bin_index(arg0, arg1)) = arg2;
    }

    public(friend) fun set_fee_growth_y(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        assert!(has_bin_id(arg0, arg1), 13906834642494816255);
        *0x1::vector::borrow_mut<u256>(&mut arg0.bin_fee_growth_y, get_bin_index(arg0, arg1)) = arg2;
    }

    public fun size(arg0: &PositionManager) : u64 {
        arg0.size
    }

    public(friend) fun sub_bin_liquidity(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        assert!(has_bin_id(arg0, arg1), 13906834694034423807);
        let v0 = 0x1::vector::borrow_mut<u256>(&mut arg0.bin_liquidity, get_bin_index(arg0, arg1));
        assert!(*v0 >= arg2, 13906834706919325695);
        *v0 = *v0 - arg2;
    }

    public(friend) fun sub_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 13906834775638802431);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.bin_shares, get_bin_index(arg0, arg1));
        assert!(*v0 >= arg2, 13906834788523704319);
        *v0 = *v0 - arg2;
    }

    public(friend) fun update_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 13906834805703573503);
        *0x1::vector::borrow_mut<u64>(&mut arg0.bin_shares, get_bin_index(arg0, arg1)) = arg2;
    }

    public(friend) fun update_fees(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        position_info_update_bin_fees_internal(arg0, arg1, arg2, arg3);
    }

    public(friend) fun update_rewarder(arg0: &mut PositionInfo, arg1: u32, arg2: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, u256>(&arg2)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg2, v0);
            position_info_update_bin_rewarders_internal(arg0, arg1, *v1, *v2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

