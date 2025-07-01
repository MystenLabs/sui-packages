module 0xd5f2c1d426f930bd9b1b4f99cbb5f00596ba91351bd921c3bf6fd59f87285e50::lb_position {
    struct LBPositionManager has store {
        position_index: u64,
        total_supplies: 0x2::table::Table<u32, u128>,
        positions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, LBPositionInfo>,
    }

    struct LBPositionInfo has store {
        position_id: 0x2::object::ID,
        tokens: 0x2::table::Table<u32, u128>,
        fee_growth_inside_last_x: 0x2::table::Table<u32, u128>,
        fee_growth_inside_last_y: 0x2::table::Table<u32, u128>,
        fees_pending_x: 0x2::table::Table<u32, u64>,
        fees_pending_y: 0x2::table::Table<u32, u64>,
    }

    struct LBPosition has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        index: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct LB_POSITION has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LBPositionManager {
        LBPositionManager{
            position_index : 0,
            total_supplies : 0x2::table::new<u32, u128>(arg0),
            positions      : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, LBPositionInfo>(arg0),
        }
    }

    public fun is_empty(arg0: &LBPositionInfo) : bool {
        0x2::table::is_empty<u32, u128>(&arg0.tokens)
    }

    public fun borrow_mut_position_info(arg0: &mut LBPositionManager, arg1: 0x2::object::ID) : &mut LBPositionInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    public fun borrow_position_info(arg0: &LBPositionManager, arg1: 0x2::object::ID) : &LBPositionInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, LBPositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    public fun calculate_fees_owed(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, u128>(&v0.tokens, arg2)) {
            let v1 = *0x2::table::borrow<u32, u128>(&v0.tokens, arg2);
            if (v1 == 0) {
                return (0, 0)
            };
            let v2 = if (0x2::table::contains<u32, u128>(&v0.fee_growth_inside_last_x, arg2)) {
                *0x2::table::borrow<u32, u128>(&v0.fee_growth_inside_last_x, arg2)
            } else {
                0
            };
            let v3 = if (0x2::table::contains<u32, u128>(&v0.fee_growth_inside_last_y, arg2)) {
                *0x2::table::borrow<u32, u128>(&v0.fee_growth_inside_last_y, arg2)
            } else {
                0
            };
            return (((v1 * (arg3 - v2) >> 64) as u64), ((v1 * (arg4 - v3) >> 64) as u64))
        };
        (0, 0)
    }

    public(friend) fun close_position(arg0: &mut LBPositionManager, arg1: LBPosition) {
        let v0 = 0x2::object::id<LBPosition>(&arg1);
        let v1 = borrow_mut_position_info(arg0, v0);
        if (!is_empty(v1)) {
            abort 7
        };
        destroy_position_info(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v0));
        destroy(arg1);
    }

    public(friend) fun collect_fees(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        let (v0, v1) = calculate_fees_owed(arg0, arg1, arg2, arg3, arg4);
        let v2 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, u64>(&v2.fees_pending_x, arg2)) {
            let v3 = 0x2::table::borrow_mut<u32, u64>(&mut v2.fees_pending_x, arg2);
            *v3 = *v3 + v0;
        } else {
            0x2::table::add<u32, u64>(&mut v2.fees_pending_x, arg2, v0);
        };
        if (0x2::table::contains<u32, u64>(&v2.fees_pending_y, arg2)) {
            let v4 = 0x2::table::borrow_mut<u32, u64>(&mut v2.fees_pending_y, arg2);
            *v4 = *v4 + v1;
        } else {
            0x2::table::add<u32, u64>(&mut v2.fees_pending_y, arg2, v1);
        };
        update_fee_info(arg0, arg1, arg2, arg3, arg4);
        (v0, v1)
    }

    public(friend) fun decrease_liquidity(arg0: &mut LBPositionManager, arg1: &mut LBPosition, arg2: u32, arg3: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = &mut v0.tokens;
        assert!(0x2::table::contains<u32, u128>(v1, arg2), 3);
        let v2 = 0x2::table::borrow_mut<u32, u128>(v1, arg2);
        if (arg3 == 0) {
            return *v2
        };
        assert!(*v2 >= arg3, 4);
        *v2 = *v2 - arg3;
        if (*v2 == 0) {
            0x2::table::remove<u32, u128>(v1, arg2);
        };
        let v3 = 0x2::table::borrow_mut<u32, u128>(&mut arg0.total_supplies, arg2);
        assert!(*v3 >= arg3, 2);
        *v3 = *v3 - arg3;
        *v3
    }

    fun destroy(arg0: LBPosition) {
        let LBPosition {
            id          : v0,
            pair_id     : _,
            index       : _,
            coin_type_a : _,
            coin_type_b : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_position_info(arg0: LBPositionInfo) {
        let LBPositionInfo {
            position_id              : _,
            tokens                   : v1,
            fee_growth_inside_last_x : v2,
            fee_growth_inside_last_y : v3,
            fees_pending_x           : v4,
            fees_pending_y           : v5,
        } = arg0;
        0x2::table::drop<u32, u128>(v1);
        0x2::table::drop<u32, u128>(v2);
        0x2::table::drop<u32, u128>(v3);
        0x2::table::drop<u32, u64>(v4);
        0x2::table::drop<u32, u64>(v5);
    }

    public fun get_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : (u64, u64) {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = if (0x2::table::contains<u32, u64>(&v0.fees_pending_x, arg2)) {
            *0x2::table::borrow<u32, u64>(&v0.fees_pending_x, arg2)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<u32, u64>(&v0.fees_pending_y, arg2)) {
            *0x2::table::borrow<u32, u64>(&v0.fees_pending_y, arg2)
        } else {
            0
        };
        (v1, v2)
    }

    public fun get_tokens_in_position(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u32) : (vector<u32>, vector<u128>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        while (arg2 <= arg3) {
            if (0x2::table::contains<u32, u128>(&v2.tokens, arg2)) {
                let v3 = *0x2::table::borrow<u32, u128>(&v2.tokens, arg2);
                if (v3 > 0) {
                    0x1::vector::push_back<u32>(&mut v0, arg2);
                    0x1::vector::push_back<u128>(&mut v1, v3);
                };
            };
            arg2 = arg2 + 1;
        };
        (v0, v1)
    }

    public fun get_total_pending_fees(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u32) : (u64, u64) {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = 0;
        let v2 = 0;
        while (arg2 <= arg3) {
            if (0x2::table::contains<u32, u64>(&v0.fees_pending_x, arg2)) {
                v1 = v1 + *0x2::table::borrow<u32, u64>(&v0.fees_pending_x, arg2);
            };
            if (0x2::table::contains<u32, u64>(&v0.fees_pending_y, arg2)) {
                v2 = v2 + *0x2::table::borrow<u32, u64>(&v0.fees_pending_y, arg2);
            };
            arg2 = arg2 + 1;
        };
        (v1, v2)
    }

    public fun has_tokens_in_bins(arg0: &LBPositionManager, arg1: &LBPosition, arg2: &vector<u32>) : bool {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            let v2 = *0x1::vector::borrow<u32>(arg2, v1);
            if (0x2::table::contains<u32, u128>(&v0.tokens, v2)) {
                if (*0x2::table::borrow<u32, u128>(&v0.tokens, v2) > 0) {
                    return true
                };
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun increase_liquidity(arg0: &mut LBPositionManager, arg1: &mut LBPosition, arg2: u32, arg3: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = &mut v0.tokens;
        if (0x2::table::contains<u32, u128>(v1, arg2)) {
            let v2 = 0x2::table::borrow_mut<u32, u128>(v1, arg2);
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::add_check(*v2, arg3), 1);
            *v2 = *v2 + arg3;
        } else {
            0x2::table::add<u32, u128>(v1, arg2, arg3);
        };
        let v3 = if (0x2::table::contains<u32, u128>(&arg0.total_supplies, arg2)) {
            0x2::table::borrow_mut<u32, u128>(&mut arg0.total_supplies, arg2)
        } else {
            0x2::table::add<u32, u128>(&mut arg0.total_supplies, arg2, 0);
            0x2::table::borrow_mut<u32, u128>(&mut arg0.total_supplies, arg2)
        };
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::add_check(*v3, arg3), 2);
        *v3 = *v3 + arg3;
        *v3
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.ferra.xyz/position?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra Labs"));
        let v4 = 0x2::package::claim<LB_POSITION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<LBPosition>(&v4, v0, v2, arg1);
        0x2::display::update_version<LBPosition>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LBPosition>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut LBPositionManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : LBPosition {
        let v0 = arg0.position_index + 1;
        let v1 = LBPosition{
            id          : 0x2::object::new(arg2),
            pair_id     : arg1,
            index       : v0,
            coin_type_a : 0x1::type_name::get<T0>(),
            coin_type_b : 0x1::type_name::get<T1>(),
            name        : 0x1::string::utf8(b"Ferra Liquidity Position"),
            description : 0x1::string::utf8(b"Provides liquidity for the Ferra trading pair"),
            url         : 0x1::string::utf8(b"https://ferra.xyz"),
        };
        let v2 = 0x2::object::id<LBPosition>(&v1);
        let v3 = LBPositionInfo{
            position_id              : v2,
            tokens                   : 0x2::table::new<u32, u128>(arg2),
            fee_growth_inside_last_x : 0x2::table::new<u32, u128>(arg2),
            fee_growth_inside_last_y : 0x2::table::new<u32, u128>(arg2),
            fees_pending_x           : 0x2::table::new<u32, u64>(arg2),
            fees_pending_y           : 0x2::table::new<u32, u64>(arg2),
        };
        arg0.position_index = v0;
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, LBPositionInfo>(&mut arg0.positions, v2, v3);
        v1
    }

    public fun pair_id(arg0: &LBPosition) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun position_token_amount(arg0: &LBPositionManager, arg1: &LBPosition, arg2: u32) : u128 {
        let v0 = borrow_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, u128>(&v0.tokens, arg2)) {
            *0x2::table::borrow<u32, u128>(&v0.tokens, arg2)
        } else {
            0
        }
    }

    public fun total_supply(arg0: &LBPositionManager, arg1: u32) : u128 {
        if (0x2::table::contains<u32, u128>(&arg0.total_supplies, arg1)) {
            *0x2::table::borrow<u32, u128>(&arg0.total_supplies, arg1)
        } else {
            0
        }
    }

    public(friend) fun update_fee_info(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32, arg3: u128, arg4: u128) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        if (0x2::table::contains<u32, u128>(&v0.fee_growth_inside_last_x, arg2)) {
            *0x2::table::borrow_mut<u32, u128>(&mut v0.fee_growth_inside_last_x, arg2) = arg3;
        } else {
            0x2::table::add<u32, u128>(&mut v0.fee_growth_inside_last_x, arg2, arg3);
        };
        if (0x2::table::contains<u32, u128>(&v0.fee_growth_inside_last_y, arg2)) {
            *0x2::table::borrow_mut<u32, u128>(&mut v0.fee_growth_inside_last_y, arg2) = arg4;
        } else {
            0x2::table::add<u32, u128>(&mut v0.fee_growth_inside_last_y, arg2, arg4);
        };
    }

    public(friend) fun withdraw_fees(arg0: &mut LBPositionManager, arg1: &LBPosition, arg2: u32) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<LBPosition>(arg1));
        let v1 = if (0x2::table::contains<u32, u64>(&v0.fees_pending_x, arg2)) {
            *0x2::table::borrow_mut<u32, u64>(&mut v0.fees_pending_x, arg2) = 0;
            *0x2::table::borrow<u32, u64>(&v0.fees_pending_x, arg2)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<u32, u64>(&v0.fees_pending_y, arg2)) {
            *0x2::table::borrow_mut<u32, u64>(&mut v0.fees_pending_y, arg2) = 0;
            *0x2::table::borrow<u32, u64>(&v0.fees_pending_y, arg2)
        } else {
            0
        };
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

