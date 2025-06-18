module 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info {
    struct PositionInfo has store {
        position_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
        staked: bool,
        fee_owned_x: u64,
        fee_owned_y: u64,
        distribution_owned: u64,
        bin_ids: 0x2::vec_set::VecSet<u32>,
        bin_shares: 0x2::table::Table<u32, u64>,
        bin_liquidity: 0x2::table::Table<u32, u256>,
        bin_fee_growth_x: 0x2::table::Table<u32, u256>,
        bin_fee_growth_y: 0x2::table::Table<u32, u256>,
        bin_rewarder_growth: 0x2::table::Table<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>,
        bin_distribution_growth: 0x2::table::Table<u32, u256>,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u256,
        amount_owned: u64,
    }

    struct PositionManager has store {
        size: u64,
        ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        infos: 0x2::table::Table<0x2::object::ID, PositionInfo>,
    }

    public fun borrow(arg0: &PositionManager) : &0x2::table::Table<0x2::object::ID, PositionInfo> {
        &arg0.infos
    }

    fun drop(arg0: PositionInfo) {
        let PositionInfo {
            position_id             : _,
            pair_id                 : _,
            staked                  : v2,
            fee_owned_x             : _,
            fee_owned_y             : _,
            distribution_owned      : _,
            bin_ids                 : _,
            bin_shares              : v7,
            bin_liquidity           : v8,
            bin_fee_growth_x        : v9,
            bin_fee_growth_y        : v10,
            bin_rewarder_growth     : v11,
            bin_distribution_growth : v12,
        } = arg0;
        assert!(!v2, 13906835020451938303);
        0x2::table::drop<u32, u256>(v9);
        0x2::table::drop<u32, u256>(v10);
        0x2::table::drop<u32, u256>(v12);
        0x2::table::drop<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(v11);
        0x2::table::drop<u32, u256>(v8);
        0x2::table::drop<u32, u64>(v7);
    }

    public fun size(arg0: &PositionManager) : u64 {
        arg0.size
    }

    public(friend) fun add_bin_liquidity(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        let v0 = if (0x2::table::contains<u32, u256>(&arg0.bin_liquidity, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_liquidity, arg1)
        } else {
            0
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_liquidity, arg1, v0 + arg2);
    }

    public(friend) fun add_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.bin_shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.bin_shares, arg1)
        } else {
            0
        };
        0x2::table::add<u32, u64>(&mut arg0.bin_shares, arg1, v0 + arg2);
    }

    public(friend) fun add_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: PositionInfo) {
        0x2::table::add<0x2::object::ID, PositionInfo>(&mut arg0.infos, arg1, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.ids, arg1);
        arg0.size = arg0.size + 1;
    }

    public fun bin_distribution_growth(arg0: &PositionInfo, arg1: u32) : u256 {
        *0x2::table::borrow<u32, u256>(&arg0.bin_distribution_growth, arg1)
    }

    public fun bin_ids(arg0: &PositionInfo) : &vector<u32> {
        0x2::vec_set::keys<u32>(&arg0.bin_ids)
    }

    public fun bin_liquidity(arg0: &PositionInfo, arg1: u32) : u256 {
        *0x2::table::borrow<u32, u256>(&arg0.bin_liquidity, arg1)
    }

    public fun bin_rewarder_growth(arg0: &PositionInfo, arg1: u32) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward> {
        0x2::table::borrow<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&arg0.bin_rewarder_growth, arg1)
    }

    public fun bin_rewarder_growth_mut(arg0: &mut PositionInfo, arg1: u32) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward> {
        0x2::table::borrow_mut<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, arg1)
    }

    public fun bin_share(arg0: &PositionInfo, arg1: u32) : u64 {
        *0x2::table::borrow<u32, u64>(&arg0.bin_shares, arg1)
    }

    public fun distribution_growth(arg0: &PositionInfo, arg1: u32) : u256 {
        *0x2::table::borrow<u32, u256>(&arg0.bin_distribution_growth, arg1)
    }

    public(friend) fun extract_fees(arg0: &mut PositionInfo) : (u64, u64) {
        arg0.fee_owned_x = 0;
        arg0.fee_owned_y = 0;
        (arg0.fee_owned_x, arg0.fee_owned_y)
    }

    public fun fee_growth(arg0: &PositionInfo, arg1: u32) : (u256, u256) {
        (*0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_x, arg1), *0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_y, arg1))
    }

    public(friend) fun get_position_info_bin_fees(arg0: &PositionInfo, arg1: u32, arg2: u256, arg3: u256) : (u64, u64) {
        let v0 = if (0x2::table::contains<u32, u256>(&arg0.bin_liquidity, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_liquidity, arg1)
        } else {
            0
        };
        let v1 = if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_x, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_x, arg1)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_y, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_y, arg1)
        } else {
            0
        };
        (arg0.fee_owned_x + 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v0 >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()) * (arg2 - v1) >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()), arg0.fee_owned_y + 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v0 >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()) * (arg3 - v2) >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()))
    }

    public fun grow_distribution_growth(arg0: &mut PositionInfo, arg1: &0x3337c36ce4484367b105df693f9f806319eb6c2374c22612ec1d421f26aeb82::gauge_cap::GaugeCap, arg2: u32, arg3: u256) : u256 {
        assert!(arg0.pair_id == 0x3337c36ce4484367b105df693f9f806319eb6c2374c22612ec1d421f26aeb82::gauge_cap::get_pool_id(arg1), 13906834913077755903);
        if (0x2::table::contains<u32, u256>(&arg0.bin_distribution_growth, arg2)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_distribution_growth, arg2);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_distribution_growth, arg2, arg3);
        arg3 - bin_distribution_growth(arg0, arg2)
    }

    public fun has_bin_id(arg0: &PositionInfo, arg1: u32) : bool {
        0x2::vec_set::contains<u32>(&arg0.bin_ids, &arg1)
    }

    public fun ids(arg0: &PositionManager) : &vector<0x2::object::ID> {
        0x2::vec_set::keys<0x2::object::ID>(&arg0.ids)
    }

    public fun liquidity(arg0: &PositionInfo) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::vec_set::keys<u32>(&arg0.bin_ids);
        while (v0 < 0x1::vector::length<u32>(v2)) {
            v1 = v1 + *0x2::table::borrow<u32, u256>(&arg0.bin_liquidity, *0x1::vector::borrow<u32>(v2, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun new_partition_manager(arg0: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            size  : 0,
            ids   : 0x2::vec_set::empty<0x2::object::ID>(),
            infos : 0x2::table::new<0x2::object::ID, PositionInfo>(arg0),
        }
    }

    public(friend) fun new_position_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u32>, arg3: &mut 0x2::tx_context::TxContext) : PositionInfo {
        PositionInfo{
            position_id             : arg1,
            pair_id                 : arg0,
            staked                  : false,
            fee_owned_x             : 0,
            fee_owned_y             : 0,
            distribution_owned      : 0,
            bin_ids                 : 0x2::vec_set::from_keys<u32>(arg2),
            bin_shares              : 0x2::table::new<u32, u64>(arg3),
            bin_liquidity           : 0x2::table::new<u32, u256>(arg3),
            bin_fee_growth_x        : 0x2::table::new<u32, u256>(arg3),
            bin_fee_growth_y        : 0x2::table::new<u32, u256>(arg3),
            bin_rewarder_growth     : 0x2::table::new<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(arg3),
            bin_distribution_growth : 0x2::table::new<u32, u256>(arg3),
        }
    }

    public fun position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        0x2::table::borrow<0x2::object::ID, PositionInfo>(&arg0.infos, arg1)
    }

    public(friend) fun position_info_load_rewarder_growth_from_bin(arg0: &mut PositionInfo, arg1: u32, arg2: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>) {
        if (!0x2::table::contains<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&arg0.bin_rewarder_growth, arg1)) {
            0x2::table::add<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, arg1, 0x2::vec_map::empty<0x1::type_name::TypeName, PositionReward>());
        };
        let v0 = 0x2::table::borrow_mut<u32, 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionReward>>(&mut arg0.bin_rewarder_growth, arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(arg2)) {
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
        0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.infos, arg1)
    }

    fun position_info_update_bin_fees_internal(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        let v0 = if (0x2::table::contains<u32, u256>(&arg0.bin_liquidity, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_liquidity, arg1)
        } else {
            0
        };
        let v1 = if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_x, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_x, arg1)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_y, arg1)) {
            *0x2::table::borrow<u32, u256>(&arg0.bin_fee_growth_y, arg1)
        } else {
            0
        };
        arg0.fee_owned_x = arg0.fee_owned_x + 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v0 >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()) * (arg2 - v1) >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset());
        arg0.fee_owned_y = arg0.fee_owned_y + 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v0 >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset()) * (arg3 - v2) >> 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::scale_offset());
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_x, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_x, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_x, arg1, arg2);
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_y, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_y, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_y, arg1, arg3);
    }

    public fun position_reward_amount_owned(arg0: &PositionReward) : u64 {
        arg0.amount_owned
    }

    public fun position_reward_growth(arg0: &PositionReward) : u256 {
        arg0.growth_inside
    }

    public(friend) fun remove_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) {
        arg0.size = arg0.size - 1;
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.ids, &arg1);
        drop(0x2::table::remove<0x2::object::ID, PositionInfo>(&mut arg0.infos, arg1));
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
            v4.amount_owned = 0;
            v4.growth_inside = arg4;
            v4.amount_owned
        }
    }

    public(friend) fun set_distribution_growth(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        if (0x2::table::contains<u32, u256>(&arg0.bin_distribution_growth, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_distribution_growth, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_distribution_growth, arg1, arg2);
    }

    public(friend) fun set_fee_growth(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_x, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_x, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_x, arg1, arg2);
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_y, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_y, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_y, arg1, arg3);
    }

    public(friend) fun set_fee_growth_x(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_x, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_x, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_x, arg1, arg2);
    }

    public(friend) fun set_fee_growth_y(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        if (0x2::table::contains<u32, u256>(&arg0.bin_fee_growth_y, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_fee_growth_y, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_fee_growth_y, arg1, arg2);
    }

    public(friend) fun stake(arg0: &mut PositionInfo) {
        arg0.staked = true;
    }

    public fun staked(arg0: &PositionInfo) : bool {
        arg0.staked
    }

    public(friend) fun sub_bin_liquidity(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        let v0 = if (0x2::table::contains<u32, u256>(&arg0.bin_liquidity, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_liquidity, arg1)
        } else {
            0
        };
        assert!(v0 >= arg2, 13906834788523704319);
        0x2::table::add<u32, u256>(&mut arg0.bin_liquidity, arg1, v0 - arg2);
    }

    public(friend) fun sub_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.bin_shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.bin_shares, arg1)
        } else {
            0
        };
        assert!(v0 >= arg2, 13906834870128082943);
        0x2::table::add<u32, u64>(&mut arg0.bin_shares, arg1, v0 - arg2);
    }

    public(friend) fun unstake(arg0: &mut PositionInfo) {
        arg0.staked = false;
    }

    public(friend) fun update_bin_liquidity(arg0: &mut PositionInfo, arg1: u32, arg2: u256) {
        if (0x2::table::contains<u32, u256>(&arg0.bin_liquidity, arg1)) {
            0x2::table::remove<u32, u256>(&mut arg0.bin_liquidity, arg1);
        };
        0x2::table::add<u32, u256>(&mut arg0.bin_liquidity, arg1, arg2);
    }

    public(friend) fun update_bin_shares(arg0: &mut PositionInfo, arg1: u32, arg2: u64) {
        if (0x2::table::contains<u32, u64>(&arg0.bin_shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.bin_shares, arg1);
        };
        0x2::table::add<u32, u64>(&mut arg0.bin_shares, arg1, arg2);
    }

    public(friend) fun update_fees(arg0: &mut PositionInfo, arg1: u32, arg2: u256, arg3: u256) {
        position_info_update_bin_fees_internal(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

