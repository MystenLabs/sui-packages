module 0xa232601389e2328d3c79bdca0400da1389c0f362fff2f27cda7171196aaefcd5::final_clean_arbitrage {
    struct ArbitrageCoordinated has copy, drop {
        user: address,
        input_amount: u64,
        timestamp: u64,
        first_protocol: vector<u8>,
        second_protocol: vector<u8>,
    }

    public fun calculate_profit(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public entry fun coordinate_atomic_arbitrage(arg0: u64, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 10000000) {
            let v0 = ArbitrageCoordinated{
                user            : 0x2::tx_context::sender(arg4),
                input_amount    : arg0,
                timestamp       : arg3,
                first_protocol  : b"TURBOS",
                second_protocol : b"DEEPBOOK",
            };
            0x2::event::emit<ArbitrageCoordinated>(v0);
        };
    }

    public fun get_gas_budget() : u64 {
        50000000
    }

    public fun get_minimum_profit() : u64 {
        1000000
    }

    public fun get_protocol_addresses() : (address, address) {
        (@0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_required_input() : u64 {
        10000000
    }

    public fun is_profitable_after_costs(arg0: u64, arg1: u64) : bool {
        arg0 > arg1
    }

    public fun is_valid_arbitrage(arg0: u64, arg1: u64) : bool {
        arg0 == 10000000 && arg1 > 0
    }

    // decompiled from Move bytecode v6
}

