module 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::lb_position {
    struct LBBinPosition has copy, drop, store {
        bin_id: u32,
        amount: u128,
        fee_growth_inside_last_x: u128,
        fee_growth_inside_last_y: u128,
        reward_growth_inside_last: vector<u128>,
        collected_fees_x: u64,
        collected_fees_y: u64,
    }

    struct PackedBins has drop, store {
        active_bins_bitmap: u8,
        bin_data: vector<LBBinPosition>,
    }

    struct LBPositionManager has store {
        positions: 0x2::table::Table<0x2::object::ID, LBPositionInfo>,
    }

    struct LBPositionInfo has store {
        position_id: 0x2::object::ID,
        pair_id: 0x2::object::ID,
        bins: 0x2::table::Table<u32, PackedBins>,
        toggle: bool,
    }

    struct LBPosition has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        my_id: 0x2::object::ID,
        saved_rewards: vector<u64>,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        lock_until: u64,
        total_bins: u64,
    }

    struct LB_POSITION has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LBPositionManager {
        LBPositionManager{positions: 0x2::table::new<0x2::object::ID, LBPositionInfo>(arg0)}
    }

    public(friend) fun create_empty_pack() : PackedBins {
        PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<LBBinPosition>(),
        }
    }

    public(friend) fun add_bin(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: LBBinPosition) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1.my_id);
        let (v1, v2) = resolve_bin_group_index(arg2);
        if (!0x2::table::contains<u32, PackedBins>(&v0.bins, v1)) {
            let v3 = PackedBins{
                active_bins_bitmap : 1 << v2,
                bin_data           : 0x1::vector::singleton<LBBinPosition>(arg3),
            };
            0x2::table::add<u32, PackedBins>(&mut v0.bins, v1, v3);
            return
        };
        let v4 = 0x2::table::borrow_mut<u32, PackedBins>(&mut v0.bins, v1);
        0x1::vector::insert<LBBinPosition>(&mut v4.bin_data, arg3, (count_active_bins_before_position(v4.active_bins_bitmap, v2) as u64));
        v4.active_bins_bitmap = set_bit_in_bitmap(v4.active_bins_bitmap, v2);
    }

    public(friend) fun borrow_bin(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : &LBBinPosition {
        let (v0, v1) = resolve_bin_group_index(arg2);
        let v2 = 0x2::table::borrow<u32, PackedBins>(&0x2::table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1.my_id).bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 201);
        0x1::vector::borrow<LBBinPosition>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public(friend) fun borrow_bin_mut(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32) : &mut LBBinPosition {
        let (v0, v1) = resolve_bin_group_index(arg2);
        let v2 = 0x2::table::borrow_mut<u32, PackedBins>(&mut 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1.my_id).bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 201);
        0x1::vector::borrow_mut<LBBinPosition>(&mut v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public(friend) fun borrow_position_bin_from_pack(arg0: &mut PackedBins, arg1: u64) : &mut LBBinPosition {
        0x1::vector::borrow_mut<LBBinPosition>(&mut arg0.bin_data, arg1)
    }

    public(friend) fun borrow_position_bins_mut(arg0: &mut LBPositionInfo) : &mut 0x2::table::Table<u32, PackedBins> {
        &mut arg0.bins
    }

    public(friend) fun borrow_position_info(arg0: &LBPositionManager, arg1: &LBPosition) : &LBPositionInfo {
        let v0 = 0x2::object::id<LBPosition>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0), 202);
        let v1 = 0x2::table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0);
        assert!(v1.position_id == v0, 202);
        v1
    }

    public(friend) fun borrow_position_info_mut(arg0: &mut LBPositionManager, arg1: &LBPosition) : &mut LBPositionInfo {
        let v0 = arg1.my_id;
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0), 202);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v0);
        assert!(v1.position_id == v0, 202);
        change_toggle(v1);
        v1
    }

    public(friend) fun change_toggle(arg0: &mut LBPositionInfo) {
        arg0.toggle = !arg0.toggle;
    }

    fun clear_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 & 255 - (1 << arg1)
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition) {
        let v0 = 0x2::table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, 0x2::object::id<LBPosition>(&arg1));
        assert!(is_empty_lp(&v0) && is_empty_reward(&arg1), 203);
        destroy_position_info(v0);
        destroy(arg1);
    }

    public(friend) fun collect_fees(arg0: &mut LBBinPosition, arg1: u128, arg2: u128) : (u64, u64, u64, u64) {
        let v0 = arg0.amount;
        let v1 = ((0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::mul_u128(v0, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(arg1, arg0.fee_growth_inside_last_x)) >> 64) as u64);
        let v2 = ((0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::mul_u128(v0, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(arg2, arg0.fee_growth_inside_last_y)) >> 64) as u64);
        arg0.collected_fees_x = 0;
        arg0.collected_fees_y = 0;
        arg0.fee_growth_inside_last_x = arg1;
        arg0.fee_growth_inside_last_y = arg2;
        (v1, v2, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(arg0.collected_fees_x, v1), 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(arg0.collected_fees_y, v2))
    }

    public(friend) fun collect_reward(arg0: &mut LBBinPosition, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = if (arg1 < 0x1::vector::length<u128>(&arg0.reward_growth_inside_last)) {
            *0x1::vector::borrow<u128>(&arg0.reward_growth_inside_last, arg1)
        } else {
            0
        };
        while (0x1::vector::length<u128>(&arg0.reward_growth_inside_last) <= arg1) {
            0x1::vector::push_back<u128>(&mut arg0.reward_growth_inside_last, 0);
        };
        *0x1::vector::borrow_mut<u128>(&mut arg0.reward_growth_inside_last, arg1) = arg2;
        0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(arg3 * 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(arg2, v0) >> 64)
    }

    public(friend) fun collect_saved_rewards(arg0: &mut LBPosition, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<u64>(&arg0.saved_rewards)) {
            return 0
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.saved_rewards, arg1) = 0;
        *0x1::vector::borrow<u64>(&arg0.saved_rewards, arg1)
    }

    public(friend) fun contains_bin(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : bool {
        let v0 = 0x2::table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1.my_id);
        let (v1, v2) = resolve_bin_group_index(arg2);
        !0x2::table::contains<u32, PackedBins>(&v0.bins, v1) && false || is_bin_active_in_bitmap(0x2::table::borrow<u32, PackedBins>(&v0.bins, v1).active_bins_bitmap, v2)
    }

    public(friend) fun count_active_bins(arg0: u8) : u8 {
        let v0 = arg0 - (arg0 >> 1 & 85);
        let v1 = (v0 & 51) + (v0 >> 2 & 51);
        (v1 & 15) + (v1 >> 4)
    }

    public(friend) fun count_active_bins_before_position(arg0: u8, arg1: u8) : u8 {
        if (arg1 == 0) {
            return 0
        };
        count_active_bins(arg0 & (1 << arg1) - 1)
    }

    public(friend) fun create_bin_in_pack(arg0: &mut PackedBins, arg1: u32, arg2: u8) {
        let v0 = arg0.active_bins_bitmap;
        0x1::vector::insert<LBBinPosition>(&mut arg0.bin_data, new_bin_position(arg1, 0), (count_active_bins_before_position(v0, arg2) as u64));
        arg0.active_bins_bitmap = set_bit_in_bitmap(v0, arg2);
    }

    fun destroy(arg0: LBPosition) {
        let LBPosition {
            id            : v0,
            pair_id       : _,
            my_id         : _,
            saved_rewards : _,
            coin_type_a   : _,
            coin_type_b   : _,
            lock_until    : _,
            total_bins    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_position_info(arg0: LBPositionInfo) {
        let LBPositionInfo {
            position_id : _,
            pair_id     : _,
            bins        : v2,
            toggle      : _,
        } = arg0;
        0x2::table::drop<u32, PackedBins>(v2);
    }

    public(friend) fun get_active_bins_bitmap(arg0: &PackedBins) : u8 {
        arg0.active_bins_bitmap
    }

    public fun get_lock_until(arg0: &LBPosition) : u64 {
        arg0.lock_until
    }

    public(friend) fun get_mut_position_saved_rewards(arg0: &mut LBPosition) : &mut vector<u64> {
        &mut arg0.saved_rewards
    }

    public(friend) fun get_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        if (!contains_bin(arg0, arg1, arg2)) {
            return (0, 0)
        };
        let v0 = borrow_bin(arg0, arg1, arg2);
        let v1 = v0.amount;
        if (v1 == 0) {
            return (0, 0)
        };
        (0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(v0.collected_fees_x, ((v1 * (arg3 - v0.fee_growth_inside_last_x) >> 64) as u64)), 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(v0.collected_fees_y, ((v1 * (arg4 - v0.fee_growth_inside_last_y) >> 64) as u64)))
    }

    public(friend) fun get_saved_rewards(arg0: &LBPosition, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<u64>(&arg0.saved_rewards)) {
            return 0
        };
        *0x1::vector::borrow<u64>(&arg0.saved_rewards, arg1)
    }

    public fun get_tokens_in_position(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u32) : (vector<u32>, vector<u128>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = borrow_position_info(arg0, arg1);
        let v3 = arg2 >> 3;
        while (v3 <= arg3 >> 3) {
            if (0x2::table::contains<u32, PackedBins>(&v2.bins, v3)) {
                let v4 = 0x2::table::borrow<u32, PackedBins>(&v2.bins, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<LBBinPosition>(&v4.bin_data)) {
                    let v6 = 0x1::vector::borrow<LBBinPosition>(&v4.bin_data, v5);
                    let v7 = if (v6.bin_id >= arg2) {
                        if (v6.bin_id <= arg3) {
                            v6.amount > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v7) {
                        0x1::vector::push_back<u32>(&mut v0, v6.bin_id);
                        0x1::vector::push_back<u128>(&mut v1, v6.amount);
                    };
                    v5 = v5 + 1;
                };
            };
            v3 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u32(v3, 1);
        };
        (v0, v1)
    }

    public(friend) fun increase_bin_liquidity(arg0: &mut LBBinPosition, arg1: u128, arg2: u128, arg3: u128, arg4: vector<u128>, arg5: &mut vector<u64>, arg6: u128) {
        if (arg0.amount > 0) {
            let v0 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(arg0.amount * 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(arg2, arg0.fee_growth_inside_last_x) >> 64);
            let v1 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(arg0.amount * 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(arg3, arg0.fee_growth_inside_last_y) >> 64);
            arg0.collected_fees_x = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(arg0.collected_fees_x, v0);
            arg0.collected_fees_y = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(arg0.collected_fees_y, v1);
            let v2 = 0;
            let v3 = 0x1::vector::length<u128>(&arg4);
            let v4 = 0x1::vector::length<u128>(&arg0.reward_growth_inside_last);
            let v5 = if (v3 < v4) {
                v3
            } else {
                v4
            };
            while (v2 < v5) {
                let v6 = *0x1::vector::borrow<u128>(&arg4, v2);
                let v7 = *0x1::vector::borrow<u128>(&arg0.reward_growth_inside_last, v2);
                if (v6 > v7) {
                    let v8 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::q64x64::liquidity_from_amounts(v0, v1, arg6) * (v6 - v7) >> 64);
                    if (v8 > 0) {
                        while (0x1::vector::length<u64>(arg5) <= v2) {
                            0x1::vector::push_back<u64>(arg5, 0);
                        };
                        *0x1::vector::borrow_mut<u64>(arg5, v2) = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(*0x1::vector::borrow<u64>(arg5, v2), v8);
                    };
                };
                v2 = v2 + 1;
            };
        };
        arg0.amount = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u128(arg0.amount, arg1);
        arg0.fee_growth_inside_last_x = arg2;
        arg0.fee_growth_inside_last_y = arg3;
        arg0.reward_growth_inside_last = arg4;
    }

    public(friend) fun increase_liquidity(arg0: &mut 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::BinManager, arg1: &mut LBPositionManager, arg2: &mut LBPosition, arg3: vector<u32>, arg4: vector<u128>, arg5: vector<u128>, arg6: vector<u128>, arg7: vector<u128>) {
        let v0 = 0x1::vector::length<u32>(&arg3);
        if (v0 == 0) {
            return
        };
        assert!(v0 <= 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_bins_per_operation(), 204);
        let v1 = borrow_position_info_mut(arg1, arg2);
        let v2 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::borrow_bins_table_mut(arg0);
        let v3 = 0;
        let v4 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_u32();
        let v5 = PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<LBBinPosition>(),
        };
        let v6 = &mut v5;
        let v7 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::create_empty_pack();
        let v8 = &mut v7;
        while (v3 < v0) {
            let v9 = *0x1::vector::borrow<u32>(&arg3, v3);
            let v10 = *0x1::vector::borrow<u128>(&arg5, v3);
            let v11 = *0x1::vector::borrow<u128>(&arg6, v3);
            let (v12, v13) = resolve_bin_group_index(v9);
            if (v12 != v4) {
                if (!0x2::table::contains<u32, PackedBins>(&v1.bins, v12)) {
                    let v14 = PackedBins{
                        active_bins_bitmap : 0,
                        bin_data           : 0x1::vector::empty<LBBinPosition>(),
                    };
                    0x2::table::add<u32, PackedBins>(&mut v1.bins, v12, v14);
                };
                v6 = 0x2::table::borrow_mut<u32, PackedBins>(&mut v1.bins, v12);
                v8 = 0x2::table::borrow_mut<u32, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::PackedBins>(v2, v12);
                v4 = v12;
            };
            if (is_bin_active_in_bitmap(v6.active_bins_bitmap, v13)) {
                let v15 = 0x1::vector::borrow_mut<LBBinPosition>(&mut v6.bin_data, (count_active_bins_before_position(v6.active_bins_bitmap, v13) as u64));
                if (v15.amount > 0) {
                    let v16 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(v15.amount * 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(v10, v15.fee_growth_inside_last_x) >> 64);
                    let v17 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(v15.amount * 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u128(v11, v15.fee_growth_inside_last_y) >> 64);
                    v15.collected_fees_x = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(v15.collected_fees_x, v16);
                    v15.collected_fees_y = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(v15.collected_fees_y, v17);
                    let v18 = 0;
                    let v19 = 0x1::vector::length<u128>(&arg7);
                    let v20 = 0x1::vector::length<u128>(&v15.reward_growth_inside_last);
                    let v21 = if (v19 < v20) {
                        v19
                    } else {
                        v20
                    };
                    while (v18 < v21) {
                        let v22 = *0x1::vector::borrow<u128>(&arg7, v18);
                        let v23 = *0x1::vector::borrow<u128>(&v15.reward_growth_inside_last, v18);
                        if (v22 > v23) {
                            let v24 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::u128_to_u64(0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::q64x64::liquidity_from_amounts(v16, v17, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::get_price(0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::get_bin_mut_from_pack(v8, 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::bin_manager::get_bin_index_in_pack(v8, v13)))) * (v22 - v23) >> 64);
                            if (v24 > 0) {
                                while (0x1::vector::length<u64>(&arg2.saved_rewards) <= v18) {
                                    0x1::vector::push_back<u64>(&mut arg2.saved_rewards, 0);
                                };
                                *0x1::vector::borrow_mut<u64>(&mut arg2.saved_rewards, v18) = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(*0x1::vector::borrow<u64>(&arg2.saved_rewards, v18), v24);
                            };
                        };
                        v18 = v18 + 1;
                    };
                };
                v15.amount = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u128(v15.amount, *0x1::vector::borrow<u128>(&arg4, v3));
                v15.fee_growth_inside_last_x = v10;
                v15.fee_growth_inside_last_y = v11;
                v15.reward_growth_inside_last = arg7;
            } else {
                if (arg2.total_bins + 1 > 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_bins_in_position()) {
                    abort 205
                };
                arg2.total_bins = arg2.total_bins + 1;
                let v25 = LBBinPosition{
                    bin_id                    : v9,
                    amount                    : *0x1::vector::borrow<u128>(&arg4, v3),
                    fee_growth_inside_last_x  : v10,
                    fee_growth_inside_last_y  : v11,
                    reward_growth_inside_last : arg7,
                    collected_fees_x          : 0,
                    collected_fees_y          : 0,
                };
                0x1::vector::insert<LBBinPosition>(&mut v6.bin_data, v25, (count_active_bins_before_position(v6.active_bins_bitmap, v13) as u64));
                v6.active_bins_bitmap = set_bit_in_bitmap(v6.active_bins_bitmap, v13);
            };
            v3 = v3 + 1;
        };
    }

    public(friend) fun increase_position_total_bins(arg0: &mut LBPosition, arg1: u64) {
        if (arg0.total_bins + arg1 > 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_bins_in_position()) {
            abort 205
        };
        arg0.total_bins = arg0.total_bins + arg1;
    }

    fun init(arg0: LB_POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.ferra.xyz/position?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Provides liquidity for the Ferra trading pair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra Labs"));
        let v4 = 0x2::package::claim<LB_POSITION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<LBPosition>(&v4, v0, v2, arg1);
        0x2::display::update_version<LBPosition>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LBPosition>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun is_bin_active_in_bitmap(arg0: u8, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public fun is_empty_lp(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, PackedBins>(&arg0.bins)
    }

    public fun is_empty_reward(arg0: &LBPosition) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.saved_rewards)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.saved_rewards, v1);
        };
        v0 == 0
    }

    public fun is_position_locked(arg0: &LBPosition, arg1: &0x2::clock::Clock) : bool {
        arg0.lock_until > 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun lock_position(arg0: &mut LBPosition, arg1: u64) {
        arg0.lock_until = arg1;
    }

    fun new_bin_position(arg0: u32, arg1: u128) : LBBinPosition {
        LBBinPosition{
            bin_id                    : arg0,
            amount                    : arg1,
            fee_growth_inside_last_x  : 0,
            fee_growth_inside_last_y  : 0,
            reward_growth_inside_last : 0x1::vector::empty<u128>(),
            collected_fees_x          : 0,
            collected_fees_y          : 0,
        }
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut LBPositionManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : LBPosition {
        let v0 = 0x2::object::new(arg2);
        let v1 = LBPosition{
            id            : v0,
            pair_id       : arg1,
            my_id         : 0x2::object::uid_to_inner(&v0),
            saved_rewards : 0x1::vector::empty<u64>(),
            coin_type_a   : 0x1::type_name::get<T0>(),
            coin_type_b   : 0x1::type_name::get<T1>(),
            lock_until    : 0,
            total_bins    : 0,
        };
        let v2 = 0x2::object::id<LBPosition>(&v1);
        let v3 = LBPositionInfo{
            position_id : v2,
            pair_id     : arg1,
            bins        : 0x2::table::new<u32, PackedBins>(arg2),
            toggle      : false,
        };
        0x2::table::add<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v2, v3);
        v1
    }

    public fun pair_id(arg0: &LBPosition) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun position_token_amount(arg0: &LBBinPosition) : u128 {
        arg0.amount
    }

    public(friend) fun remove_bin(arg0: &mut LBPositionManager, arg1: &mut LBPosition, arg2: u32) : bool {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1.my_id);
        let (v1, v2) = resolve_bin_group_index(arg2);
        if (!0x2::table::contains<u32, PackedBins>(&v0.bins, v1)) {
            return false
        };
        let v3 = 0x2::table::borrow_mut<u32, PackedBins>(&mut v0.bins, v1);
        if (!is_bin_active_in_bitmap(v3.active_bins_bitmap, v2)) {
            return false
        };
        arg1.total_bins = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u64(arg1.total_bins, 1);
        0x1::vector::remove<LBBinPosition>(&mut v3.bin_data, (count_active_bins_before_position(v3.active_bins_bitmap, v2) as u64));
        v3.active_bins_bitmap = clear_bit_in_bitmap(v3.active_bins_bitmap, v2);
        if (v3.active_bins_bitmap == 0) {
            0x2::table::remove<u32, PackedBins>(&mut v0.bins, v1);
        };
        true
    }

    public(friend) fun remove_bins(arg0: &mut LBPositionManager, arg1: &mut LBPosition, arg2: vector<u32>) {
        let v0 = 0x1::vector::length<u32>(&arg2);
        if (v0 == 0) {
            return
        };
        assert!(v0 <= 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_bins_per_operation(), 204);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1.my_id);
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0;
        let v4 = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_u32();
        let v5 = PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<LBBinPosition>(),
        };
        let v6 = &mut v5;
        while (v3 < v0) {
            let (v7, v8) = resolve_bin_group_index(*0x1::vector::borrow<u32>(&arg2, v3));
            if (v7 != v4) {
                let v9 = if (v4 != 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_u32()) {
                    if (v6.active_bins_bitmap == 0) {
                        !0x1::vector::contains<u32>(&v2, &v4)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v9) {
                    0x1::vector::push_back<u32>(&mut v2, v4);
                };
                v6 = 0x2::table::borrow_mut<u32, PackedBins>(&mut v1.bins, v7);
                v4 = v7;
            };
            if (is_bin_active_in_bitmap(v6.active_bins_bitmap, v8)) {
                arg1.total_bins = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::sub_u64(arg1.total_bins, 1);
                0x1::vector::remove<LBBinPosition>(&mut v6.bin_data, (count_active_bins_before_position(v6.active_bins_bitmap, v8) as u64));
                v6.active_bins_bitmap = clear_bit_in_bitmap(v6.active_bins_bitmap, v8);
            };
            v3 = v3 + 1;
        };
        let v10 = if (v4 != 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::constants::max_u32()) {
            if (v6.active_bins_bitmap == 0) {
                !0x1::vector::contains<u32>(&v2, &v4)
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            0x1::vector::push_back<u32>(&mut v2, v4);
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<u32>(&v2)) {
            0x2::table::remove<u32, PackedBins>(&mut v1.bins, *0x1::vector::borrow<u32>(&v2, v11));
            v11 = v11 + 1;
        };
    }

    public(friend) fun resolve_bin_group_index(arg0: u32) : (u32, u8) {
        (arg0 >> 3, ((arg0 & 7) as u8))
    }

    public(friend) fun save_reward(arg0: &mut LBPosition, arg1: u64, arg2: u64) {
        if (arg2 > 0) {
            while (0x1::vector::length<u64>(&arg0.saved_rewards) <= arg1) {
                0x1::vector::push_back<u64>(&mut arg0.saved_rewards, 0);
            };
            *0x1::vector::borrow_mut<u64>(&mut arg0.saved_rewards, arg1) = 0x4019f9dbea455a7e5187dc86bc7dad4b481470b171f456b6f8486e1c460375c7::safe_math::add_u64(*0x1::vector::borrow<u64>(&arg0.saved_rewards, arg1), arg2);
        };
    }

    fun set_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 | 1 << arg1
    }

    public(friend) fun unlock_position(arg0: &mut LBPosition) {
        arg0.lock_until = 0;
    }

    // decompiled from Move bytecode v6
}

