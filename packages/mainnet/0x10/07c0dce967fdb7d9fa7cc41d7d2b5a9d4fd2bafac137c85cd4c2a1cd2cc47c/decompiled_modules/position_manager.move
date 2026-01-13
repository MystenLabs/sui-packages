module 0x1007c0dce967fdb7d9fa7cc41d7d2b5a9d4fd2bafac137c85cd4c2a1cd2cc47c::position_manager {
    struct PositionManager has store {
        positions: 0x2::table::Table<0x2::object::ID, Position>,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct Position has store {
        shares: u64,
        referral: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_supply_entry(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>) {
        if (!0x2::table::contains<0x2::object::ID, Position>(&arg0.positions, arg1)) {
            let v0 = Position{
                shares   : 0,
                referral : arg2,
            };
            0x2::table::add<0x2::object::ID, Position>(&mut arg0.positions, arg1, v0);
        };
    }

    public(friend) fun create_position_manager(arg0: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            positions    : 0x2::table::new<0x2::object::ID, Position>(arg0),
            extra_fields : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public(friend) fun decrease_user_supply(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64) : (u64, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, arg1);
        v0.shares = v0.shares - arg2;
        (v0.shares, v0.referral)
    }

    public(friend) fun increase_user_supply(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (u64, 0x1::option::Option<0x2::object::ID>) {
        add_supply_entry(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, arg1);
        v0.shares = v0.shares + arg3;
        v0.referral = arg2;
        (v0.shares, v0.referral)
    }

    public(friend) fun user_supply_shares(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, Position>(&arg0.positions, arg1)) {
            0x2::table::borrow<0x2::object::ID, Position>(&arg0.positions, arg1).shares
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

