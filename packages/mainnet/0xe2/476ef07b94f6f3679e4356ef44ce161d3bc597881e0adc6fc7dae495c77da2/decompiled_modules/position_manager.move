module 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::position_manager {
    struct PositionManager has store {
        supply_shares: 0x2::table::Table<address, u64>,
    }

    public(friend) fun add_supply_entry(arg0: &mut PositionManager, arg1: address) {
        if (!0x2::table::contains<address, u64>(&arg0.supply_shares, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.supply_shares, arg1, 0);
        };
    }

    public(friend) fun create_position_manager(arg0: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{supply_shares: 0x2::table::new<address, u64>(arg0)}
    }

    public(friend) fun decrease_user_supply_shares(arg0: &mut PositionManager, arg1: address, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.supply_shares, arg1);
        *v0 = *v0 - arg2;
        *v0
    }

    public(friend) fun increase_user_supply_shares(arg0: &mut PositionManager, arg1: address, arg2: u64) : u64 {
        add_supply_entry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.supply_shares, arg1);
        *v0 = *v0 + arg2;
        *v0
    }

    public(friend) fun user_supply_shares(arg0: &PositionManager, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.supply_shares, arg1)
    }

    // decompiled from Move bytecode v6
}

