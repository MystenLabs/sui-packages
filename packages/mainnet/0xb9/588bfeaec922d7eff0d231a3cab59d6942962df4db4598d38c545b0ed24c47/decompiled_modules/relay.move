module 0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::relay {
    struct RelayReceipt has drop {
        fee_paid: u64,
        relayed_at: u64,
        vessel_tier: u8,
    }

    struct RelayProcessed has copy, drop {
        fee_paid: u64,
        relayed_at: u64,
    }

    public fun process(arg0: &mut 0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::Harbor, arg1: &0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::HarborCap, arg2: &mut 0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::Vessel, arg3: &0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::VesselCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, RelayReceipt) {
        assert!(0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::harbor_id(arg2) == 0x2::object::id<0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::Harbor>(arg0), 1);
        assert!(0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::is_alive(arg0, arg5), 4);
        assert!(0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::is_alive(arg2, arg5), 3);
        assert!(0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::has_balance(arg0, arg4), 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::touch(arg2, arg3, arg5, arg6);
        let v1 = RelayReceipt{
            fee_paid    : arg4,
            relayed_at  : v0,
            vessel_tier : 0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::vessel::tier(arg2),
        };
        let v2 = RelayProcessed{
            fee_paid   : arg4,
            relayed_at : v0,
        };
        0x2::event::emit<RelayProcessed>(v2);
        (0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::harbor::drain(arg0, arg1, arg4, arg5, arg6), v1)
    }

    public fun receipt_fee(arg0: &RelayReceipt) : u64 {
        arg0.fee_paid
    }

    public fun receipt_tier(arg0: &RelayReceipt) : u8 {
        arg0.vessel_tier
    }

    public fun receipt_time(arg0: &RelayReceipt) : u64 {
        arg0.relayed_at
    }

    // decompiled from Move bytecode v7
}

