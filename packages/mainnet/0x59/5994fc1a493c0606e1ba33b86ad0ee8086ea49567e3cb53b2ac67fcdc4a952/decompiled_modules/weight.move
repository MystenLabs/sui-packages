module 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::weight {
    struct WeightHook<phantom T0> has store, key {
        id: 0x2::object::UID,
        validator_addresses_and_weights: 0x2::vec_map::VecMap<address, u64>,
        total_weight: u64,
        admin_cap: 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::AdminCap<T0>,
        version: 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::version::Version,
        extra_fields: 0x2::bag::Bag,
    }

    struct WeightHookAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0>(arg0: 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (WeightHook<T0>, WeightHookAdminCap<T0>) {
        let v0 = WeightHook<T0>{
            id                              : 0x2::object::new(arg1),
            validator_addresses_and_weights : 0x2::vec_map::empty<address, u64>(),
            total_weight                    : 0,
            admin_cap                       : arg0,
            version                         : 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::version::new(1),
            extra_fields                    : 0x2::bag::new(arg1),
        };
        let v1 = WeightHookAdminCap<T0>{id: 0x2::object::new(arg1)};
        (v0, v1)
    }

    public fun eject<T0>(arg0: WeightHook<T0>, arg1: WeightHookAdminCap<T0>) : 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::AdminCap<T0> {
        0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let WeightHookAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let WeightHook {
            id                              : v1,
            validator_addresses_and_weights : _,
            total_weight                    : _,
            admin_cap                       : v4,
            version                         : _,
            extra_fields                    : v6,
        } = arg0;
        0x2::bag::destroy_empty(v6);
        0x2::object::delete(v1);
        v4
    }

    public fun rebalance<T0>(arg0: &mut WeightHook<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (arg0.total_weight == 0) {
            return
        };
        0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::refresh<T0>(arg2, arg1, arg3);
        let v0 = arg0.validator_addresses_and_weights;
        let v1 = 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::validators(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::storage<T0>(arg2));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::ValidatorInfo>(v1)) {
            let v3 = 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::validator_address(0x1::vector::borrow<0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::ValidatorInfo>(v1, v2));
            if (!0x2::vec_map::contains<address, u64>(&v0, &v3)) {
                0x2::vec_map::insert<address, u64>(&mut v0, v3, 0);
            };
            v2 = v2 + 1;
        };
        let (v4, v5) = 0x2::vec_map::into_keys_values<address, u64>(v0);
        let v6 = v4;
        let v7 = vector[];
        let v8 = v5;
        0x1::vector::reverse<u64>(&mut v8);
        while (!0x1::vector::is_empty<u64>(&v8)) {
            0x1::vector::push_back<u64>(&mut v7, (((0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::total_sui_supply(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::storage<T0>(arg2)) as u128) * (0x1::vector::pop_back<u64>(&mut v8) as u128) / (arg0.total_weight as u128)) as u64));
        };
        0x1::vector::destroy_empty<u64>(v8);
        let v9 = &v6;
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(v9)) {
            let v12 = 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::find_validator_index_by_address(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::storage<T0>(arg2), *0x1::vector::borrow<address>(v9, v11));
            let v13 = if (v12 >= 0x1::vector::length<0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::ValidatorInfo>(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::validators(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::storage<T0>(arg2)))) {
                0
            } else {
                0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::total_sui_amount(0x1::vector::borrow<0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::ValidatorInfo>(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::storage::validators(0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::storage<T0>(arg2)), v12))
            };
            0x1::vector::push_back<u64>(&mut v10, v13);
            v11 = v11 + 1;
        };
        let v14 = 0;
        while (v14 < 0x1::vector::length<address>(&v6)) {
            if (*0x1::vector::borrow<u64>(&v10, v14) > *0x1::vector::borrow<u64>(&v7, v14)) {
                0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::decrease_validator_stake<T0>(arg2, &arg0.admin_cap, arg1, *0x1::vector::borrow<address>(&v6, v14), *0x1::vector::borrow<u64>(&v10, v14) - *0x1::vector::borrow<u64>(&v7, v14), arg3);
            };
            v14 = v14 + 1;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(&v6)) {
            if (*0x1::vector::borrow<u64>(&v10, v15) < *0x1::vector::borrow<u64>(&v7, v15)) {
                0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::liquid_staking::increase_validator_stake<T0>(arg2, &arg0.admin_cap, arg1, *0x1::vector::borrow<address>(&v6, v15), *0x1::vector::borrow<u64>(&v7, v15) - *0x1::vector::borrow<u64>(&v10, v15), arg3);
            };
            v15 = v15 + 1;
        };
    }

    public fun set_validator_addresses_and_weights<T0>(arg0: &mut WeightHook<T0>, arg1: &WeightHookAdminCap<T0>, arg2: 0x2::vec_map::VecMap<address, u64>) {
        0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::version::assert_version_and_upgrade(&mut arg0.version, 1);
        arg0.validator_addresses_and_weights = arg2;
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<address, u64>(&arg0.validator_addresses_and_weights);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.validator_addresses_and_weights, v2);
            v0 = v0 + *v4;
            v2 = v2 + 1;
        };
        arg0.total_weight = v0;
    }

    // decompiled from Move bytecode v6
}

