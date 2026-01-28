module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee {
    struct CollateralFee has copy, drop, store {
        mint: 0x1::option::Option<u16>,
        redeem: 0x1::option::Option<u16>,
    }

    public fun apply_default_mint_fee(arg0: &mut CollateralFee) {
        arg0.mint = 0x1::option::some<u16>(0);
    }

    public fun apply_default_redeem_fee(arg0: &mut CollateralFee) {
        arg0.redeem = 0x1::option::some<u16>(0);
    }

    public fun apply_mint_fee_exemption(arg0: &mut CollateralFee) {
        arg0.mint = 0x1::option::none<u16>();
    }

    public fun apply_redeem_fee_exemption(arg0: &mut CollateralFee) {
        arg0.redeem = 0x1::option::none<u16>();
    }

    public fun calculate_mint_fee(arg0: &CollateralFee, arg1: &CollateralFee) : u16 {
        if (use_default_mint_fees(arg0)) {
            let v0 = mint_fee(arg1);
            return if (0x1::option::is_some<u16>(&v0)) {
                0x1::option::destroy_some<u16>(v0)
            } else {
                0x1::option::destroy_none<u16>(v0);
                0
            }
        };
        if (is_mint_fee_exempt(arg0)) {
            return 0
        };
        0x1::option::destroy_some<u16>(mint_fee(arg0))
    }

    public fun calculate_redeem_fee(arg0: &CollateralFee, arg1: &CollateralFee) : u16 {
        if (use_default_redeem_fees(arg0)) {
            let v0 = redeem_fee(arg1);
            return if (0x1::option::is_some<u16>(&v0)) {
                0x1::option::destroy_some<u16>(v0)
            } else {
                0x1::option::destroy_none<u16>(v0);
                0
            }
        };
        if (is_redeem_fee_exempt(arg0)) {
            return 0
        };
        0x1::option::destroy_some<u16>(redeem_fee(arg0))
    }

    public fun is_mint_fee_exempt(arg0: &CollateralFee) : bool {
        0x1::option::is_none<u16>(&arg0.mint)
    }

    public fun is_redeem_fee_exempt(arg0: &CollateralFee) : bool {
        0x1::option::is_none<u16>(&arg0.redeem)
    }

    public fun mint_fee(arg0: &CollateralFee) : 0x1::option::Option<u16> {
        arg0.mint
    }

    public fun new(arg0: 0x1::option::Option<u16>, arg1: 0x1::option::Option<u16>) : CollateralFee {
        let v0 = CollateralFee{
            mint   : arg0,
            redeem : arg1,
        };
        validate(&v0);
        v0
    }

    public fun new_exempt() : CollateralFee {
        CollateralFee{
            mint   : 0x1::option::none<u16>(),
            redeem : 0x1::option::none<u16>(),
        }
    }

    public fun new_with_default() : CollateralFee {
        CollateralFee{
            mint   : 0x1::option::some<u16>(0),
            redeem : 0x1::option::some<u16>(0),
        }
    }

    public fun redeem_fee(arg0: &CollateralFee) : 0x1::option::Option<u16> {
        arg0.redeem
    }

    public fun set_mint_fee(arg0: &mut CollateralFee, arg1: u16) {
        arg0.mint = 0x1::option::some<u16>(arg1);
        validate(arg0);
    }

    public fun set_redeem_fee(arg0: &mut CollateralFee, arg1: u16) {
        arg0.redeem = 0x1::option::some<u16>(arg1);
        validate(arg0);
    }

    public fun use_default_mint_fees(arg0: &CollateralFee) : bool {
        let v0 = &arg0.mint;
        if (0x1::option::is_some<u16>(v0)) {
            let v2 = 0;
            0x1::option::borrow<u16>(v0) == &v2
        } else {
            false
        }
    }

    public fun use_default_redeem_fees(arg0: &CollateralFee) : bool {
        let v0 = &arg0.redeem;
        if (0x1::option::is_some<u16>(v0)) {
            let v2 = 0;
            0x1::option::borrow<u16>(v0) == &v2
        } else {
            false
        }
    }

    fun validate(arg0: &CollateralFee) {
        let v0 = if (0x1::option::is_none<u16>(&arg0.mint)) {
            true
        } else {
            let v1 = &arg0.mint;
            0x1::option::is_some<u16>(v1) && (*0x1::option::borrow<u16>(v1) as u64) <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_fee_bps()
        };
        assert!(v0, 13835340019885146113);
        let v2 = if (0x1::option::is_none<u16>(&arg0.redeem)) {
            true
        } else {
            let v3 = &arg0.redeem;
            0x1::option::is_some<u16>(v3) && (*0x1::option::borrow<u16>(v3) as u64) <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_fee_bps()
        };
        assert!(v2, 13835340037065015297);
    }

    // decompiled from Move bytecode v6
}

