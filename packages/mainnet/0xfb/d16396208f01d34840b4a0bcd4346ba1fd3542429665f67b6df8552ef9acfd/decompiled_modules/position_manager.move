module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager {
    struct PositionManager has store {
        positions: 0x2::table::Table<address, Position>,
    }

    struct Position has store {
        shares: u64,
        referral: 0x1::option::Option<address>,
    }

    public(friend) fun add_supply_entry(arg0: &mut PositionManager, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v1 = Position{
                shares   : 0,
                referral : arg1,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v0, v1);
        };
    }

    public(friend) fun create_position_manager(arg0: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{positions: 0x2::table::new<address, Position>(arg0)}
    }

    public(friend) fun decrease_user_supply(arg0: &mut PositionManager, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, 0x1::option::Option<address>) {
        let v0 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, 0x2::tx_context::sender(arg2));
        v0.shares = v0.shares - arg1;
        (v0.shares, v0.referral)
    }

    public(friend) fun increase_user_supply(arg0: &mut PositionManager, arg1: 0x1::option::Option<address>, arg2: u64, arg3: &0x2::tx_context::TxContext) : (u64, 0x1::option::Option<address>) {
        add_supply_entry(arg0, arg1, arg3);
        let v0 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, 0x2::tx_context::sender(arg3));
        v0.shares = v0.shares + arg2;
        v0.referral = arg1;
        (v0.shares, v0.referral)
    }

    public(friend) fun user_supply_shares(arg0: &PositionManager, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            0x2::table::borrow<address, Position>(&arg0.positions, v0).shares
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

