module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events {
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

    struct FlashMint has copy, drop {
        config_id: 0x2::object::ID,
        mint_amount: u64,
        fee_amount: u64,
    }

    struct ParamUpdated<phantom T0> has copy, drop {
        param_name: 0x1::ascii::String,
        new_value: u64,
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

    public(friend) fun emit_flash_mint(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FlashMint{
            config_id   : arg0,
            mint_amount : arg1,
            fee_amount  : arg2,
        };
        0x2::event::emit<FlashMint>(v0);
    }

    public(friend) fun emit_param_updated<T0>(arg0: vector<u8>, arg1: u64) {
        let v0 = ParamUpdated<T0>{
            param_name : 0x1::ascii::string(arg0),
            new_value  : arg1,
        };
        0x2::event::emit<ParamUpdated<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

