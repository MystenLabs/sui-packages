module 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::lb_position {
    struct LBBinPosition has copy, drop, store {
        amount: u128,
        fee_growth_inside_last_x: u128,
        fee_growth_inside_last_y: u128,
    }

    struct PackedBins has drop, store {
        active_bins_bitmap: u64,
        bin_data: vector<LBBinPosition>,
    }

    struct LBPositionManager has store {
        positions: 0x2::table::Table<0x2::object::ID, LBPositionInfo>,
    }

    struct LBPositionInfo has store {
        position_id: 0x2::object::ID,
        bins: 0x2::table::Table<u32, PackedBins>,
        total_fees_gen: u128,
        reward_per_fee_snapshot: vector<u128>,
        reward_dump: bool,
        reward_dump_version: u64,
        reward_claimed_bitmap: u8,
        reward_version_checksum: u64,
    }

    struct LBPosition has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        lock_until: u64,
    }

    struct LB_POSITION has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LBPositionManager {
        LBPositionManager{positions: 0x2::table::new<0x2::object::ID, LBPositionInfo>(arg0)}
    }

    fun add_or_update_bin(arg0: &mut LBPositionInfo, arg1: u32, arg2: LBBinPosition) {
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            let v2 = PackedBins{
                active_bins_bitmap : 1 << v1,
                bin_data           : 0x1::vector::singleton<LBBinPosition>(arg2),
            };
            0x2::table::add<u32, PackedBins>(&mut arg0.bins, v0, v2);
            return
        };
        let v3 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        if (is_bin_active_in_bitmap(v3.active_bins_bitmap, v1)) {
            *0x1::vector::borrow_mut<LBBinPosition>(&mut v3.bin_data, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64)) = arg2;
        } else {
            0x1::vector::insert<LBBinPosition>(&mut v3.bin_data, arg2, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64));
            v3.active_bins_bitmap = set_bit_in_bitmap(v3.active_bins_bitmap, v1);
        };
    }

    public(friend) fun add_total_fees_gen(arg0: &mut LBPositionInfo, arg1: u128) {
        arg0.total_fees_gen = 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::add_u128(arg0.total_fees_gen, arg1);
    }

    public fun borrow_mut_position_info(arg0: &mut LBPositionManager, arg1: 0x2::object::ID) : &mut LBPositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    public fun borrow_position_info(arg0: &LBPositionManager, arg1: 0x2::object::ID) : &LBPositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    fun clear_bit_in_bitmap(arg0: u64, arg1: u8) : u64 {
        arg0 & 18446744073709551615 - (1 << arg1)
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition, arg2: u64) {
        let v0 = 0x2::table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, 0x2::object::id<LBPosition>(&arg1));
        assert!(is_position_empty(&v0, arg2), 7);
        destroy_position_info(v0);
        destroy(arg1);
    }

    public(friend) fun collect_fees(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = get_bin(v0, arg2);
        if (!0x1::option::is_some<LBBinPosition>(&v1)) {
            return (0, 0)
        };
        let v2 = 0x1::option::extract<LBBinPosition>(&mut v1);
        let v3 = v2.amount;
        let v4 = LBBinPosition{
            amount                   : v3,
            fee_growth_inside_last_x : arg3,
            fee_growth_inside_last_y : arg4,
        };
        add_or_update_bin(v0, arg2, v4);
        (((0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::mul_u128(v3, 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::sub_u128(arg3, v2.fee_growth_inside_last_x)) >> 64) as u64), ((0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::mul_u128(v3, 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::sub_u128(arg4, v2.fee_growth_inside_last_y)) >> 64) as u64))
    }

    fun count_active_bins(arg0: u64) : u8 {
        let v0 = arg0 - (arg0 >> 1 & 6148914691236517205);
        let v1 = (v0 & 3689348814741910323) + (v0 >> 2 & 3689348814741910323);
        let v2 = v1 + (v1 >> 4) & 1085102592571150095;
        let v3 = v2 + (v2 >> 8);
        let v4 = v3 + (v3 >> 16);
        ((v4 + (v4 >> 32) & 255) as u8)
    }

    fun count_active_bins_before_position(arg0: u64, arg1: u8) : u8 {
        if (arg1 == 0) {
            return 0
        };
        count_active_bins(arg0 & (1 << arg1) - 1)
    }

    fun count_set_bits_u8(arg0: u8) : u8 {
        let v0 = 0;
        while (arg0 > 0) {
            v0 = v0 + (arg0 & 1);
            arg0 = arg0 >> 1;
        };
        v0
    }

    public(friend) fun decrease_liquidity(arg0: &mut LBPositionManager, arg1: &mut 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::bin_manager::BinManager, arg2: &LBPosition, arg3: u32, arg4: u128, arg5: &0x2::clock::Clock) : u128 {
        assert!(arg2.lock_until <= 0x2::clock::timestamp_ms(arg5), 8);
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg2));
        let v1 = get_bin(v0, arg3);
        assert!(0x1::option::is_some<LBBinPosition>(&v1), 4);
        let v2 = 0x1::option::extract<LBBinPosition>(&mut v1);
        if (arg4 == 0) {
            return v2.amount
        };
        assert!(v2.amount >= arg4, 3);
        let v3 = v2.amount - arg4;
        if (v3 == 0) {
            remove_bin(v0, arg3);
        } else {
            let v4 = LBBinPosition{
                amount                   : v3,
                fee_growth_inside_last_x : v2.fee_growth_inside_last_x,
                fee_growth_inside_last_y : v2.fee_growth_inside_last_y,
            };
            add_or_update_bin(v0, arg3, v4);
        };
        0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::bin_manager::decrement_total_supply(arg1, arg3, arg4)
    }

    fun destroy(arg0: LBPosition) {
        let LBPosition {
            id          : v0,
            pair_id     : _,
            coin_type_a : _,
            coin_type_b : _,
            lock_until  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_position_info(arg0: LBPositionInfo) {
        let LBPositionInfo {
            position_id             : _,
            bins                    : v1,
            total_fees_gen          : _,
            reward_per_fee_snapshot : _,
            reward_dump             : _,
            reward_dump_version     : _,
            reward_claimed_bitmap   : _,
            reward_version_checksum : _,
        } = arg0;
        0x2::table::drop<u32, PackedBins>(v1);
    }

    fun find_nth_active_bin(arg0: u64, arg1: u8, arg2: u32) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 64) {
            if (is_bin_active_in_bitmap(arg0, v1)) {
                if (v0 == arg1) {
                    return arg2 + (v1 as u32)
                };
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    fun get_bin(arg0: &LBPositionInfo, arg1: u32) : 0x1::option::Option<LBBinPosition> {
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            return 0x1::option::none<LBBinPosition>()
        };
        let v2 = 0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0);
        if (!is_bin_active_in_bitmap(v2.active_bins_bitmap, v1)) {
            return 0x1::option::none<LBBinPosition>()
        };
        0x1::option::some<LBBinPosition>(*0x1::vector::borrow<LBBinPosition>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64)))
    }

    public fun get_lock_until(arg0: &LBPosition) : u64 {
        arg0.lock_until
    }

    public fun get_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = get_bin(borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1)), arg2);
        if (!0x1::option::is_some<LBBinPosition>(&v0)) {
            return (0, 0)
        };
        let v1 = 0x1::option::borrow<LBBinPosition>(&v0);
        let v2 = v1.amount;
        if (v2 == 0) {
            return (0, 0)
        };
        (((v2 * (arg3 - v1.fee_growth_inside_last_x) >> 64) as u64), ((v2 * (arg4 - v1.fee_growth_inside_last_y) >> 64) as u64))
    }

    public fun get_reward_claim_status(arg0: &LBPositionInfo) : (u64, u64, u64) {
        ((count_set_bits_u8(arg0.reward_claimed_bitmap) as u64), arg0.reward_version_checksum, (arg0.reward_claimed_bitmap as u64))
    }

    public fun get_reward_dump_version(arg0: &LBPositionInfo) : u64 {
        arg0.reward_dump_version
    }

    public fun get_reward_per_fee_snapshot(arg0: &LBPositionInfo, arg1: u64) : u128 {
        if (arg1 >= 0x1::vector::length<u128>(&arg0.reward_per_fee_snapshot)) {
            0
        } else {
            *0x1::vector::borrow<u128>(&arg0.reward_per_fee_snapshot, arg1)
        }
    }

    public fun get_tokens_in_position(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u32) : (vector<u32>, vector<u128>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v3 = arg2 >> 6;
        while (v3 <= arg3 >> 6) {
            if (0x2::table::contains<u32, PackedBins>(&v2.bins, v3)) {
                let v4 = 0x2::table::borrow<u32, PackedBins>(&v2.bins, v3);
                let v5 = 0;
                while (v5 < (0x1::vector::length<LBBinPosition>(&v4.bin_data) as u8)) {
                    let v6 = 0x1::vector::borrow<LBBinPosition>(&v4.bin_data, (v5 as u64));
                    let v7 = find_nth_active_bin(v4.active_bins_bitmap, v5, v3 << 6);
                    let v8 = if (v7 >= arg2) {
                        if (v7 <= arg3) {
                            v6.amount > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v8) {
                        0x1::vector::push_back<u32>(&mut v0, v7);
                        0x1::vector::push_back<u128>(&mut v1, v6.amount);
                    };
                    v5 = v5 + 1;
                };
            };
            v3 = 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::add_u32(v3, 1);
        };
        (v0, v1)
    }

    public fun get_total_fees_gen(arg0: &LBPositionInfo) : u128 {
        arg0.total_fees_gen
    }

    public fun get_total_pending_fees_with_growth(arg0: &LBPositionManager, arg1: &LBPosition, arg2: &vector<u32>, arg3: &vector<u128>, arg4: &vector<u128>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg2)) {
            let (v3, v4) = get_pending_fees(arg0, arg1, *0x1::vector::borrow<u32>(arg2, v2), *0x1::vector::borrow<u128>(arg3, v2), *0x1::vector::borrow<u128>(arg4, v2));
            v0 = 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::add_u64(v0, v3);
            v1 = 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::add_u64(v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun has_tokens_in_bins(arg0: &LBPositionManager, arg1: &LBPosition, arg2: &vector<u32>) : bool {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            let v2 = get_bin(v0, *0x1::vector::borrow<u32>(arg2, v1));
            if (0x1::option::is_some<LBBinPosition>(&v2)) {
                if (0x1::option::borrow<LBBinPosition>(&v2).amount > 0) {
                    return true
                };
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun increase_liquidity(arg0: &mut LBPositionManager, arg1: &mut 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::bin_manager::BinManager, arg2: &LBPosition, arg3: u32, arg4: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg2));
        let v1 = get_bin(v0, arg3);
        if (0x1::option::is_some<LBBinPosition>(&v1)) {
            let v2 = 0x1::option::extract<LBBinPosition>(&mut v1);
            let v3 = LBBinPosition{
                amount                   : 0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::safe_math::add_u128(v2.amount, arg4),
                fee_growth_inside_last_x : v2.fee_growth_inside_last_x,
                fee_growth_inside_last_y : v2.fee_growth_inside_last_y,
            };
            add_or_update_bin(v0, arg3, v3);
        } else {
            let v4 = LBBinPosition{
                amount                   : arg4,
                fee_growth_inside_last_x : 0,
                fee_growth_inside_last_y : 0,
            };
            add_or_update_bin(v0, arg3, v4);
        };
        0x3940291ce9e7431c5f4044081a8556163b972c11862278f10f6bd55e6770531::bin_manager::increment_total_supply(arg1, arg3, arg4)
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

    fun is_bin_active_in_bitmap(arg0: u64, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public fun is_empty_lp(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, PackedBins>(&arg0.bins)
    }

    public fun is_position_empty(arg0: &LBPositionInfo, arg1: u64) : bool {
        if (!is_empty_lp(arg0)) {
            return false
        };
        if (!arg0.reward_dump) {
            return false
        };
        if (arg1 == 0) {
            return true
        };
        assert!(arg1 <= 8, 9);
        if ((count_set_bits_u8(arg0.reward_claimed_bitmap) as u64) != arg1) {
            return false
        };
        if (arg0.reward_version_checksum != arg0.reward_dump_version * arg1) {
            return false
        };
        let v0 = if (arg1 == 8) {
            255
        } else {
            (1 << (arg1 as u8)) - 1
        };
        arg0.reward_claimed_bitmap == v0
    }

    public fun is_position_locked(arg0: &LBPosition, arg1: &0x2::clock::Clock) : bool {
        arg0.lock_until > 0x2::clock::timestamp_ms(arg1)
    }

    public fun is_reward_dump(arg0: &LBPositionInfo) : bool {
        arg0.reward_dump
    }

    public(friend) fun lock_position(arg0: &mut LBPosition, arg1: u64) {
        arg0.lock_until = arg1;
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut LBPositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LBPosition {
        let v0 = LBPosition{
            id          : 0x2::object::new(arg3),
            pair_id     : arg1,
            coin_type_a : 0x1::type_name::get<T0>(),
            coin_type_b : 0x1::type_name::get<T1>(),
            lock_until  : arg2,
        };
        let v1 = 0x2::object::id<LBPosition>(&v0);
        let v2 = LBPositionInfo{
            position_id             : v1,
            bins                    : 0x2::table::new<u32, PackedBins>(arg3),
            total_fees_gen          : 0,
            reward_per_fee_snapshot : 0x1::vector::empty<u128>(),
            reward_dump             : true,
            reward_dump_version     : 0,
            reward_claimed_bitmap   : 0,
            reward_version_checksum : 0,
        };
        0x2::table::add<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v1, v2);
        v0
    }

    public fun pair_id(arg0: &LBPosition) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun position_token_amount(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : u128 {
        let v0 = get_bin(borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1)), arg2);
        if (0x1::option::is_some<LBBinPosition>(&v0)) {
            0x1::option::borrow<LBBinPosition>(&v0).amount
        } else {
            0
        }
    }

    fun remove_bin(arg0: &mut LBPositionInfo, arg1: u32) : bool {
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            return false
        };
        let v2 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        if (!is_bin_active_in_bitmap(v2.active_bins_bitmap, v1)) {
            return false
        };
        0x1::vector::remove<LBBinPosition>(&mut v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64));
        v2.active_bins_bitmap = clear_bit_in_bitmap(v2.active_bins_bitmap, v1);
        if (v2.active_bins_bitmap == 0) {
            0x2::table::remove<u32, PackedBins>(&mut arg0.bins, v0);
        };
        true
    }

    fun resolve_bin_group_index(arg0: u32) : (u32, u8) {
        (arg0 >> 6, ((arg0 & 63) as u8))
    }

    fun set_bit_in_bitmap(arg0: u64, arg1: u8) : u64 {
        arg0 | 1 << arg1
    }

    public(friend) fun unlock_position(arg0: &mut LBPosition) {
        arg0.lock_until = 0;
    }

    public(friend) fun update_dump_state(arg0: &mut LBPositionInfo, arg1: bool) {
        if (arg1 && !arg0.reward_dump) {
            arg0.reward_dump = true;
            arg0.reward_dump_version = arg0.reward_dump_version + 1;
            arg0.reward_claimed_bitmap = 0;
            arg0.reward_version_checksum = 0;
        } else if (!arg1 && arg0.reward_dump) {
            arg0.reward_dump = false;
            arg0.reward_dump_version = arg0.reward_dump_version + 1;
            arg0.reward_claimed_bitmap = 0;
            arg0.reward_version_checksum = 0;
        };
    }

    public(friend) fun update_fee_info(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = get_bin(v0, arg2);
        if (0x1::option::is_some<LBBinPosition>(&v1)) {
            let v2 = 0x1::option::extract<LBBinPosition>(&mut v1);
            let v3 = LBBinPosition{
                amount                   : v2.amount,
                fee_growth_inside_last_x : arg3,
                fee_growth_inside_last_y : arg4,
            };
            add_or_update_bin(v0, arg2, v3);
        };
    }

    public(friend) fun update_reward_claim(arg0: &mut LBPositionInfo, arg1: u64) {
        assert!(arg1 < 8, 9);
        if (arg0.reward_dump) {
            let v0 = 1 << (arg1 as u8);
            assert!(arg0.reward_claimed_bitmap & v0 == 0, 10);
            arg0.reward_claimed_bitmap = arg0.reward_claimed_bitmap | v0;
            arg0.reward_version_checksum = arg0.reward_version_checksum + arg0.reward_dump_version;
        };
    }

    public(friend) fun update_reward_per_fee_snapshot(arg0: &mut LBPositionInfo, arg1: u64, arg2: u128) {
        while (0x1::vector::length<u128>(&arg0.reward_per_fee_snapshot) <= arg1) {
            0x1::vector::push_back<u128>(&mut arg0.reward_per_fee_snapshot, 0);
        };
        *0x1::vector::borrow_mut<u128>(&mut arg0.reward_per_fee_snapshot, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

