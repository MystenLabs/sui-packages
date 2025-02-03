module 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::staked_lp {
    struct StakedLP<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        until_timestamp: u64,
    }

    public fun balance<T0>(arg0: &StakedLP<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : StakedLP<T0> {
        StakedLP<T0>{
            id              : 0x2::object::new(arg2),
            balance         : arg0,
            until_timestamp : 0x2::clock::timestamp_ms(arg1) + 43200000,
        }
    }

    public fun into_token<T0>(arg0: StakedLP<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let StakedLP {
            id              : v0,
            balance         : v1,
            until_timestamp : v2,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::errors::lp_stake_time_not_passed());
        0x2::object::delete(v0);
        0xc40d4458780a716ba9b65563a54e09e2caf003f27d0aa193daacc24b7e2b54a4::token_ir::from_balance<T0>(arg2, v1, arg3)
    }

    // decompiled from Move bytecode v6
}

