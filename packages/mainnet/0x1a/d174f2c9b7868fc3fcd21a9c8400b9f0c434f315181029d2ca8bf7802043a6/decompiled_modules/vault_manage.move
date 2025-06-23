module 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_manage {
    public fun set_operator_freezed(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::operation::Operation, arg2: address, arg3: bool) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::operation::set_operator_freezed(arg1, arg2, arg3);
    }

    public fun create_operator_cap(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::OperatorCap {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::create_operator_cap(arg0, arg1)
    }

    public fun retrieve_deposit_withdraw_fee<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::retrieve_deposit_withdraw_fee<T0>(arg1, arg2)
    }

    public fun retrieve_performance_fee<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::retrieve_performance_fee<T0>(arg1, arg2)
    }

    public fun set_deposit_fee<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg2: u64) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::set_deposit_fee<T0>(arg1, arg2);
    }

    public fun set_loss_tolerance<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg2: u256) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::set_loss_tolerance<T0>(arg1, arg2);
    }

    public fun set_withdraw_fee<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg2: u64) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::set_withdraw_fee<T0>(arg1, arg2);
    }

    public fun upgrade_vault<T0>(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::upgrade_vault<T0>(arg1);
    }

    public fun add_switchboard_aggregator(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::add_switchboard_aggregator(arg1, arg2, arg3, arg4);
    }

    public fun set_update_interval(arg0: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::AdminCap, arg1: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::OracleConfig, arg2: u64) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::set_update_interval(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

