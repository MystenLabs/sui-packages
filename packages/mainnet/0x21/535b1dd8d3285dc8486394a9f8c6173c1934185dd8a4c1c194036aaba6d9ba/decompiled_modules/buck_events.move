module 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck_events {
    struct BuckMinted has copy, drop {
        collateral_type: 0x1::ascii::String,
        buck_amount: u64,
    }

    struct BuckBurnt has copy, drop {
        collateral_type: 0x1::ascii::String,
        buck_amount: u64,
    }

    struct CollateralIncreased has copy, drop {
        collateral_type: 0x1::ascii::String,
        collateral_amount: u64,
    }

    struct CollateralDecreased has copy, drop {
        collateral_type: 0x1::ascii::String,
        collateral_amount: u64,
    }

    struct FlashLoan has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public(friend) fun emit_buck_burnt<T0>(arg0: u64) {
        let v0 = BuckBurnt{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buck_amount     : arg0,
        };
        0x2::event::emit<BuckBurnt>(v0);
    }

    public(friend) fun emit_buck_minted<T0>(arg0: u64) {
        let v0 = BuckMinted{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buck_amount     : arg0,
        };
        0x2::event::emit<BuckMinted>(v0);
    }

    public(friend) fun emit_collateral_decreased<T0>(arg0: u64) {
        let v0 = CollateralDecreased{
            collateral_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            collateral_amount : arg0,
        };
        0x2::event::emit<CollateralDecreased>(v0);
    }

    public(friend) fun emit_collateral_increased<T0>(arg0: u64) {
        let v0 = CollateralIncreased{
            collateral_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            collateral_amount : arg0,
        };
        0x2::event::emit<CollateralIncreased>(v0);
    }

    public(friend) fun emit_flash_loan<T0>(arg0: u64) {
        let v0 = FlashLoan{
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : arg0,
        };
        0x2::event::emit<FlashLoan>(v0);
    }

    // decompiled from Move bytecode v6
}

