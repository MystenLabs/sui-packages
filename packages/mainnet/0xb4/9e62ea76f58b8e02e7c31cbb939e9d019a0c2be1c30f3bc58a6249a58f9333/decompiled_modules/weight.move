module 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::weight {
    struct WeightHook<phantom T0> has store, key {
        id: 0x2::object::UID,
        validator_addresses_and_weights: 0x2::vec_map::VecMap<address, u64>,
        total_weight: u64,
        admin_cap: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0>,
        version: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::Version,
        extra_fields: 0x2::bag::Bag,
    }

    struct WeightHookAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct WEIGHT has drop {
        dummy_field: bool,
    }

    struct RegistryInfo has store {
        weight_hook_id: 0x2::object::ID,
    }

    struct CreateEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        weight_hook_id: 0x2::object::ID,
        weight_hook_admin_cap_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (WeightHook<T0>, WeightHookAdminCap<T0>) {
        let v0 = WeightHook<T0>{
            id                              : 0x2::object::new(arg1),
            validator_addresses_and_weights : 0x2::vec_map::empty<address, u64>(),
            total_weight                    : 0,
            admin_cap                       : arg0,
            version                         : 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::new(1),
            extra_fields                    : 0x2::bag::new(arg1),
        };
        let v1 = WeightHookAdminCap<T0>{id: 0x2::object::new(arg1)};
        let v2 = CreateEvent{
            typename                 : 0x1::type_name::get<T0>(),
            weight_hook_id           : *0x2::object::uid_as_inner(&v0.id),
            weight_hook_admin_cap_id : *0x2::object::uid_as_inner(&v1.id),
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<CreateEvent>(v2);
        (v0, v1)
    }

    public fun collect_fees<T0>(arg0: &mut WeightHook<T0>, arg1: &WeightHookAdminCap<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::collect_fees<T0>(arg2, arg3, &arg0.admin_cap, arg4)
    }

    public fun update_fees<T0>(arg0: &mut WeightHook<T0>, arg1: &WeightHookAdminCap<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::update_fees<T0>(arg2, &arg0.admin_cap, arg3);
    }

    public fun update_metadata<T0>(arg0: &WeightHook<T0>, arg1: &WeightHookAdminCap<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x2::coin::CoinMetadata<T0>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::ascii::String>) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::update_metadata<T0>(arg2, &arg0.admin_cap, arg3, arg4, arg5, arg6, arg7);
    }

    public fun add_to_registry<T0>(arg0: &WeightHook<T0>, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::registry::Registry, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>) {
        let v0 = RegistryInfo{weight_hook_id: *0x2::object::uid_as_inner(&arg0.id)};
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::registry::add_to_registry<T0, RegistryInfo>(arg1, &arg0.admin_cap, arg2, v0);
    }

    public fun admin_cap<T0>(arg0: &WeightHook<T0>, arg1: &WeightHookAdminCap<T0>) : &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version(&arg0.version, 1);
        &arg0.admin_cap
    }

    public fun eject<T0>(arg0: WeightHook<T0>, arg1: WeightHookAdminCap<T0>) : 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
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

    public fun handle_custom_redeem_request<T0>(arg0: &mut WeightHook<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::CustomRedeemRequest<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T0>(arg2, arg1, arg4);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_supply(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2)) - 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::lst_amount_to_sui_amount<T0>(arg2, 0x2::coin::value<T0>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::lst<T0>(arg3)));
        rebalance_internal<T0>(arg0, arg1, arg2, v0, arg4);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mark_redeem_request_as_processed<T0>(&arg0.admin_cap, arg3);
    }

    fun init(arg0: WEIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEIGHT>(arg0, arg1);
    }

    public fun rebalance<T0>(arg0: &mut WeightHook<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T0>(arg2, arg1, arg3);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_supply(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2));
        rebalance_internal<T0>(arg0, arg1, arg2, v0, arg3);
    }

    fun rebalance_internal<T0>(arg0: &mut WeightHook<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (arg0.total_weight == 0) {
            return
        };
        let v0 = arg0.validator_addresses_and_weights;
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validators(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(v1)) {
            let v3 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validator_address(0x1::vector::borrow<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(v1, v2));
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
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v8)) {
            0x1::vector::push_back<u64>(&mut v7, (((arg3 as u128) * (0x1::vector::pop_back<u64>(&mut v8) as u128) / (arg0.total_weight as u128)) as u64));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v8);
        let v10 = &v6;
        let v11 = vector[];
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(v10)) {
            let v13 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::find_validator_index_by_address(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2), *0x1::vector::borrow<address>(v10, v12));
            let v14 = if (v13 >= 0x1::vector::length<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validators(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2)))) {
                0
            } else {
                0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_amount(0x1::vector::borrow<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validators(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::storage<T0>(arg2)), v13))
            };
            0x1::vector::push_back<u64>(&mut v11, v14);
            v12 = v12 + 1;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(&v6)) {
            if (*0x1::vector::borrow<u64>(&v11, v15) > *0x1::vector::borrow<u64>(&v7, v15)) {
                0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::decrease_validator_stake<T0>(arg2, &arg0.admin_cap, arg1, *0x1::vector::borrow<address>(&v6, v15), *0x1::vector::borrow<u64>(&v11, v15) - *0x1::vector::borrow<u64>(&v7, v15), arg4);
            };
            v15 = v15 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<address>(&v6)) {
            if (*0x1::vector::borrow<u64>(&v11, v16) < *0x1::vector::borrow<u64>(&v7, v16)) {
                0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::increase_validator_stake<T0>(arg2, &arg0.admin_cap, arg1, *0x1::vector::borrow<address>(&v6, v16), *0x1::vector::borrow<u64>(&v7, v16) - *0x1::vector::borrow<u64>(&v11, v16), arg4);
            };
            v16 = v16 + 1;
        };
    }

    public fun set_validator_addresses_and_weights<T0>(arg0: &mut WeightHook<T0>, arg1: &WeightHookAdminCap<T0>, arg2: 0x2::vec_map::VecMap<address, u64>) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
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

    public fun weight_hook_id(arg0: &RegistryInfo) : 0x2::object::ID {
        arg0.weight_hook_id
    }

    // decompiled from Move bytecode v6
}

