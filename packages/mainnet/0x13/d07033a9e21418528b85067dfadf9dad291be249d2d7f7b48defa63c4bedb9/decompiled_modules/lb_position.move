module 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::lb_position {
    struct LBBinPosition has copy, drop, store {
        amount: u128,
        fee_growth_inside_last_x: u128,
        fee_growth_inside_last_y: u128,
    }

    struct LBPositionManager has store {
        positions: 0x2::table::Table<0x2::object::ID, LBPositionInfo>,
    }

    struct FeeRewardInfo has store {
        total_fees_generated: u128,
        reward_per_fee_snapshot: vector<u128>,
    }

    struct LBPositionInfo has store {
        position_id: 0x2::object::ID,
        bins: 0x2::table::Table<u32, LBBinPosition>,
        fee_reward_info: FeeRewardInfo,
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

    public fun is_empty(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, LBBinPosition>(&arg0.bins)
    }

    public(friend) fun add_total_fees_generated(arg0: &mut LBPositionInfo, arg1: u128) {
        arg0.fee_reward_info.total_fees_generated = 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::safe_math::add_u128(arg0.fee_reward_info.total_fees_generated, arg1);
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

    fun calculate_and_update_fees_internal(arg0: &mut LBBinPosition, arg1: u128, arg2: u128) : (u64, u64) {
        let v0 = arg0.amount;
        if (v0 == 0) {
            return (0, 0)
        };
        arg0.fee_growth_inside_last_x = arg1;
        arg0.fee_growth_inside_last_y = arg2;
        (((v0 * (arg1 - arg0.fee_growth_inside_last_x) >> 64) as u64), ((v0 * (arg2 - arg0.fee_growth_inside_last_y) >> 64) as u64))
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition) {
        let v0 = 0x2::object::id<LBPosition>(&arg1);
        assert!(is_empty(borrow_position_info(arg0, v0)), 7);
        destroy_position_info(0x2::table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v0));
        destroy(arg1);
    }

    public(friend) fun collect_fees(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (!0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg2)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow_mut<u32, LBBinPosition>(&mut v0.bins, arg2);
        calculate_and_update_fees_internal(v1, arg3, arg4)
    }

    public(friend) fun decrease_liquidity(arg0: &mut LBPositionManager, arg1: &mut 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::bin_manager::BinManager, arg2: &LBPosition, arg3: u32, arg4: u128, arg5: &0x2::clock::Clock) : u128 {
        assert!(arg2.lock_until <= 0x2::clock::timestamp_ms(arg5), 8);
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg2));
        assert!(0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg3), 4);
        let v1 = 0x2::table::borrow_mut<u32, LBBinPosition>(&mut v0.bins, arg3);
        if (arg4 == 0) {
            return v1.amount
        };
        assert!(v1.amount >= arg4, 3);
        v1.amount = v1.amount - arg4;
        if (is_bin_position_empty(v1)) {
            0x2::table::remove<u32, LBBinPosition>(&mut v0.bins, arg3);
        };
        0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::bin_manager::decrement_total_supply(arg1, arg3, arg4)
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
            position_id     : _,
            bins            : v1,
            fee_reward_info : v2,
        } = arg0;
        let FeeRewardInfo {
            total_fees_generated    : _,
            reward_per_fee_snapshot : _,
        } = v2;
        0x2::table::drop<u32, LBBinPosition>(v1);
    }

    public fun get_lock_until(arg0: &LBPosition) : u64 {
        arg0.lock_until
    }

    public fun get_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (!0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg2)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<u32, LBBinPosition>(&v0.bins, arg2);
        let v2 = v1.amount;
        if (v2 == 0) {
            return (0, 0)
        };
        (((v2 * (arg3 - v1.fee_growth_inside_last_x) >> 64) as u64), ((v2 * (arg4 - v1.fee_growth_inside_last_y) >> 64) as u64))
    }

    public fun get_reward_per_fee_snapshot(arg0: &LBPositionInfo, arg1: u64) : u128 {
        if (arg1 >= 0x1::vector::length<u128>(&arg0.fee_reward_info.reward_per_fee_snapshot)) {
            0
        } else {
            *0x1::vector::borrow<u128>(&arg0.fee_reward_info.reward_per_fee_snapshot, arg1)
        }
    }

    public fun get_tokens_in_position(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u32) : (vector<u32>, vector<u128>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        while (arg2 <= arg3) {
            if (0x2::table::contains<u32, LBBinPosition>(&v2.bins, arg2)) {
                let v3 = 0x2::table::borrow<u32, LBBinPosition>(&v2.bins, arg2);
                if (v3.amount > 0) {
                    0x1::vector::push_back<u32>(&mut v0, arg2);
                    0x1::vector::push_back<u128>(&mut v1, v3.amount);
                };
            };
            arg2 = arg2 + 1;
        };
        (v0, v1)
    }

    public fun get_total_fees_generated(arg0: &LBPositionInfo) : u128 {
        arg0.fee_reward_info.total_fees_generated
    }

    public fun get_total_pending_fees_with_growth(arg0: &LBPositionManager, arg1: &LBPosition, arg2: &vector<u32>, arg3: &vector<u128>, arg4: &vector<u128>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg2)) {
            let (v3, v4) = get_pending_fees(arg0, arg1, *0x1::vector::borrow<u32>(arg2, v2), *0x1::vector::borrow<u128>(arg3, v2), *0x1::vector::borrow<u128>(arg4, v2));
            v0 = 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::safe_math::add_u64(v0, v3);
            v1 = 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::safe_math::add_u64(v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun has_tokens_in_bins(arg0: &LBPositionManager, arg1: &LBPosition, arg2: &vector<u32>) : bool {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            let v2 = *0x1::vector::borrow<u32>(arg2, v1);
            if (0x2::table::contains<u32, LBBinPosition>(&v0.bins, v2)) {
                if (0x2::table::borrow<u32, LBBinPosition>(&v0.bins, v2).amount > 0) {
                    return true
                };
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun increase_liquidity(arg0: &mut LBPositionManager, arg1: &mut 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::bin_manager::BinManager, arg2: &LBPosition, arg3: u32, arg4: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg2));
        if (0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg3)) {
            let v1 = 0x2::table::borrow_mut<u32, LBBinPosition>(&mut v0.bins, arg3);
            v1.amount = 0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::safe_math::add_u128(v1.amount, arg4);
        } else {
            let v2 = LBBinPosition{
                amount                   : arg4,
                fee_growth_inside_last_x : 0,
                fee_growth_inside_last_y : 0,
            };
            0x2::table::add<u32, LBBinPosition>(&mut v0.bins, arg3, v2);
        };
        0x13d07033a9e21418528b85067dfadf9dad291be249d2d7f7b48defa63c4bedb9::bin_manager::increment_total_supply(arg1, arg3, arg4)
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

    fun is_bin_position_empty(arg0: &LBBinPosition) : bool {
        arg0.amount == 0
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
        let v2 = FeeRewardInfo{
            total_fees_generated    : 0,
            reward_per_fee_snapshot : 0x1::vector::empty<u128>(),
        };
        let v3 = LBPositionInfo{
            position_id     : v1,
            bins            : 0x2::table::new<u32, LBBinPosition>(arg3),
            fee_reward_info : v2,
        };
        0x2::table::add<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v1, v3);
        v0
    }

    public fun pair_id(arg0: &LBPosition) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun position_token_amount(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : u128 {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg2)) {
            0x2::table::borrow<u32, LBBinPosition>(&v0.bins, arg2).amount
        } else {
            0
        }
    }

    public(friend) fun unlock_position(arg0: &mut LBPosition) {
        arg0.lock_until = 0;
    }

    public(friend) fun update_fee_info(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, LBBinPosition>(&v0.bins, arg2)) {
            let v1 = 0x2::table::borrow_mut<u32, LBBinPosition>(&mut v0.bins, arg2);
            v1.fee_growth_inside_last_x = arg3;
            v1.fee_growth_inside_last_y = arg4;
        };
    }

    public(friend) fun update_reward_per_fee_snapshot(arg0: &mut LBPositionInfo, arg1: u64, arg2: u128) {
        while (0x1::vector::length<u128>(&arg0.fee_reward_info.reward_per_fee_snapshot) <= arg1) {
            0x1::vector::push_back<u128>(&mut arg0.fee_reward_info.reward_per_fee_snapshot, 0);
        };
        *0x1::vector::borrow_mut<u128>(&mut arg0.fee_reward_info.reward_per_fee_snapshot, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

