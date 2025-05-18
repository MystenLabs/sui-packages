module 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::fee {
    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate,
        fee_collector: address,
    }

    public fun get_fee_collector(arg0: &FeeConfig) : address {
        arg0.fee_collector
    }

    public fun get_fee_rate(arg0: &FeeConfig) : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate {
        arg0.fee_rate
    }

    public(friend) fun new_fee_config(arg0: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : FeeConfig {
        let v0 = 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::one();
        let v1 = 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::zero();
        assert!(0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::lt(&arg0, &v0), 1001);
        assert!(0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::gt(&arg0, &v1), 1001);
        assert!(arg1 != @0x0, 1002);
        FeeConfig{
            id            : 0x2::object::new(arg2),
            fee_rate      : arg0,
            fee_collector : arg1,
        }
    }

    public(friend) fun set_fee_config_rate(arg0: &mut FeeConfig, arg1: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate, arg2: address) {
        arg0.fee_rate = arg1;
        arg0.fee_collector = arg2;
    }

    // decompiled from Move bytecode v6
}

