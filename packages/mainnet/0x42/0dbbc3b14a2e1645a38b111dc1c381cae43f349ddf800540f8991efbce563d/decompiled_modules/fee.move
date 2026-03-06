module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee {
    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
        fee_collector: address,
    }

    struct LiquidationFeeConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
        fee_collector: address,
    }

    public fun get_fee_collector(arg0: &FeeConfig) : address {
        arg0.fee_collector
    }

    public fun get_fee_rate(arg0: &FeeConfig) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        arg0.fee_rate
    }

    public fun get_liquidation_fee_collector(arg0: &LiquidationFeeConfig) : address {
        arg0.fee_collector
    }

    public fun get_liquidation_fee_rate(arg0: &LiquidationFeeConfig) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        arg0.fee_rate
    }

    public(friend) fun new_fee_config(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : FeeConfig {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::one();
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::zero();
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::lt(&arg0, &v0), 1001);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::gt(&arg0, &v1), 1001);
        assert!(arg1 != @0x0, 1002);
        FeeConfig{
            id            : 0x2::object::new(arg2),
            fee_rate      : arg0,
            fee_collector : arg1,
        }
    }

    public(friend) fun new_liquidation_fee_config(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LiquidationFeeConfig {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::one();
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::zero();
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::lt(&arg0, &v0), 1001);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::gt(&arg0, &v1), 1001);
        assert!(arg1 != @0x0, 1002);
        LiquidationFeeConfig{
            id            : 0x2::object::new(arg2),
            fee_rate      : arg0,
            fee_collector : arg1,
        }
    }

    public(friend) fun set_fee_config_rate(arg0: &mut FeeConfig, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg2: address) {
        arg0.fee_rate = arg1;
        arg0.fee_collector = arg2;
    }

    public(friend) fun set_liquidation_fee_config_rate(arg0: &mut LiquidationFeeConfig, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg2: address) {
        arg0.fee_rate = arg1;
        arg0.fee_collector = arg2;
    }

    // decompiled from Move bytecode v6
}

