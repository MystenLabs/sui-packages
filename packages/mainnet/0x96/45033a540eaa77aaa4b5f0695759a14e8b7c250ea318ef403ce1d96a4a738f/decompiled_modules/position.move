module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position {
    struct AccountPositionUpdateEvent has copy, drop {
        tx_index: u128,
        position: Position,
        sender: address,
        action: u8,
    }

    struct PositionClosedEvent has copy, drop {
        tx_index: u128,
        perp_id: 0x2::object::ID,
        account: address,
        amount: u128,
    }

    struct Position has copy, drop, store {
        user: address,
        perp_id: 0x2::object::ID,
        is_long: bool,
        size: u128,
        margin: u128,
        oi_open: u128,
        mro: u128,
        index: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex,
    }

    public(friend) fun compute_average_entry_price(arg0: &Position) : u128 {
        if (arg0.size == 0) {
            0
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(arg0.oi_open, arg0.size)
        }
    }

    public(friend) fun compute_bankruptcy_price(arg0: &Position) : u128 {
        if (is_long(arg0)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(oi_open(arg0) - margin(arg0), size(arg0))
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(oi_open(arg0) + margin(arg0), size(arg0))
        }
    }

    public(friend) fun compute_funding_fee_per_unit(arg0: &Position, arg1: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        if (arg0.is_long) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg0.index), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg1))
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg0.index))
        }
    }

    public(friend) fun compute_margin_ratio(arg0: &Position, arg1: u128) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::one();
        let v1 = v0;
        if (arg0.size == 0) {
            return v0
        };
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg1, arg0.size);
        if (arg0.is_long) {
            if (v2 > 0) {
                v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::div_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from_subtraction(arg0.oi_open, arg0.margin), v2));
            };
        } else if (v2 > 0) {
            v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from_subtraction(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(arg0.oi_open + arg0.margin, v2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
        };
        v1
    }

    public(friend) fun compute_pnl_per_unit(arg0: &Position, arg1: u128) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        if (arg0.is_long) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from_subtraction(arg1, compute_average_entry_price(arg0))
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from_subtraction(compute_average_entry_price(arg0), arg1)
        }
    }

    public(friend) fun create_position(arg0: 0x2::object::ID, arg1: &mut 0x2::table::Table<address, Position>, arg2: address) {
        if (!0x2::table::contains<address, Position>(arg1, arg2)) {
            0x2::table::add<address, Position>(arg1, arg2, empty_position(arg0, arg2));
        };
    }

    public(friend) fun emit_position_closed_event(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: u128) {
        let v0 = PositionClosedEvent{
            tx_index : arg3,
            perp_id  : arg0,
            account  : arg1,
            amount   : arg2,
        };
        0x2::event::emit<PositionClosedEvent>(v0);
    }

    public(friend) fun emit_position_update_event(arg0: Position, arg1: address, arg2: u8, arg3: u128) {
        let v0 = AccountPositionUpdateEvent{
            tx_index : arg3,
            position : arg0,
            sender   : arg1,
            action   : arg2,
        };
        0x2::event::emit<AccountPositionUpdateEvent>(v0);
    }

    public(friend) fun empty_position(arg0: 0x2::object::ID, arg1: address) : Position {
        Position{
            user    : arg1,
            perp_id : arg0,
            is_long : false,
            size    : 0,
            margin  : 0,
            oi_open : 0,
            mro     : 0,
            index   : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::new_index(0),
        }
    }

    public(friend) fun index(arg0: &Position) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex {
        arg0.index
    }

    public(friend) fun is_long(arg0: &Position) : bool {
        arg0.is_long
    }

    public(friend) fun is_undercollat(arg0: &Position, arg1: u128, arg2: u128) : bool {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::lt_u128(compute_margin_ratio(arg0, arg1), arg2)
    }

    public(friend) fun margin(arg0: &Position) : u128 {
        arg0.margin
    }

    public(friend) fun mro(arg0: &Position) : u128 {
        arg0.mro
    }

    public(friend) fun oi_open(arg0: &Position) : u128 {
        arg0.oi_open
    }

    public(friend) fun remove_empty_positions(arg0: &mut 0x2::table::Table<address, Position>, arg1: vector<address>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            v0 = v0 + 1;
            if (0x2::table::contains<address, Position>(arg0, v1)) {
                let v2 = 0x2::table::borrow<address, Position>(arg0, v1);
                if (v2.size == 0 && arg2 - 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_timestamp(v2.index) > 604800000) {
                    0x2::table::remove<address, Position>(arg0, v1);
                };
            };
        };
    }

    public(friend) fun set_index(arg0: &mut Position, arg1: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex) {
        arg0.index = arg1;
    }

    public(friend) fun set_is_long(arg0: &mut Position, arg1: bool) {
        arg0.is_long = arg1;
    }

    public(friend) fun set_margin(arg0: &mut Position, arg1: u128) {
        arg0.margin = arg1;
    }

    public(friend) fun set_mro(arg0: &mut Position, arg1: u128) {
        if (arg0.size == 0) {
            arg0.mro = 0;
        } else {
            arg0.mro = arg1;
        };
    }

    public(friend) fun set_oi_open(arg0: &mut Position, arg1: u128) {
        arg0.oi_open = arg1;
    }

    public(friend) fun set_size(arg0: &mut Position, arg1: u128) {
        arg0.size = arg1;
        if (arg1 == 0) {
            set_is_long(arg0, false);
            set_mro(arg0, 0);
        };
    }

    public(friend) fun size(arg0: &Position) : u128 {
        arg0.size
    }

    public(friend) fun user(arg0: &Position) : address {
        arg0.user
    }

    public(friend) fun verify_collat_checks(arg0: &Position, arg1: &Position, arg2: u128, arg3: u128, arg4: u128, arg5: u8, arg6: u64) {
        let v0 = compute_margin_ratio(arg1, arg4);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v0, arg2)) {
            return
        };
        assert!(arg1.is_long == arg0.is_long && arg0.size > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mr_less_than_imr_can_not_open_or_flip_position(arg6));
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte(v0, compute_margin_ratio(arg0, arg4)), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mr_less_than_imr_mr_must_improve(arg6));
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(v0, arg3) || arg0.size >= arg1.size && arg0.is_long == arg1.is_long, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mr_less_than_imr_position_can_only_reduce(arg6));
        let v1 = if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v0, 0)) {
            true
        } else if (arg5 == 2) {
            true
        } else {
            arg5 == 3
        };
        assert!(v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mr_less_than_zero(arg6));
    }

    // decompiled from Move bytecode v6
}

