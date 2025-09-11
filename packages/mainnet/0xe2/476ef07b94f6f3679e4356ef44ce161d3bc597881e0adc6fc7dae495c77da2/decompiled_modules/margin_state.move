module 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_state {
    struct State has drop, store {
        total_supply: u64,
        total_borrow: u64,
        supply_index: u64,
        borrow_index: u64,
        last_index_update_timestamp: u64,
    }

    public(friend) fun borrow_index(arg0: &State) : u64 {
        arg0.borrow_index
    }

    public(friend) fun decrease_total_borrow(arg0: &mut State, arg1: u64) {
        arg0.total_borrow = arg0.total_borrow - arg1;
    }

    public(friend) fun decrease_total_supply(arg0: &mut State, arg1: u64) {
        arg0.total_supply = arg0.total_supply - arg1;
    }

    public(friend) fun decrease_total_supply_with_index(arg0: &mut State, arg1: u64) {
        let v0 = arg0.total_supply;
        let v1 = v0 - arg1;
        arg0.total_supply = v1;
        arg0.supply_index = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.supply_index, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(v1, v0));
    }

    public(friend) fun default(arg0: &0x2::clock::Clock) : State {
        State{
            total_supply                : 0,
            total_borrow                : 0,
            supply_index                : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling(),
            borrow_index                : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling(),
            last_index_update_timestamp : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public(friend) fun increase_total_borrow(arg0: &mut State, arg1: u64) {
        arg0.total_borrow = arg0.total_borrow + arg1;
    }

    public(friend) fun increase_total_supply(arg0: &mut State, arg1: u64) {
        arg0.total_supply = arg0.total_supply + arg1;
    }

    public(friend) fun increase_total_supply_with_index(arg0: &mut State, arg1: u64) {
        let v0 = arg0.total_supply;
        let v1 = v0 + arg1;
        arg0.total_supply = v1;
        arg0.supply_index = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.supply_index, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(v1, v0));
    }

    public(friend) fun supply_index(arg0: &State) : u64 {
        arg0.supply_index
    }

    public(friend) fun to_borrow_amount(arg0: &State, arg1: u64) : u64 {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg1, arg0.borrow_index)
    }

    public(friend) fun to_borrow_shares(arg0: &State, arg1: u64) : u64 {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, arg0.borrow_index)
    }

    public(friend) fun to_supply_amount(arg0: &State, arg1: u64) : u64 {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg1, arg0.supply_index)
    }

    public(friend) fun to_supply_shares(arg0: &State, arg1: u64) : u64 {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, arg0.supply_index)
    }

    public(friend) fun total_borrow(arg0: &State) : u64 {
        arg0.total_borrow
    }

    public(friend) fun total_supply(arg0: &State) : u64 {
        arg0.total_supply
    }

    public(friend) fun total_supply_shares(arg0: &State) : u64 {
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.total_supply, arg0.supply_index)
    }

    public(friend) fun update(arg0: &mut State, arg1: &0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::protocol_config::ProtocolConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.last_index_update_timestamp == v0) {
            return 0
        };
        let v1 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.total_borrow, 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::protocol_config::time_adjusted_rate(arg1, utilization_rate(arg0), v0 - arg0.last_index_update_timestamp));
        let v2 = arg0.total_supply + v1;
        let v3 = arg0.total_borrow + v1;
        update_supply_index(arg0, v2);
        update_borrow_index(arg0, v3);
        arg0.last_index_update_timestamp = v0;
        v1
    }

    fun update_borrow_index(arg0: &mut State, arg1: u64) {
        let v0 = if (arg0.total_borrow == 0) {
            arg0.borrow_index
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.borrow_index, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, arg0.total_borrow))
        };
        arg0.borrow_index = v0;
        arg0.total_borrow = arg1;
    }

    fun update_supply_index(arg0: &mut State, arg1: u64) {
        let v0 = if (arg0.total_supply == 0) {
            arg0.supply_index
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.supply_index, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, arg0.total_supply))
        };
        arg0.supply_index = v0;
        arg0.total_supply = arg1;
    }

    public(friend) fun utilization_rate(arg0: &State) : u64 {
        if (arg0.total_supply == 0) {
            0
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg0.total_borrow, arg0.total_supply)
        }
    }

    // decompiled from Move bytecode v6
}

