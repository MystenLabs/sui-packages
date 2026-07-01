module 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events {
    struct UsdlMinted has copy, drop {
        collateral_type: 0x1::ascii::String,
        usdl_amount: u64,
    }

    struct UsdlBurnt has copy, drop {
        collateral_type: 0x1::ascii::String,
        usdl_amount: u64,
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

    struct Liquidation<phantom T0> has copy, drop {
        price_n: u64,
        price_m: u64,
        coll_amount: u64,
        debt_amount: u64,
        tcr: 0x1::option::Option<u64>,
        debtor: address,
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

    public(friend) fun emit_liquidation<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: address) {
        let v0 = Liquidation<T0>{
            price_n     : arg0,
            price_m     : arg1,
            coll_amount : arg2,
            debt_amount : arg3,
            tcr         : arg4,
            debtor      : arg5,
        };
        0x2::event::emit<Liquidation<T0>>(v0);
    }

    public(friend) fun emit_param_updated<T0>(arg0: vector<u8>, arg1: u64) {
        let v0 = ParamUpdated<T0>{
            param_name : 0x1::ascii::string(arg0),
            new_value  : arg1,
        };
        0x2::event::emit<ParamUpdated<T0>>(v0);
    }

    public(friend) fun emit_usdl_burnt<T0>(arg0: u64) {
        let v0 = UsdlBurnt{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            usdl_amount     : arg0,
        };
        0x2::event::emit<UsdlBurnt>(v0);
    }

    public(friend) fun emit_usdl_minted<T0>(arg0: u64) {
        let v0 = UsdlMinted{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            usdl_amount     : arg0,
        };
        0x2::event::emit<UsdlMinted>(v0);
    }

    // decompiled from Move bytecode v7
}

