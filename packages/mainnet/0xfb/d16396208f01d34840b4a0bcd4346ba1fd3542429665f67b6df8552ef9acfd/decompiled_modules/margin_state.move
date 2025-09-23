module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state {
    struct State has drop, store {
        supply: u64,
        borrow: u64,
        supply_shares: u64,
        borrow_shares: u64,
        last_update_timestamp: u64,
    }

    fun borrow_ratio(arg0: &State) : u64 {
        if (arg0.borrow_shares == 0) {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling()
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg0.borrow, arg0.borrow_shares)
        }
    }

    public(friend) fun borrow_shares_to_amount(arg0: &State, arg1: u64, arg2: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0.borrow_shares == 0) {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling()
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg0.borrow_shares, arg0.borrow + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg0.borrow, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::time_adjusted_rate(arg2, utilization_rate(arg0), 0x2::clock::timestamp_ms(arg3) - arg0.last_update_timestamp)))
        };
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg1, v0)
    }

    public(friend) fun decrease_borrow_shares(arg0: &mut State, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg2, borrow_ratio(arg0));
        arg0.borrow_shares = arg0.borrow_shares - arg2;
        arg0.borrow = arg0.borrow - v1;
        (v1, v0)
    }

    public(friend) fun decrease_supply_absolute(arg0: &mut State, arg1: u64) {
        arg0.supply = arg0.supply - arg1;
    }

    public(friend) fun decrease_supply_shares(arg0: &mut State, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg2, supply_ratio(arg0));
        arg0.supply_shares = arg0.supply_shares - arg2;
        arg0.supply = arg0.supply - v1;
        (v1, v0)
    }

    public(friend) fun default(arg0: &0x2::clock::Clock) : State {
        State{
            supply                : 0,
            borrow                : 0,
            supply_shares         : 0,
            borrow_shares         : 0,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public(friend) fun increase_borrow(arg0: &mut State, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        arg0.borrow_shares = arg0.borrow_shares + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg2, borrow_ratio(arg0));
        arg0.borrow = arg0.borrow + arg2;
        (arg0.borrow, arg0.borrow_shares, v0)
    }

    public(friend) fun increase_supply(arg0: &mut State, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg2, supply_ratio(arg0));
        arg0.supply_shares = arg0.supply_shares + v1;
        arg0.supply = arg0.supply + arg2;
        (v1, v0)
    }

    public(friend) fun increase_supply_absolute(arg0: &mut State, arg1: u64) {
        arg0.supply = arg0.supply + arg1;
    }

    public(friend) fun supply(arg0: &State) : u64 {
        arg0.supply
    }

    fun supply_ratio(arg0: &State) : u64 {
        if (arg0.supply_shares == 0) {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling()
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg0.supply, arg0.supply_shares)
        }
    }

    public(friend) fun supply_shares(arg0: &State) : u64 {
        arg0.supply_shares
    }

    public(friend) fun supply_shares_to_amount(arg0: &State, arg1: u64, arg2: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg0.borrow, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::time_adjusted_rate(arg2, utilization_rate(arg0), 0x2::clock::timestamp_ms(arg3) - arg0.last_update_timestamp));
        let v1 = if (arg0.supply_shares == 0) {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling()
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg0.supply + v0 - 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v0, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::protocol_spread(arg2)), arg0.supply_shares)
        };
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg1, v1)
    }

    fun update(arg0: &mut State, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg0.borrow, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::time_adjusted_rate(arg1, utilization_rate(arg0), v0 - arg0.last_update_timestamp));
        let v2 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v1, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::protocol_spread(arg1));
        arg0.supply = arg0.supply + v1 - v2;
        arg0.borrow = arg0.borrow + v1;
        arg0.last_update_timestamp = v0;
        v2
    }

    public(friend) fun utilization_rate(arg0: &State) : u64 {
        if (arg0.supply == 0) {
            0
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg0.borrow, arg0.supply)
        }
    }

    // decompiled from Move bytecode v6
}

