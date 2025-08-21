module 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::lb_position {
    struct LBBinPosition has copy, drop, store {
        bin_id: u32,
        amount: u128,
        fee_growth_inside_last_x: u128,
        fee_growth_inside_last_y: u128,
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

    fun borrow_bin(arg0: &LBPositionInfo, arg1: u32) : &LBBinPosition {
        let (v0, v1) = resolve_bin_group_index(arg1);
        assert!(0x2::table::contains<u32, PackedBins>(&arg0.bins, v0), 4);
        let v2 = 0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 4);
        0x1::vector::borrow<LBBinPosition>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    fun borrow_bin_mut(arg0: &mut LBPositionInfo, arg1: u32) : &mut LBBinPosition {
        let (v0, v1) = resolve_bin_group_index(arg1);
        assert!(0x2::table::contains<u32, PackedBins>(&arg0.bins, v0), 4);
        let v2 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 4);
        0x1::vector::borrow_mut<LBBinPosition>(&mut v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public fun borrow_mut_position_info(arg0: &mut LBPositionManager, arg1: &LBPosition) : &mut LBPositionInfo {
        let v0 = 0x2::object::id<LBPosition>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0), 6);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v0);
        assert!(v1.position_id == v0, 6);
        v1
    }

    public fun borrow_position_info(arg0: &LBPositionManager, arg1: &LBPosition) : &LBPositionInfo {
        let v0 = 0x2::object::id<LBPosition>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0), 6);
        let v1 = 0x2::table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, v0);
        assert!(v1.position_id == v0, 6);
        v1
    }

    fun clear_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 & 255 - (1 << arg1)
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition) {
        let v0 = 0x2::table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, 0x2::object::id<LBPosition>(&arg1));
        assert!(is_empty_lp(&v0), 7);
        destroy_position_info(v0);
        destroy(arg1);
    }

    public(friend) fun collect_fees(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        if (!contains_bin(v0, arg2)) {
            return (0, 0)
        };
        let v1 = borrow_bin_mut(v0, arg2);
        let v2 = v1.amount;
        v1.collected_fees_x = 0;
        v1.collected_fees_y = 0;
        v1.fee_growth_inside_last_x = arg3;
        v1.fee_growth_inside_last_y = arg4;
        (0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_x, ((0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::mul_u128(v2, 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::sub_u128(arg3, v1.fee_growth_inside_last_x)) >> 64) as u64)), 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_y, ((0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::mul_u128(v2, 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::sub_u128(arg4, v1.fee_growth_inside_last_y)) >> 64) as u64)))
    }

    fun contains_bin(arg0: &LBPositionInfo, arg1: u32) : bool {
        let (v0, v1) = resolve_bin_group_index(arg1);
        !0x2::table::contains<u32, PackedBins>(&arg0.bins, v0) && false || is_bin_active_in_bitmap(0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0).active_bins_bitmap, v1)
    }

    fun count_active_bins(arg0: u8) : u8 {
        let v0 = 0;
        while (arg0 != 0) {
            let v1 = arg0 - 1;
            arg0 = arg0 & v1;
            v0 = v0 + 1;
        };
        v0
    }

    fun count_active_bins_before_position(arg0: u8, arg1: u8) : u8 {
        if (arg1 == 0) {
            return 0
        };
        count_active_bins(arg0 & (1 << arg1) - 1)
    }

    public(friend) fun decrease_liquidity(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        assert!(contains_bin(v0, arg2), 4);
        let v1 = borrow_bin_mut(v0, arg2);
        assert!(v1.amount >= arg3, 3);
        let v2 = v1.amount - arg3;
        if (v2 == 0) {
            remove_bin(v0, arg2);
        } else {
            v1.amount = v2;
        };
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
            position_id : _,
            pair_id     : _,
            bins        : v2,
        } = arg0;
        0x2::table::drop<u32, PackedBins>(v2);
    }

    public fun get_lock_until(arg0: &LBPosition) : u64 {
        arg0.lock_until
    }

    public fun get_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_position_info(arg0, arg1);
        if (!contains_bin(v0, arg2)) {
            return (0, 0)
        };
        let v1 = borrow_bin(v0, arg2);
        let v2 = v1.amount;
        if (v2 == 0) {
            return (0, 0)
        };
        (0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_x, ((v2 * (arg3 - v1.fee_growth_inside_last_x) >> 64) as u64)), 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_y, ((v2 * (arg4 - v1.fee_growth_inside_last_y) >> 64) as u64)))
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
                while (v5 < (0x1::vector::length<LBBinPosition>(&v4.bin_data) as u8)) {
                    let v6 = 0x1::vector::borrow<LBBinPosition>(&v4.bin_data, (v5 as u64));
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
            v3 = 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u32(v3, 1);
        };
        (v0, v1)
    }

    public(friend) fun increase_liquidity(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128, arg5: u128) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        if (contains_bin(v0, arg2)) {
            let v1 = borrow_bin_mut(v0, arg2);
            let v2 = v1.amount;
            if (v2 > 0) {
                v1.collected_fees_x = 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_x, 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::u128_to_u64(v2 * 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::sub_u128(arg4, v1.fee_growth_inside_last_x) >> 64));
                v1.collected_fees_y = 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u64(v1.collected_fees_y, 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::u128_to_u64(v2 * 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::sub_u128(arg5, v1.fee_growth_inside_last_y) >> 64));
            };
            v1.amount = 0x74bf51be45ab29ab6bc932020832af3f14fa62b6bd52024207a460ec6f5bb95d::safe_math::add_u128(v1.amount, arg3);
            v1.fee_growth_inside_last_x = arg4;
            v1.fee_growth_inside_last_y = arg5;
        } else {
            let v3 = LBBinPosition{
                bin_id                   : arg2,
                amount                   : arg3,
                fee_growth_inside_last_x : arg4,
                fee_growth_inside_last_y : arg5,
                collected_fees_x         : 0,
                collected_fees_y         : 0,
            };
            upsert_bin(v0, arg2, v3);
        };
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

    fun is_bin_active_in_bitmap(arg0: u8, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public fun is_empty_lp(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, PackedBins>(&arg0.bins)
    }

    public fun is_position_locked(arg0: &LBPosition, arg1: &0x2::clock::Clock) : bool {
        arg0.lock_until > 0x2::clock::timestamp_ms(arg1)
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
            position_id : v1,
            pair_id     : arg1,
            bins        : 0x2::table::new<u32, PackedBins>(arg3),
        };
        0x2::table::add<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v1, v2);
        v0
    }

    public fun pair_id(arg0: &LBPosition) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun position_token_amount(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : u128 {
        let v0 = borrow_position_info(arg0, arg1);
        let (v1, v2) = resolve_bin_group_index(arg2);
        if (!0x2::table::contains<u32, PackedBins>(&v0.bins, v1)) {
            0
        } else {
            let v4 = 0x2::table::borrow<u32, PackedBins>(&v0.bins, v1);
            if (!is_bin_active_in_bitmap(v4.active_bins_bitmap, v2)) {
                0
            } else {
                0x1::vector::borrow<LBBinPosition>(&v4.bin_data, (count_active_bins_before_position(v4.active_bins_bitmap, v2) as u64)).amount
            }
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
        (arg0 >> 3, ((arg0 & 7) as u8))
    }

    fun set_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 | 1 << arg1
    }

    public(friend) fun unlock_position(arg0: &mut LBPosition) {
        arg0.lock_until = 0;
    }

    fun upsert_bin(arg0: &mut LBPositionInfo, arg1: u32, arg2: LBBinPosition) {
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

    // decompiled from Move bytecode v6
}

