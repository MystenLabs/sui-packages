module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency_init_actions {
    struct RemoveTreasuryCapToResourcesAction has copy, drop, store {
        expected_cap_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct RemoveMetadataCapToResourcesAction has copy, drop, store {
        expected_cap_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct MintAction has copy, drop, store {
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct MintAdminCapAction has copy, drop, store {
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
        resource_name: 0x1::string::String,
    }

    struct LockMetadataCapAction has copy, drop, store {
        can_update_name: bool,
        can_update_description: bool,
        can_update_icon: bool,
        resource_name: 0x1::string::String,
    }

    public fun add_burn_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: u64, arg2: 0x1::string::String) {
        let v0 = BurnAction{
            amount        : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyBurn<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::currency_burn<T0>(), 0x2::bcs::to_bytes<BurnAction>(&v0), 1));
    }

    public fun add_lock_metadata_cap_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: bool, arg2: bool, arg3: bool, arg4: 0x1::string::String) {
        assert_valid_resource_name(&arg4);
        let v0 = LockMetadataCapAction{
            can_update_name        : arg1,
            can_update_description : arg2,
            can_update_icon        : arg3,
            resource_name          : arg4,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::LockMetadataCap<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::lock_metadata_cap_marker<T0>(), 0x2::bcs::to_bytes<LockMetadataCapAction>(&v0), 1));
    }

    public fun add_lock_treasury_cap_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::option::Option<u64>, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: 0x1::string::String) {
        assert_valid_resource_name(&arg7);
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
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::LockTreasuryCap<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::lock_treasury_cap_marker<T0>(), 0x2::bcs::to_bytes<LockTreasuryCapAction>(&v2), 1));
    }

    public fun add_mint_currency_admin_cap_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = MintAdminCapAction{resource_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::MintCurrencyAdminCap<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_currency_admin_cap_marker<T0>(), 0x2::bcs::to_bytes<MintAdminCapAction>(&v0), 1));
    }

    public fun add_mint_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: u64, arg2: 0x1::string::String) {
        let v0 = MintAction{
            amount        : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMint<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::currency_mint<T0>(), 0x2::bcs::to_bytes<MintAction>(&v0), 1));
    }

    public fun add_remove_metadata_cap_to_resources_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        assert_valid_resource_name(&arg2);
        let v0 = RemoveMetadataCapToResourcesAction{
            expected_cap_id : arg1,
            resource_name   : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::RemoveMetadataCapToResources<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::remove_metadata_cap_to_resources<T0>(), 0x2::bcs::to_bytes<RemoveMetadataCapToResourcesAction>(&v0), 1));
    }

    public fun add_remove_treasury_cap_to_resources_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        assert_valid_resource_name(&arg2);
        let v0 = RemoveTreasuryCapToResourcesAction{
            expected_cap_id : arg1,
            resource_name   : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::RemoveTreasuryCapToResources<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::remove_treasury_cap_to_resources<T0>(), 0x2::bcs::to_bytes<RemoveTreasuryCapToResourcesAction>(&v0), 1));
    }

    public fun add_update_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::option::Option<vector<u8>>, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_none<vector<u8>>(&arg1), 1);
        let v0 = UpdateAction{
            symbol      : arg1,
            name        : arg2,
            description : arg3,
            icon_url    : arg4,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyUpdate<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::currency_update<T0>(), 0x2::bcs::to_bytes<UpdateAction>(&v0), 1));
        0x1::option::none<0x1::string::String>();
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
        };
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
        };
    }

    fun assert_valid_resource_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 2);
        assert!(0x1::string::length(arg0) <= 256, 3);
    }

    // decompiled from Move bytecode v6
}

