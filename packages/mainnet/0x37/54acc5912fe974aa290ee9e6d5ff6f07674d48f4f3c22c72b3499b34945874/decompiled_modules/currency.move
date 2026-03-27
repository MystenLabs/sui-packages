module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::currency {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CurrencyMinted has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct CurrencyBurned has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CurrencyMetadataUpdated has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        symbol_updated: bool,
        name_updated: bool,
        description_updated: bool,
        icon_updated: bool,
    }

    struct TreasuryCapRemoved has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
    }

    struct MetadataCapRemoved has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
    }

    struct TreasuryCapLocked has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct MetadataCapLocked has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CurrencyMint<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CurrencyBurn<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CurrencyUpdate<phantom T0> has drop {
        dummy_field: bool,
    }

    struct RemoveTreasuryCap<phantom T0> has drop {
        dummy_field: bool,
    }

    struct RemoveMetadataCap<phantom T0> has drop {
        dummy_field: bool,
    }

    struct LockTreasuryCap<phantom T0> has drop {
        dummy_field: bool,
    }

    struct LockMetadataCap<phantom T0> has drop {
        dummy_field: bool,
    }

    struct TreasuryCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CurrencyRulesKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CurrencyRules<phantom T0> has store {
        max_supply: 0x1::option::Option<u64>,
        total_minted: u64,
        total_burned: u64,
        can_mint: bool,
        can_burn: bool,
        can_update_symbol: bool,
        can_update_name: bool,
        can_update_description: bool,
        can_update_icon: bool,
    }

    public fun borrow_rules<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) : &CurrencyRules<T0> {
        let v0 = CurrencyRulesKey<T0>{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_with_package_witness<CurrencyRulesKey<T0>, CurrencyRules<T0>>(arg0, arg1, v0, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_version::current())
    }

    public fun can_burn<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_burn
    }

    public fun can_mint<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_mint
    }

    public fun can_update_description<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_update_description
    }

    public fun can_update_icon<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_update_icon
    }

    public fun can_update_name<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_update_name
    }

    public fun can_update_symbol<T0>(arg0: &CurrencyRules<T0>) : bool {
        arg0.can_update_symbol
    }

    public fun coin_type_supply<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) : u64 {
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::coin::total_supply<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_with_package_witness<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(arg0, arg1, v0, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_version::current()))
    }

    public fun currency_burn<T0>() : CurrencyBurn<T0> {
        CurrencyBurn<T0>{dummy_field: false}
    }

    public fun currency_mint<T0>() : CurrencyMint<T0> {
        CurrencyMint<T0>{dummy_field: false}
    }

    public(friend) fun currency_rules_key<T0>() : CurrencyRulesKey<T0> {
        CurrencyRulesKey<T0>{dummy_field: false}
    }

    public fun currency_update<T0>() : CurrencyUpdate<T0> {
        CurrencyUpdate<T0>{dummy_field: false}
    }

    public fun do_init_burn<T0: store, T1, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T2) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CurrencyBurn<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_coin<T1, T0, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        assert!(v3 == 0x2::coin::value<T1>(&v5), 1);
        let v6 = CurrencyRulesKey<T1>{dummy_field: false};
        let v7 = ExecutionProgressWitness{dummy_field: false};
        let v8 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T1>, CurrencyRules<T1>, T0, ExecutionProgressWitness>(arg1, arg2, v6, arg0, v7);
        assert!(v8.can_burn, 3);
        assert!(v3 <= 18446744073709551615 - v8.total_burned, 1);
        v8.total_burned = v8.total_burned + v3;
        let v9 = TreasuryCapKey<T1>{dummy_field: false};
        let v10 = ExecutionProgressWitness{dummy_field: false};
        let v11 = CurrencyBurned{
            account_id : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type  : 0x1::type_name::get<T1>(),
            amount     : v3,
        };
        0x2::event::emit<CurrencyBurned>(v11);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, CurrencyBurn<T1>, ExecutionProgressWitness>(arg0, arg2, v12);
        0x2::coin::burn<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_mut<TreasuryCapKey<T1>, 0x2::coin::TreasuryCap<T1>, T0, ExecutionProgressWitness>(arg1, arg2, v9, arg0, v10), v5);
    }

    public fun do_init_lock_metadata_cap<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T3) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<LockMetadataCap<T2>>(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v1 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v1);
        let v2 = ExecutionProgressWitness{dummy_field: false};
        let v3 = CurrencyRulesKey<T2>{dummy_field: false};
        if (!0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<CurrencyRulesKey<T2>>(arg1, v3)) {
            let v4 = CurrencyRules<T2>{
                max_supply             : 0x1::option::none<u64>(),
                total_minted           : 0,
                total_burned           : 0,
                can_mint               : false,
                can_burn               : false,
                can_update_symbol      : false,
                can_update_name        : 0x2::bcs::peel_bool(&mut v1),
                can_update_description : 0x2::bcs::peel_bool(&mut v1),
                can_update_icon        : 0x2::bcs::peel_bool(&mut v1),
            };
            let v5 = CurrencyRulesKey<T2>{dummy_field: false};
            let v6 = ExecutionProgressWitness{dummy_field: false};
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_data<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v5, v4, arg0, v6);
        } else {
            let v7 = CurrencyRulesKey<T2>{dummy_field: false};
            let v8 = ExecutionProgressWitness{dummy_field: false};
            let v9 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v7, arg0, v8);
            v9.can_update_symbol = false;
            v9.can_update_name = 0x2::bcs::peel_bool(&mut v1);
            v9.can_update_description = 0x2::bcs::peel_bool(&mut v1);
            v9.can_update_icon = 0x2::bcs::peel_bool(&mut v1);
        };
        let v10 = MetadataCapKey<T2>{dummy_field: false};
        let v11 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_asset<MetadataCapKey<T2>, 0x2::coin_registry::MetadataCap<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v10, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_object<0x2::coin_registry::MetadataCap<T2>, T1, ExecutionProgressWitness>(arg0, arg2, v2, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1))), arg0, v11);
        let v12 = MetadataCapLocked{
            account_id : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type  : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<MetadataCapLocked>(v12);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, LockMetadataCap<T2>, ExecutionProgressWitness>(arg0, arg2, v13);
    }

    public fun do_init_lock_treasury_cap<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T3) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<LockTreasuryCap<T2>>(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v1 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0));
        let v2 = if (0x2::bcs::peel_bool(&mut v1)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v1))
        } else {
            0x1::option::none<u64>()
        };
        let v3 = v2;
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v1);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_object<0x2::coin::TreasuryCap<T2>, T1, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
        let v6 = 0x2::coin::total_supply<T2>(&v5);
        if (0x1::option::is_some<u64>(&v3)) {
            assert!(v6 <= *0x1::option::borrow<u64>(&v3), 8);
        };
        let v7 = CurrencyRulesKey<T2>{dummy_field: false};
        if (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<CurrencyRulesKey<T2>>(arg1, v7)) {
            let v8 = CurrencyRulesKey<T2>{dummy_field: false};
            let v9 = ExecutionProgressWitness{dummy_field: false};
            let v10 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v8, arg0, v9);
            v10.max_supply = v3;
            v10.total_minted = v6;
            v10.total_burned = 0;
            v10.can_mint = 0x2::bcs::peel_bool(&mut v1);
            v10.can_burn = 0x2::bcs::peel_bool(&mut v1);
            v10.can_update_symbol = false;
            v10.can_update_name = 0x2::bcs::peel_bool(&mut v1);
            v10.can_update_description = 0x2::bcs::peel_bool(&mut v1);
            v10.can_update_icon = 0x2::bcs::peel_bool(&mut v1);
        } else {
            let v11 = CurrencyRules<T2>{
                max_supply             : v3,
                total_minted           : v6,
                total_burned           : 0,
                can_mint               : 0x2::bcs::peel_bool(&mut v1),
                can_burn               : 0x2::bcs::peel_bool(&mut v1),
                can_update_symbol      : false,
                can_update_name        : 0x2::bcs::peel_bool(&mut v1),
                can_update_description : 0x2::bcs::peel_bool(&mut v1),
                can_update_icon        : 0x2::bcs::peel_bool(&mut v1),
            };
            let v12 = CurrencyRulesKey<T2>{dummy_field: false};
            let v13 = ExecutionProgressWitness{dummy_field: false};
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_data<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v12, v11, arg0, v13);
        };
        let v14 = TreasuryCapKey<T2>{dummy_field: false};
        let v15 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_asset<TreasuryCapKey<T2>, 0x2::coin::TreasuryCap<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v14, v5, arg0, v15);
        let v16 = TreasuryCapLocked{
            account_id : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type  : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<TreasuryCapLocked>(v16);
        let v17 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, LockTreasuryCap<T2>, ExecutionProgressWitness>(arg0, arg2, v17);
    }

    public fun do_init_mint<T0: store, T1, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CurrencyMint<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        let v5 = coin_type_supply<T1>(arg1, arg2);
        let v6 = CurrencyRulesKey<T1>{dummy_field: false};
        let v7 = ExecutionProgressWitness{dummy_field: false};
        let v8 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T1>, CurrencyRules<T1>, T0, ExecutionProgressWitness>(arg1, arg2, v6, arg0, v7);
        assert!(v8.can_mint, 2);
        if (0x1::option::is_some<u64>(&v8.max_supply)) {
            assert!(v3 <= 18446744073709551615 - v5, 8);
            assert!(v3 + v5 <= *0x1::option::borrow<u64>(&v8.max_supply), 8);
        };
        assert!(v3 <= 18446744073709551615 - v8.total_minted, 8);
        v8.total_minted = v8.total_minted + v3;
        let v9 = TreasuryCapKey<T1>{dummy_field: false};
        let v10 = ExecutionProgressWitness{dummy_field: false};
        let v11 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::provide_coin<T1, T0, ExecutionProgressWitness>(arg0, arg2, v11, v4, 0x2::coin::mint<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_mut<TreasuryCapKey<T1>, 0x2::coin::TreasuryCap<T1>, T0, ExecutionProgressWitness>(arg1, arg2, v9, arg0, v10), v3, arg4), arg4);
        let v12 = CurrencyMinted{
            account_id    : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type     : 0x1::type_name::get<T1>(),
            amount        : v3,
            resource_name : v4,
        };
        0x2::event::emit<CurrencyMinted>(v12);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, CurrencyMint<T1>, ExecutionProgressWitness>(arg0, arg2, v13);
    }

    public fun do_init_remove_metadata_cap<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T3) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<RemoveMetadataCap<T2>>(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v1 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0));
        let v2 = 0x2::bcs::peel_address(&mut v1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = MetadataCapKey<T2>{dummy_field: false};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        if (!has_cap<T2>(arg1)) {
            let v5 = CurrencyRulesKey<T2>{dummy_field: false};
            if (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<CurrencyRulesKey<T2>>(arg1, v5)) {
                let v6 = CurrencyRulesKey<T2>{dummy_field: false};
                let v7 = ExecutionProgressWitness{dummy_field: false};
                let CurrencyRules {
                    max_supply             : _,
                    total_minted           : _,
                    total_burned           : _,
                    can_mint               : _,
                    can_burn               : _,
                    can_update_symbol      : _,
                    can_update_name        : _,
                    can_update_description : _,
                    can_update_icon        : _,
                } = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_data<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v6, arg0, v7);
            };
        } else {
            let v17 = CurrencyRulesKey<T2>{dummy_field: false};
            let v18 = ExecutionProgressWitness{dummy_field: false};
            let v19 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v17, arg0, v18);
            v19.can_update_symbol = false;
            v19.can_update_name = false;
            v19.can_update_description = false;
            v19.can_update_icon = false;
        };
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T2>>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_asset<MetadataCapKey<T2>, 0x2::coin_registry::MetadataCap<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4), v2);
        let v20 = MetadataCapRemoved{
            account_id : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type  : 0x1::type_name::get<T2>(),
            recipient  : v2,
        };
        0x2::event::emit<MetadataCapRemoved>(v20);
        let v21 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, RemoveMetadataCap<T2>, ExecutionProgressWitness>(arg0, arg2, v21);
    }

    public fun do_init_remove_treasury_cap<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T3) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<RemoveTreasuryCap<T2>>(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v1 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0));
        let v2 = 0x2::bcs::peel_address(&mut v1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = TreasuryCapKey<T2>{dummy_field: false};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        if (!has_metadata_cap<T2>(arg1)) {
            let v5 = CurrencyRulesKey<T2>{dummy_field: false};
            let v6 = ExecutionProgressWitness{dummy_field: false};
            let CurrencyRules {
                max_supply             : _,
                total_minted           : _,
                total_burned           : _,
                can_mint               : _,
                can_burn               : _,
                can_update_symbol      : _,
                can_update_name        : _,
                can_update_description : _,
                can_update_icon        : _,
            } = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_data<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
        } else {
            let v16 = CurrencyRulesKey<T2>{dummy_field: false};
            let v17 = ExecutionProgressWitness{dummy_field: false};
            let v18 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T2>, CurrencyRules<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v16, arg0, v17);
            v18.can_mint = false;
            v18.can_burn = false;
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_asset<TreasuryCapKey<T2>, 0x2::coin::TreasuryCap<T2>, T1, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4), v2);
        let v19 = TreasuryCapRemoved{
            account_id : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type  : 0x1::type_name::get<T2>(),
            recipient  : v2,
        };
        0x2::event::emit<TreasuryCapRemoved>(v19);
        let v20 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, RemoveTreasuryCap<T2>, ExecutionProgressWitness>(arg0, arg2, v20);
    }

    public fun do_update<T0: store, T1, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: &mut 0x2::coin_registry::Currency<T1>, arg4: T2) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CurrencyUpdate<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 9);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v4 = v3;
        let v5 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v6 = v5;
        let v7 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v8 = v7;
        let v9 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v10 = v9;
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        let v11 = CurrencyRulesKey<T1>{dummy_field: false};
        let v12 = ExecutionProgressWitness{dummy_field: false};
        let v13 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut<CurrencyRulesKey<T1>, CurrencyRules<T1>, T0, ExecutionProgressWitness>(arg1, arg2, v11, arg0, v12);
        let v14 = if (0x1::option::is_some<0x1::string::String>(&v4)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&v6)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&v8)) {
            true
        } else {
            0x1::option::is_some<0x1::string::String>(&v10)
        };
        assert!(v14, 0);
        assert!(0x1::option::is_none<0x1::string::String>(&v4), 5);
        if (!v13.can_update_name) {
            assert!(0x1::option::is_none<0x1::string::String>(&v6), 4);
        };
        if (!v13.can_update_description) {
            assert!(0x1::option::is_none<0x1::string::String>(&v8), 6);
        };
        if (!v13.can_update_icon) {
            assert!(0x1::option::is_none<0x1::string::String>(&v10), 7);
        };
        let v15 = MetadataCapKey<T1>{dummy_field: false};
        let v16 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_with_package_witness<MetadataCapKey<T1>, 0x2::coin_registry::MetadataCap<T1>>(arg1, arg2, v15, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_version::current());
        0x2::coin_registry::set_name<T1>(arg3, v16, 0x1::option::get_with_default<0x1::string::String>(&v6, 0x2::coin_registry::name<T1>(arg3)));
        0x2::coin_registry::set_description<T1>(arg3, v16, 0x1::option::get_with_default<0x1::string::String>(&v8, 0x2::coin_registry::description<T1>(arg3)));
        0x2::coin_registry::set_icon_url<T1>(arg3, v16, 0x1::option::get_with_default<0x1::string::String>(&v10, 0x2::coin_registry::icon_url<T1>(arg3)));
        let v17 = CurrencyMetadataUpdated{
            account_id          : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            coin_type           : 0x1::type_name::get<T1>(),
            symbol_updated      : false,
            name_updated        : 0x1::option::is_some<0x1::string::String>(&v6),
            description_updated : 0x1::option::is_some<0x1::string::String>(&v8),
            icon_updated        : 0x1::option::is_some<0x1::string::String>(&v10),
        };
        0x2::event::emit<CurrencyMetadataUpdated>(v17);
        let v18 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, CurrencyUpdate<T1>, ExecutionProgressWitness>(arg0, arg2, v18);
    }

    public fun has_cap<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account) : bool {
        let v0 = TreasuryCapKey<T0>{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_asset<TreasuryCapKey<T0>>(arg0, v0)
    }

    public fun has_metadata_cap<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account) : bool {
        let v0 = MetadataCapKey<T0>{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_asset<MetadataCapKey<T0>>(arg0, v0)
    }

    public fun lock_metadata_cap_marker<T0>() : LockMetadataCap<T0> {
        LockMetadataCap<T0>{dummy_field: false}
    }

    public fun lock_treasury_cap_marker<T0>() : LockTreasuryCap<T0> {
        LockTreasuryCap<T0>{dummy_field: false}
    }

    public fun max_supply<T0>(arg0: &CurrencyRules<T0>) : 0x1::option::Option<u64> {
        arg0.max_supply
    }

    public(friend) fun metadata_cap_key<T0>() : MetadataCapKey<T0> {
        MetadataCapKey<T0>{dummy_field: false}
    }

    public fun mint_with_package_witness<T0>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: u64, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_package_witness_authorized(arg0, arg1, arg3);
        let v0 = coin_type_supply<T0>(arg0, arg1);
        let v1 = CurrencyRulesKey<T0>{dummy_field: false};
        let v2 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut_with_package_witness<CurrencyRulesKey<T0>, CurrencyRules<T0>>(arg0, arg1, v1, arg3);
        assert!(v2.can_mint, 2);
        if (0x1::option::is_some<u64>(&v2.max_supply)) {
            assert!(arg2 <= 18446744073709551615 - v0, 8);
            assert!(arg2 + v0 <= *0x1::option::borrow<u64>(&v2.max_supply), 8);
        };
        assert!(arg2 <= 18446744073709551615 - v2.total_minted, 8);
        v2.total_minted = v2.total_minted + arg2;
        let v3 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::coin::mint<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_mut_with_package_witness<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(arg0, arg1, v3, arg3), arg2, arg4)
    }

    public fun new_currency_rules<T0>(arg0: 0x1::option::Option<u64>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool) : CurrencyRules<T0> {
        CurrencyRules<T0>{
            max_supply             : arg0,
            total_minted           : 0,
            total_burned           : 0,
            can_mint               : arg1,
            can_burn               : arg2,
            can_update_symbol      : arg3,
            can_update_name        : arg4,
            can_update_description : arg5,
            can_update_icon        : arg6,
        }
    }

    public fun public_burn<T0>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<T0>) {
        let v0 = CurrencyRulesKey<T0>{dummy_field: false};
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut_with_package_witness<CurrencyRulesKey<T0>, CurrencyRules<T0>>(arg0, arg1, v0, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_version::current());
        assert!(v1.can_burn, 3);
        assert!(0x2::coin::value<T0>(&arg2) <= 18446744073709551615 - v1.total_burned, 1);
        v1.total_burned = v1.total_burned + 0x2::coin::value<T0>(&arg2);
        let v2 = TreasuryCapKey<T0>{dummy_field: false};
        0x2::coin::burn<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_asset_mut_with_package_witness<TreasuryCapKey<T0>, 0x2::coin::TreasuryCap<T0>>(arg0, arg1, v2, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_version::current()), arg2);
    }

    public fun read_currency_metadata<T0>(arg0: &0x2::coin_registry::Currency<T0>) : (u8, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (0x2::coin_registry::decimals<T0>(arg0), 0x2::coin_registry::symbol<T0>(arg0), 0x2::coin_registry::name<T0>(arg0), 0x2::coin_registry::description<T0>(arg0), 0x2::coin_registry::icon_url<T0>(arg0))
    }

    public fun remove_metadata_cap<T0>() : RemoveMetadataCap<T0> {
        RemoveMetadataCap<T0>{dummy_field: false}
    }

    public fun remove_treasury_cap<T0>() : RemoveTreasuryCap<T0> {
        RemoveTreasuryCap<T0>{dummy_field: false}
    }

    public fun total_burned<T0>(arg0: &CurrencyRules<T0>) : u64 {
        arg0.total_burned
    }

    public fun total_minted<T0>(arg0: &CurrencyRules<T0>) : u64 {
        arg0.total_minted
    }

    public(friend) fun treasury_cap_key<T0>() : TreasuryCapKey<T0> {
        TreasuryCapKey<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

