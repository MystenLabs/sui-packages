module 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::staked_lp {
    struct StakedLP<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        until_timestamp: u64,
    }

    public fun balance<T0>(arg0: &StakedLP<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun join<T0>(arg0: &mut StakedLP<T0>, arg1: StakedLP<T0>) {
        let StakedLP {
            id              : v0,
            balance         : v1,
            until_timestamp : v2,
        } = arg1;
        let v3 = if (v2 > arg0.until_timestamp) {
            v2
        } else {
            arg0.until_timestamp
        };
        arg0.until_timestamp = v3;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
    }

    public fun split<T0>(arg0: &mut StakedLP<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : StakedLP<T0> {
        StakedLP<T0>{
            id              : 0x2::object::new(arg2),
            balance         : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            until_timestamp : arg0.until_timestamp,
        }
    }

    public(friend) fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakedLP<T0> {
        StakedLP<T0>{
            id              : 0x2::object::new(arg3),
            balance         : arg0,
            until_timestamp : 0x2::clock::timestamp_ms(arg2) + arg1,
        }
    }

    public fun default_sell_delay_ms() : u64 {
        43200000
    }

    public fun into_token<T0>(arg0: StakedLP<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let StakedLP {
            id              : v0,
            balance         : v1,
            until_timestamp : v2,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::errors::lp_stake_time_not_passed());
        0x2::object::delete(v0);
        0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::token_ir::from_balance<T0>(arg2, v1, arg3)
    }

    // decompiled from Move bytecode v6
}

