module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency_init_actions {
    struct ReturnTreasuryCapAction has copy, drop, store {
        recipient: address,
    }

    struct ReturnMetadataCapAction has copy, drop, store {
        recipient: address,
    }

    struct MintAction has copy, drop, store {
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct BurnAction has copy, drop, store {
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct UpdateAction has copy, drop, store {
        symbol: 0x1::option::Option<vector<u8>>,
        name: 0x1::option::Option<vector<u8>>,
        description: 0x1::option::Option<vector<u8>>,
        icon_url: 0x1::option::Option<vector<u8>>,
    }

    struct LockTreasuryCapAction has copy, drop, store {
        has_max_supply: bool,
        max_supply: u64,
        can_mint: bool,
        can_burn: bool,
        can_update_name: bool,
        can_update_description: bool,
        can_update_icon: bool,
        resource_name: vector<u8>,
    }

    struct LockMetadataCapAction has copy, drop, store {
        can_update_name: bool,
        can_update_description: bool,
        can_update_icon: bool,
        resource_name: vector<u8>,
    }

    public fun add_burn_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: u64, arg2: 0x1::string::String) {
        let v0 = BurnAction{
            amount        : arg1,
            resource_name : arg2,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyBurn<T0>>(), 0x2::bcs::to_bytes<BurnAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v1, b"amount", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyBurn<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_lock_metadata_cap_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: bool, arg2: bool, arg3: bool, arg4: vector<u8>) {
        let v0 = LockMetadataCapAction{
            can_update_name        : arg1,
            can_update_description : arg2,
            can_update_icon        : arg3,
            resource_name          : arg4,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::LockMetadataCap<T0>>(), 0x2::bcs::to_bytes<LockMetadataCapAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v1, b"can_update_name", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v1, b"can_update_description", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v1, b"can_update_icon", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_vector_u8(&mut v1, b"resource_name", &arg4);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::LockMetadataCap<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_lock_treasury_cap_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::option::Option<u64>, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: vector<u8>) {
        let (v0, v1) = if (0x1::option::is_some<u64>(&arg1)) {
            (true, *0x1::option::borrow<u64>(&arg1))
        } else {
            (false, 0)
        };
        let v2 = LockTreasuryCapAction{
            has_max_supply         : v0,
            max_supply             : v1,
            can_mint               : arg2,
            can_burn               : arg3,
            can_update_name        : arg4,
            can_update_description : arg5,
            can_update_icon        : arg6,
            resource_name          : arg7,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::LockTreasuryCap<T0>>(), 0x2::bcs::to_bytes<LockTreasuryCapAction>(&v2), 1));
        let v3 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_option_u64(&mut v3, b"max_supply", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v3, b"can_mint", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v3, b"can_burn", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v3, b"can_update_name", arg4);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v3, b"can_update_description", arg5);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v3, b"can_update_icon", arg6);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_vector_u8(&mut v3, b"resource_name", &arg7);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v3, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::LockTreasuryCap<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_mint_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: u64, arg2: 0x1::string::String) {
        let v0 = MintAction{
            amount        : arg1,
            resource_name : arg2,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyMint<T0>>(), 0x2::bcs::to_bytes<MintAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v1, b"amount", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyMint<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_return_metadata_cap_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: address) {
        let v0 = ReturnMetadataCapAction{recipient: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::RemoveMetadataCap<T0>>(), 0x2::bcs::to_bytes<ReturnMetadataCapAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v1, b"recipient", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::RemoveMetadataCap<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_return_treasury_cap_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: address) {
        let v0 = ReturnTreasuryCapAction{recipient: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::RemoveTreasuryCap<T0>>(), 0x2::bcs::to_bytes<ReturnTreasuryCapAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v1, b"recipient", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::RemoveTreasuryCap<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_spec<T0>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::option::Option<vector<u8>>, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_none<vector<u8>>(&arg1), 1);
        let v0 = UpdateAction{
            symbol      : arg1,
            name        : arg2,
            description : arg3,
            icon_url    : arg4,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyUpdate<T0>>(), 0x2::bcs::to_bytes<UpdateAction>(&v0), 1));
        let v1 = 0x1::option::none<0x1::string::String>();
        let v2 = if (0x1::option::is_some<vector<u8>>(&arg2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v3 = v2;
        let v4 = if (0x1::option::is_some<vector<u8>>(&arg3)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg3)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v5 = v4;
        let v6 = if (0x1::option::is_some<vector<u8>>(&arg4)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg4)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v7 = v6;
        let v8 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_option_string(&mut v8, b"symbol", &v1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_option_string(&mut v8, b"name", &v3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_option_string(&mut v8, b"description", &v5);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_option_string(&mut v8, b"icon_url", &v7);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v8, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::currency::CurrencyUpdate<T0>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

