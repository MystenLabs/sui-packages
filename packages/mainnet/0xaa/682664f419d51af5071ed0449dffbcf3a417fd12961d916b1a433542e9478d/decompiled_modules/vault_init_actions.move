module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault_init_actions {
    struct DepositAction has copy, drop, store {
        vault_name: 0x1::string::String,
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct SpendAction has copy, drop, store {
        vault_name: 0x1::string::String,
        amount: u64,
        spend_all: bool,
        resource_name: 0x1::string::String,
    }

    struct ApproveCoinTypeAction has copy, drop, store {
        vault_name: 0x1::string::String,
    }

    struct RemoveApprovedCoinTypeAction has copy, drop, store {
        vault_name: 0x1::string::String,
    }

    struct CancelStreamAction has copy, drop, store {
        vault_name: 0x1::string::String,
        stream_id: 0x2::object::ID,
    }

    struct CollectStreamAction has copy, drop, store {
        vault_name: 0x1::string::String,
        stream_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
        amount: u64,
        cap_resource_name: 0x1::string::String,
    }

    struct DepositExternalAction has copy, drop, store {
        vault_name: 0x1::string::String,
        expected_amount: u64,
    }

    struct DepositFromResourcesAction has copy, drop, store {
        vault_name: 0x1::string::String,
        resource_name: 0x1::string::String,
    }

    struct DepositObjectFromResourcesAction has copy, drop, store {
        vault_name: 0x1::string::String,
        resource_name: 0x1::string::String,
    }

    struct MintVaultAdminCapAction has copy, drop, store {
        vault_name: 0x1::string::String,
        resource_name: 0x1::string::String,
    }

    struct OpenVaultAction has copy, drop, store {
        vault_name: 0x1::string::String,
    }

    struct CloseVaultAction has copy, drop, store {
        vault_name: 0x1::string::String,
    }

    public fun add_approve_coin_type_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = ApproveCoinTypeAction{vault_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultApproveCoinType<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_approve_coin_type_marker<T0>(), 0x2::bcs::to_bytes<ApproveCoinTypeAction>(&v0), 1));
    }

    public fun add_cancel_stream_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        let v0 = CancelStreamAction{
            vault_name : arg1,
            stream_id  : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::CancelStream<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::cancel_stream_marker<T0>(), 0x2::bcs::to_bytes<CancelStreamAction>(&v0), 1));
    }

    public fun add_close_vault_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = CloseVaultAction{vault_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultClose>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_close_marker(), 0x2::bcs::to_bytes<CloseVaultAction>(&v0), 1));
    }

    public fun add_collect_stream_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String) {
        let v0 = CollectStreamAction{
            vault_name        : arg1,
            stream_id         : arg2,
            resource_name     : arg3,
            amount            : arg4,
            cap_resource_name : arg5,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::CollectStream<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::collect_stream_marker<T0>(), 0x2::bcs::to_bytes<CollectStreamAction>(&v0), 1));
    }

    public fun add_deposit_external_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64) {
        let v0 = DepositExternalAction{
            vault_name      : arg1,
            expected_amount : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultDepositExternal<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_deposit_external_marker<T0>(), 0x2::bcs::to_bytes<DepositExternalAction>(&v0), 1));
    }

    public fun add_deposit_from_resources_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = DepositFromResourcesAction{
            vault_name    : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultDepositFromResources<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_deposit_from_resources_marker<T0>(), 0x2::bcs::to_bytes<DepositFromResourcesAction>(&v0), 1));
    }

    public fun add_deposit_object_from_resources_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = DepositObjectFromResourcesAction{
            vault_name    : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultDepositObjectFromResources<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_deposit_object_from_resources_marker<T0>(), 0x2::bcs::to_bytes<DepositObjectFromResourcesAction>(&v0), 1));
    }

    public fun add_deposit_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String) {
        let v0 = DepositAction{
            vault_name    : arg1,
            amount        : arg2,
            resource_name : arg3,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultDeposit<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_deposit_marker<T0>(), 0x2::bcs::to_bytes<DepositAction>(&v0), 1));
    }

    public fun add_mint_vault_admin_cap_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = MintVaultAdminCapAction{
            vault_name    : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::MintVaultAdminCap>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::mint_vault_admin_cap_marker(), 0x2::bcs::to_bytes<MintVaultAdminCapAction>(&v0), 1));
    }

    public fun add_open_vault_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = OpenVaultAction{vault_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultOpen>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_open_marker(), 0x2::bcs::to_bytes<OpenVaultAction>(&v0), 1));
    }

    public fun add_remove_approved_coin_type_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = RemoveApprovedCoinTypeAction{vault_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultRemoveApprovedCoinType<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_remove_approved_coin_type_marker<T0>(), 0x2::bcs::to_bytes<RemoveApprovedCoinTypeAction>(&v0), 1));
    }

    public fun add_spend_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: 0x1::string::String) {
        let v0 = SpendAction{
            vault_name    : arg1,
            amount        : arg2,
            spend_all     : arg3,
            resource_name : arg4,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::VaultSpend<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::vault_spend_marker<T0>(), 0x2::bcs::to_bytes<SpendAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

