module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state {
    struct State has drop, store {
        total_supply: u64,
        total_borrow: u64,
        supply_shares: u64,
        borrow_shares: u64,
        last_update_timestamp: u64,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public(friend) fun borrow_ratio(arg0: &State) : u64 {
        if (arg0.borrow_shares == 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling()
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg0.total_borrow, arg0.borrow_shares)
        }
    }

    public(friend) fun borrow_shares(arg0: &State) : u64 {
        arg0.borrow_shares
    }

    public(friend) fun borrow_shares_to_amount(arg0: &State, arg1: u64, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0.borrow_shares == 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling()
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg0.total_borrow + 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::calculate_interest_with_borrow(arg2, utilization_rate(arg0), 0x2::clock::timestamp_ms(arg3) - arg0.last_update_timestamp, arg0.total_borrow), arg0.borrow_shares)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul_round_up(arg1, v0)
    }

    public(friend) fun decrease_borrow_shares(arg0: &mut State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg2, borrow_ratio(arg0));
        arg0.borrow_shares = arg0.borrow_shares - arg2;
        arg0.total_borrow = arg0.total_borrow - v1;
        (v1, v0)
    }

    public(friend) fun decrease_supply_absolute(arg0: &mut State, arg1: u64) {
        arg0.total_supply = arg0.total_supply - arg1;
    }

    public(friend) fun decrease_supply_shares(arg0: &mut State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg2, supply_ratio(arg0));
        arg0.supply_shares = arg0.supply_shares - arg2;
        arg0.total_supply = arg0.total_supply - v1;
        (v1, v0)
    }

    public(friend) fun default(arg0: &0x2::clock::Clock) : State {
        State{
            total_supply          : 0,
            total_borrow          : 0,
            supply_shares         : 0,
            borrow_shares         : 0,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg0),
            extra_fields          : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public(friend) fun increase_borrow(arg0: &mut State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div_round_up(arg2, borrow_ratio(arg0));
        arg0.borrow_shares = arg0.borrow_shares + v1;
        arg0.total_borrow = arg0.total_borrow + arg2;
        (v1, v0)
    }

    public(friend) fun increase_supply(arg0: &mut State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update(arg0, arg1, arg3);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg2, supply_ratio(arg0));
        arg0.supply_shares = arg0.supply_shares + v1;
        arg0.total_supply = arg0.total_supply + arg2;
        (v1, v0)
    }

    public(friend) fun increase_supply_absolute(arg0: &mut State, arg1: u64) {
        arg0.total_supply = arg0.total_supply + arg1;
    }

    public(friend) fun last_update_timestamp(arg0: &State) : u64 {
        arg0.last_update_timestamp
    }

    public(friend) fun supply_ratio(arg0: &State) : u64 {
        if (arg0.supply_shares == 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling()
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg0.total_supply, arg0.supply_shares)
        }
    }

    public(friend) fun supply_shares(arg0: &State) : u64 {
        arg0.supply_shares
    }

    public(friend) fun supply_shares_to_amount(arg0: &State, arg1: u64, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::calculate_interest_with_borrow(arg2, utilization_rate(arg0), 0x2::clock::timestamp_ms(arg3) - arg0.last_update_timestamp, arg0.total_borrow);
        let v1 = if (arg0.supply_shares == 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling()
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg0.total_supply + v0 - 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(v0, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::protocol_spread(arg2)), arg0.supply_shares)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg1, v1)
    }

    public(friend) fun total_borrow(arg0: &State) : u64 {
        arg0.total_borrow
    }

    public(friend) fun total_supply(arg0: &State) : u64 {
        arg0.total_supply
    }

    public(friend) fun total_supply_with_interest(arg0: &State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::calculate_interest_with_borrow(arg1, utilization_rate(arg0), 0x2::clock::timestamp_ms(arg2) - arg0.last_update_timestamp, arg0.total_borrow);
        arg0.total_supply + v0 - 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(v0, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::protocol_spread(arg1))
    }

    public(friend) fun update(arg0: &mut State, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::calculate_interest_with_borrow(arg1, utilization_rate(arg0), v0 - arg0.last_update_timestamp, arg0.total_borrow);
        let v2 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(v1, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::protocol_spread(arg1));
        arg0.total_supply = arg0.total_supply + v1 - v2;
        arg0.total_borrow = arg0.total_borrow + v1;
        arg0.last_update_timestamp = v0;
        v2
    }

    public(friend) fun utilization_rate(arg0: &State) : u64 {
        if (arg0.total_supply == 0) {
            0
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg0.total_borrow, arg0.total_supply)
        }
    }

    // decompiled from Move bytecode v6
}

