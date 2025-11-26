module 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::lb_position {
    struct LBBinPosition has copy, drop, store {
        bin_id: u32,
        amount: u128,
        fee_growth_inside_last_x: u128,
        fee_growth_inside_last_y: u128,
        reward_growth_inside_last: vector<u128>,
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
        toggle: u16,
    }

    struct LBPosition has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        my_id: 0x2::object::ID,
        saved_fees_x: u128,
        saved_fees_y: u128,
        saved_rewards: vector<u128>,
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

    public fun borrow_position_bin_from_pack(arg0: &PackedBins, arg1: u64) : &LBBinPosition {
        0x1::vector::borrow<LBBinPosition>(&arg0.bin_data, arg1)
    }

    public(friend) fun borrow_position_bin_mut_from_pack(arg0: &mut PackedBins, arg1: u64) : &mut LBBinPosition {
        0x1::vector::borrow_mut<LBBinPosition>(&mut arg0.bin_data, arg1)
    }

    public fun borrow_position_bins(arg0: &LBPositionInfo) : &0x2::table::Table<u32, PackedBins> {
        &arg0.bins
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
        arg0.toggle = arg0.toggle + 1;
        if (arg0.toggle == 32768) {
            arg0.toggle = 0;
        };
    }

    fun clear_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 & 255 - (1 << arg1)
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition) {
        let v0 = 0x2::table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, 0x2::object::id<LBPosition>(&arg1));
        let v1 = if (is_empty_lp(&v0)) {
            if (is_empty_reward(&arg1)) {
                is_empty_fees(&arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 203);
        destroy_position_info(v0);
        destroy(arg1);
    }

    public(friend) fun collect_saved_fees(arg0: &mut LBPosition) : (u64, u64) {
        arg0.saved_fees_x = 0;
        arg0.saved_fees_y = 0;
        (0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::u128_to_u64(arg0.saved_fees_x >> 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::q64x64::scale_offset()), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::u128_to_u64(arg0.saved_fees_y >> 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::q64x64::scale_offset()))
    }

    public(friend) fun collect_saved_rewards(arg0: &mut LBPosition, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<u128>(&arg0.saved_rewards)) {
            return 0
        };
        *0x1::vector::borrow_mut<u128>(&mut arg0.saved_rewards, arg1) = 0;
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::u128_to_u64(*0x1::vector::borrow<u128>(&arg0.saved_rewards, arg1) >> 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::q64x64::scale_offset())
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

    public(friend) fun create_empty_pack() : PackedBins {
        PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<LBBinPosition>(),
        }
    }

    fun destroy(arg0: LBPosition) {
        let LBPosition {
            id            : v0,
            pair_id       : _,
            my_id         : _,
            saved_fees_x  : _,
            saved_fees_y  : _,
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

    public(friend) fun get_pending_fees(arg0: &LBBinPosition, arg1: u128, arg2: u128) : (u128, u128) {
        let v0 = arg0.amount;
        if (v0 == 0) {
            return (0, 0)
        };
        (v0 * (arg1 - arg0.fee_growth_inside_last_x), v0 * (arg2 - arg0.fee_growth_inside_last_y))
    }

    public(friend) fun get_saved_fees(arg0: &LBPosition) : (u128, u128) {
        (arg0.saved_fees_x, arg0.saved_fees_y)
    }

    public(friend) fun get_saved_rewards(arg0: &LBPosition, arg1: u64) : u128 {
        if (arg1 >= 0x1::vector::length<u128>(&arg0.saved_rewards)) {
            return 0
        };
        *0x1::vector::borrow<u128>(&arg0.saved_rewards, arg1)
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
            v3 = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u32(v3, 1);
        };
        (v0, v1)
    }

    public(friend) fun increase_bin_liquidity(arg0: &mut LBBinPosition, arg1: u128) {
        arg0.amount = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u128(arg0.amount, arg1);
    }

    public(friend) fun increase_position_total_bins(arg0: &mut LBPosition, arg1: u64) {
        if (arg0.total_bins + arg1 > 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_bins()) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.ag/position?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.ag/Certified-Ferra-LPer.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Provides liquidity for the Ferra trading pair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.ag"));
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

    public fun is_empty_fees(arg0: &LBPosition) : bool {
        arg0.saved_fees_x == 0 && arg0.saved_fees_y == 0
    }

    public fun is_empty_lp(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, PackedBins>(&arg0.bins)
    }

    public fun is_empty_reward(arg0: &LBPosition) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0.saved_rewards)) {
            v0 = v0 + *0x1::vector::borrow<u128>(&arg0.saved_rewards, v1);
            v1 = v1 + 1;
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
        }
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut LBPositionManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : LBPosition {
        let v0 = 0x2::object::new(arg2);
        let v1 = LBPosition{
            id            : v0,
            pair_id       : arg1,
            my_id         : 0x2::object::uid_to_inner(&v0),
            saved_fees_x  : 0,
            saved_fees_y  : 0,
            saved_rewards : 0x1::vector::empty<u128>(),
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
            toggle      : 0,
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

    public(friend) fun remove_bins(arg0: &mut LBPositionManager, arg1: &mut LBPosition, arg2: vector<u32>) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1.my_id);
        let v1 = 0x1::vector::empty<u32>();
        let v2 = 0;
        let v3 = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_u32();
        let v4 = PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<LBBinPosition>(),
        };
        let v5 = &mut v4;
        while (v2 < 0x1::vector::length<u32>(&arg2)) {
            let (v6, v7) = resolve_bin_group_index(*0x1::vector::borrow<u32>(&arg2, v2));
            if (v6 != v3) {
                let v8 = if (v3 != 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_u32()) {
                    if (v5.active_bins_bitmap == 0) {
                        !0x1::vector::contains<u32>(&v1, &v3)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v8) {
                    0x1::vector::push_back<u32>(&mut v1, v3);
                };
                v5 = 0x2::table::borrow_mut<u32, PackedBins>(&mut v0.bins, v6);
                v3 = v6;
            };
            if (is_bin_active_in_bitmap(v5.active_bins_bitmap, v7)) {
                arg1.total_bins = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::sub_u64(arg1.total_bins, 1);
                0x1::vector::remove<LBBinPosition>(&mut v5.bin_data, (count_active_bins_before_position(v5.active_bins_bitmap, v7) as u64));
                v5.active_bins_bitmap = clear_bit_in_bitmap(v5.active_bins_bitmap, v7);
            };
            v2 = v2 + 1;
        };
        let v9 = if (v3 != 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_u32()) {
            if (v5.active_bins_bitmap == 0) {
                !0x1::vector::contains<u32>(&v1, &v3)
            } else {
                false
            }
        } else {
            false
        };
        if (v9) {
            0x1::vector::push_back<u32>(&mut v1, v3);
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<u32>(&v1)) {
            0x2::table::remove<u32, PackedBins>(&mut v0.bins, *0x1::vector::borrow<u32>(&v1, v10));
            v10 = v10 + 1;
        };
    }

    public(friend) fun resolve_bin_group_index(arg0: u32) : (u32, u8) {
        (arg0 >> 3, ((arg0 & 7) as u8))
    }

    fun set_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 | 1 << arg1
    }

    public(friend) fun settle_position_fees(arg0: &mut LBPosition, arg1: &mut LBBinPosition, arg2: u128, arg3: u128) {
        if (arg1.amount == 0) {
            arg1.fee_growth_inside_last_x = arg2;
            arg1.fee_growth_inside_last_y = arg3;
            return
        };
        arg0.saved_fees_x = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u128(arg0.saved_fees_x, arg1.amount * 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::sub_u128(arg2, arg1.fee_growth_inside_last_x));
        arg0.saved_fees_y = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u128(arg0.saved_fees_y, arg1.amount * 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::sub_u128(arg3, arg1.fee_growth_inside_last_y));
        arg1.fee_growth_inside_last_x = arg2;
        arg1.fee_growth_inside_last_y = arg3;
    }

    public(friend) fun settle_position_rewards(arg0: &mut LBPosition, arg1: &mut LBBinPosition, arg2: vector<u128>) {
        if (arg1.amount == 0) {
            arg1.reward_growth_inside_last = arg2;
            return
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg2)) {
            let v1 = *0x1::vector::borrow<u128>(&arg2, v0);
            let v2 = if (v0 < 0x1::vector::length<u128>(&arg1.reward_growth_inside_last)) {
                *0x1::vector::borrow<u128>(&arg1.reward_growth_inside_last, v0)
            } else {
                0
            };
            if (v1 > v2) {
                let v3 = arg1.amount * (v1 - v2);
                if (v3 > 0) {
                    while (0x1::vector::length<u128>(&arg0.saved_rewards) <= v0) {
                        0x1::vector::push_back<u128>(&mut arg0.saved_rewards, 0);
                    };
                    *0x1::vector::borrow_mut<u128>(&mut arg0.saved_rewards, v0) = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u128(*0x1::vector::borrow<u128>(&arg0.saved_rewards, v0), v3);
                };
            };
            v0 = v0 + 1;
        };
        arg1.reward_growth_inside_last = arg2;
    }

    public fun simulate_settle_position_rewards(arg0: &LBBinPosition, arg1: vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        if (arg0.amount == 0) {
            return v0
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg1)) {
            let v2 = *0x1::vector::borrow<u128>(&arg1, v1);
            let v3 = if (v1 < 0x1::vector::length<u128>(&arg0.reward_growth_inside_last)) {
                *0x1::vector::borrow<u128>(&arg0.reward_growth_inside_last, v1)
            } else {
                0
            };
            if (v2 > v3) {
                0x1::vector::push_back<u128>(&mut v0, arg0.amount * (v2 - v3));
            } else {
                0x1::vector::push_back<u128>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

