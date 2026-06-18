module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::paye_engine {
    struct PAYEConfig has key {
        id: 0x2::object::UID,
        dca_share_bps: u64,
        lender_share_bps: u64,
        protocol_fee_bps: u64,
        protocol_treasury: address,
        total_settlements: u64,
        total_yield_distributed: u64,
        total_to_dca: u64,
        total_to_lenders: u64,
        total_to_protocol: u64,
        admin: address,
    }

    struct PAYESettlement has copy, drop {
        settlement_id: u64,
        gross_yield: u64,
        dca_amount: u64,
        lender_amount: u64,
        protocol_amount: u64,
        timestamp: u64,
    }

    public entry fun create_paye_config(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 + arg1 + arg2 == 10000, 400);
        let v0 = PAYEConfig{
            id                      : 0x2::object::new(arg4),
            dca_share_bps           : arg0,
            lender_share_bps        : arg1,
            protocol_fee_bps        : arg2,
            protocol_treasury       : arg3,
            total_settlements       : 0,
            total_yield_distributed : 0,
            total_to_dca            : 0,
            total_to_lenders        : 0,
            total_to_protocol       : 0,
            admin                   : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::share_object<PAYEConfig>(v0);
    }

    public fun dca_share(arg0: &PAYEConfig) : u64 {
        arg0.dca_share_bps
    }

    public fun lender_share(arg0: &PAYEConfig) : u64 {
        arg0.lender_share_bps
    }

    public fun protocol_fee(arg0: &PAYEConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public entry fun settle<T0>(arg0: &mut PAYEConfig, arg1: &mut 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::vault::VaultConfig<T0>, arg2: &mut 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::lending_pool::LendingPool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 401);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v0, arg0.dca_share_bps);
        let v2 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v0, arg0.lender_share_bps);
        let v3 = v0 - v1 - v2;
        let v4 = 0x2::coin::into_balance<T0>(arg3);
        if (v1 > 0) {
            0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::vault::record_compound<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v1), arg5), arg4, arg5);
        };
        if (v2 > 0) {
            0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::lending_pool::distribute_paye_yield<T0>(arg2, 0x2::balance::split<T0>(&mut v4, v2));
        };
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), arg0.protocol_treasury);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        arg0.total_settlements = arg0.total_settlements + 1;
        arg0.total_yield_distributed = arg0.total_yield_distributed + v0;
        arg0.total_to_dca = arg0.total_to_dca + v1;
        arg0.total_to_lenders = arg0.total_to_lenders + v2;
        arg0.total_to_protocol = arg0.total_to_protocol + v3;
        let v5 = PAYESettlement{
            settlement_id   : arg0.total_settlements,
            gross_yield     : v0,
            dca_amount      : v1,
            lender_amount   : v2,
            protocol_amount : v3,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PAYESettlement>(v5);
    }

    public fun total_distributed(arg0: &PAYEConfig) : u64 {
        arg0.total_yield_distributed
    }

    public fun total_settlements(arg0: &PAYEConfig) : u64 {
        arg0.total_settlements
    }

    public fun total_to_dca(arg0: &PAYEConfig) : u64 {
        arg0.total_to_dca
    }

    public fun total_to_lenders(arg0: &PAYEConfig) : u64 {
        arg0.total_to_lenders
    }

    public fun total_to_protocol(arg0: &PAYEConfig) : u64 {
        arg0.total_to_protocol
    }

    public entry fun update_split(arg0: &mut PAYEConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 402);
        assert!(arg1 + arg2 + arg3 == 10000, 400);
        arg0.dca_share_bps = arg1;
        arg0.lender_share_bps = arg2;
        arg0.protocol_fee_bps = arg3;
    }

    // decompiled from Move bytecode v7
}

