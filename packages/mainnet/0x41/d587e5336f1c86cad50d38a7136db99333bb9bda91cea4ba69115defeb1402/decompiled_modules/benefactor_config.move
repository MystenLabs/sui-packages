module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config {
    struct BenefactorConfig has store {
        enabled: bool,
        collateral_fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>,
        limiter: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter,
        nonces: 0x2::table::Table<0x1::string::String, bool>,
    }

    public(friend) fun new(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits, arg1: &mut 0x2::tx_context::TxContext) : BenefactorConfig {
        BenefactorConfig{
            enabled         : true,
            collateral_fees : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(),
            limiter         : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::new(arg0),
            nonces          : 0x2::table::new<0x1::string::String, bool>(arg1),
        }
    }

    public(friend) fun add_nonce(arg0: &mut BenefactorConfig, arg1: 0x1::string::String) {
        assert_is_enabled(arg0);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.nonces, arg1), 13835621262933753859);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.nonces, arg1, true);
    }

    public(friend) fun assert_is_enabled(arg0: &BenefactorConfig) {
        assert!(arg0.enabled, 13835339723532402689);
    }

    public(friend) fun collateral_fees<T0>(arg0: &BenefactorConfig) : 0x1::option::Option<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&arg0.collateral_fees, &v0)) {
            0x1::option::some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(*0x2::vec_map::get<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&arg0.collateral_fees, &v0))
        } else {
            0x1::option::none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>()
        }
    }

    public(friend) fun collateral_fees_mut<T0>(arg0: &mut BenefactorConfig) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&arg0.collateral_fees, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&mut arg0.collateral_fees, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::new_with_default());
        };
        0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&mut arg0.collateral_fees, &v0)
    }

    public(friend) fun destroy(arg0: BenefactorConfig) {
        let BenefactorConfig {
            enabled         : _,
            collateral_fees : _,
            limiter         : _,
            nonces          : v3,
        } = arg0;
        0x2::table::drop<0x1::string::String, bool>(v3);
    }

    public(friend) fun is_enabled(arg0: &BenefactorConfig) : bool {
        arg0.enabled
    }

    public(friend) fun limiter(arg0: &BenefactorConfig) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        assert_is_enabled(arg0);
        &arg0.limiter
    }

    public(friend) fun limiter_mut(arg0: &mut BenefactorConfig) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        assert_is_enabled(arg0);
        &mut arg0.limiter
    }

    public(friend) fun set_enabled(arg0: &mut BenefactorConfig, arg1: bool) {
        arg0.enabled = arg1;
    }

    // decompiled from Move bytecode v6
}

