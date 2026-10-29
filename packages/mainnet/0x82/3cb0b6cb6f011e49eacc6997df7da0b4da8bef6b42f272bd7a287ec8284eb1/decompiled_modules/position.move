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
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::average_entry_price(arg0.oi_open, arg0.size)
    }

    public(friend) fun compute_bankruptcy_price(arg0: &Position) : u128 {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::bankruptcy_price(is_long(arg0), oi_open(arg0), margin(arg0), size(arg0))
    }

    public(friend) fun compute_funding_fee_per_unit(arg0: &Position, arg1: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg0.index);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(arg1);
        let (v2, v3) = 0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::funding_fee_per_unit(arg0.is_long, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sign(v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sign(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v2, v3)
    }

    public(friend) fun compute_margin_ratio(arg0: &Position, arg1: u128) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        let (v0, v1) = 0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::margin_ratio(arg0.is_long, arg0.size, arg0.margin, arg0.oi_open, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v0, v1)
    }

    public(friend) fun compute_pnl_per_unit(arg0: &Position, arg1: u128) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        let (v0, v1) = 0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::pnl_per_unit(arg0.is_long, arg0.oi_open, arg0.size, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v0, v1)
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
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::is_undercollat(arg0.is_long, arg0.size, arg0.margin, arg0.oi_open, arg1, arg2)
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

    public fun position_commitment(arg0: &Position) : vector<u8> {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::get_hash(0x1::bcs::to_bytes<Position>(arg0))
    }

    public(friend) fun rebase_rewrite(arg0: &mut Position, arg1: vector<u8>, arg2: bool, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex) {
        assert!(position_commitment(arg0) == arg1, 3113);
        if (arg3 == 0) {
            let v0 = if (!arg2) {
                if (arg4 == 0) {
                    if (arg5 == 0) {
                        arg6 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 3114);
        };
        let v1 = Position{
            user    : arg0.user,
            perp_id : arg0.perp_id,
            is_long : arg2,
            size    : arg3,
            margin  : arg4,
            oi_open : arg5,
            mro     : arg6,
            index   : arg7,
        };
        *arg0 = v1;
    }

    public(friend) fun remove_empty_positions(arg0: &mut 0x2::table::Table<address, Position>, arg1: vector<address>, arg2: u64) {
        assert!(0x1::vector::length<address>(&arg1) <= 1000, 99999);
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

    public(friend) fun verify_collat_checks(arg0: &Position, arg1: &Position, arg2: u128, arg3: u128, arg4: u128, arg5: u8, arg6: u64) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::position_math::verify_collat_checks(arg0.is_long, arg0.size, arg0.margin, arg0.oi_open, arg1.is_long, arg1.size, arg1.margin, arg1.oi_open, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

