module 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::dissolution_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct RedemptionPoolIdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateDissolutionCapability<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CreateDissolutionCapabilityUnshared<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ShareDissolutionCapability has drop {
        dummy_field: bool,
    }

    struct UnsharedDissolutionCapabilityTicket {
        capability_id: 0x2::object::ID,
    }

    struct CreateRedemptionPool<phantom T0> has drop {
        dummy_field: bool,
    }

    struct AddToRedemptionPool<phantom T0> has drop {
        dummy_field: bool,
    }

    struct DissolutionCapability has key {
        id: 0x2::object::UID,
        dao_address: address,
        created_at_ms: u64,
        unlock_at_ms: u64,
        total_asset_supply: u64,
    }

    struct RedemptionPool<phantom T0> has key {
        id: 0x2::object::UID,
        dao_address: address,
        capability_id: 0x2::object::ID,
        total_asset_supply: u64,
        remaining_asset_supply: u64,
        unlock_at_ms: u64,
        coin_type: 0x1::type_name::TypeName,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DissolutionCapabilityCreated has copy, drop {
        capability_id: 0x2::object::ID,
        dao_address: address,
        created_at_ms: u64,
        unlock_at_ms: u64,
        total_asset_supply: u64,
    }

    struct RedemptionPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        capability_id: 0x2::object::ID,
        dao_address: address,
        coin_type: 0x1::type_name::TypeName,
        initial_balance: u64,
    }

    struct DissolutionCapabilityShared has copy, drop {
        capability_id: 0x2::object::ID,
        dao_address: address,
    }

    struct RedemptionPoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount_added: u64,
        new_balance: u64,
    }

    struct Redemption has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        asset_amount_burned: u64,
        coin_type_redeemed: 0x1::string::String,
        coin_amount_received: u64,
    }

    struct CreateDissolutionCapabilityAction<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateRedemptionPoolAction has copy, drop, store {
        resource_names: vector<0x1::string::String>,
    }

    struct AddToRedemptionPoolAction has copy, drop, store {
        resource_name: 0x1::string::String,
        pool_id: address,
    }

    public fun capability_info(arg0: &DissolutionCapability) : (address, u64, u64, u64) {
        (arg0.dao_address, arg0.created_at_ms, arg0.unlock_at_ms, arg0.total_asset_supply)
    }

    public fun claim<T0, T1>(arg0: &mut RedemptionPool<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.dao_address == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1), 8);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.unlock_at_ms, 10);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::asset_type(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg1)) == &v0, 6);
        let v1 = 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::currency::coin_type_supply<T0>(arg1, arg2);
        assert!(v1 <= arg0.remaining_asset_supply, 17);
        if (v1 < arg0.remaining_asset_supply) {
            arg0.remaining_asset_supply = v1;
        };
        assert!(arg0.remaining_asset_supply > 0, 12);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 <= arg0.remaining_asset_supply, 13);
        let v3 = (((0x2::balance::value<T1>(&arg0.balance) as u128) * (v2 as u128) / (arg0.remaining_asset_supply as u128)) as u64);
        assert!(v3 > 0, 7);
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::currency::public_burn<T0>(arg1, arg2, arg3);
        arg0.remaining_asset_supply = arg0.remaining_asset_supply - v2;
        let v4 = Redemption{
            pool_id              : 0x2::object::id<RedemptionPool<T1>>(arg0),
            user                 : 0x2::tx_context::sender(arg5),
            asset_amount_burned  : v2,
            coin_type_redeemed   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())),
            coin_amount_received : v3,
        };
        0x2::event::emit<Redemption>(v4);
        0x2::coin::take<T1>(&mut arg0.balance, v3, arg5)
    }

    fun create_capability_from_existing_state<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) : DissolutionCapability {
        let v0 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dao_state(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::operational_state(v0) == 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::state_terminated(), 0);
        let v1 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dissolution_unlock_time(v0);
        assert!(0x1::option::is_some<u64>(&v1), 0);
        let v2 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::terminated_at(v0);
        create_capability_validated<T0>(arg0, arg1, *0x1::option::borrow<u64>(&v1), *0x1::option::borrow<u64>(&v2), arg2)
    }

    public fun create_capability_if_terminated<T0>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DissolutionCapability>(create_capability_unshared_internal<T0>(arg0, arg1, arg2));
    }

    fun create_capability_unshared_internal<T0>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) : DissolutionCapability {
        let v0 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dao_state(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::operational_state(v0) == 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::state_terminated(), 0);
        assert!(!0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dissolution_capability_created(v0), 3);
        let v1 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dissolution_unlock_time(v0);
        assert!(0x1::option::is_some<u64>(&v1), 0);
        let (v2, v3) = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::consume_dissolution_capability_creation(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_authorized<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg0, arg1, 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::futarchy_actions_version::current()));
        create_capability_validated<T0>(arg0, arg1, v2, v3, arg2)
    }

    fun create_capability_validated<T0>(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : DissolutionCapability {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::asset_type(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg0)) == &v0, 6);
        let v1 = 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::currency::coin_type_supply<T0>(arg0, arg1);
        assert!(v1 > 0, 5);
        let v2 = DissolutionCapability{
            id                 : 0x2::object::new(arg4),
            dao_address        : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg0),
            created_at_ms      : arg3,
            unlock_at_ms       : arg2,
            total_asset_supply : v1,
        };
        let v3 = DissolutionCapabilityCreated{
            capability_id      : 0x2::object::id<DissolutionCapability>(&v2),
            dao_address        : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg0),
            created_at_ms      : arg3,
            unlock_at_ms       : arg2,
            total_asset_supply : v1,
        };
        0x2::event::emit<DissolutionCapabilityCreated>(v3);
        v2
    }

    public fun do_add_to_redemption_pool<T0, T1: store, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: &mut RedemptionPool<T0>, arg4: T2, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<AddToRedemptionPool<T0>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 11);
        let v2 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<RedemptionPool<T0>>(arg3) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 8);
        assert!(arg3.dao_address == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1), 8);
        assert!(arg3.remaining_asset_supply > 0, 12);
        assert!(arg3.remaining_asset_supply == arg3.total_asset_supply, 19);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        let v4 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_coin<T0, T1, ExecutionProgressWitness>(arg0, arg2, v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(v4));
        let v5 = RedemptionPoolFunded{
            pool_id      : 0x2::object::id<RedemptionPool<T0>>(arg3),
            coin_type    : 0x1::type_name::with_original_ids<T0>(),
            amount_added : 0x2::coin::value<T0>(&v4),
            new_balance  : 0x2::balance::value<T0>(&arg3.balance),
        };
        0x2::event::emit<RedemptionPoolFunded>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, AddToRedemptionPool<T0>, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_create_dissolution_capability<T0, T1: store, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CreateDissolutionCapability<T0>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 11);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1)));
        if (!0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dissolution_capability_created(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dao_state(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg1)))) {
            create_capability_if_terminated<T0>(arg1, arg2, arg4);
        };
        let v2 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, CreateDissolutionCapability<T0>, ExecutionProgressWitness>(arg0, arg2, v2);
    }

    public fun do_create_dissolution_capability_unshared<T0, T1: store, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) : (DissolutionCapability, UnsharedDissolutionCapabilityTicket) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CreateDissolutionCapabilityUnshared<T0>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 11);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1)));
        let v2 = if (!0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dissolution_capability_created(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dao_state(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg1)))) {
            create_capability_unshared_internal<T0>(arg1, arg2, arg4)
        } else {
            create_capability_from_existing_state<T0>(arg1, arg2, arg4)
        };
        let v3 = v2;
        let v4 = UnsharedDissolutionCapabilityTicket{capability_id: 0x2::object::id<DissolutionCapability>(&v3)};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, CreateDissolutionCapabilityUnshared<T0>, ExecutionProgressWitness>(arg0, arg2, v5);
        (v3, v4)
    }

    public fun do_create_redemption_pool<T0, T1: store, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: &mut DissolutionCapability, arg4: T2, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CreateRedemptionPool<T0>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 11);
        let v2 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x2::bcs::peel_vec_length(&mut v2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
            v4 = v4 + 1;
        };
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::vector::length<0x1::string::String>(&v3) > 0, 16);
        assert!(arg3.dao_address == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1), 1);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::consume_redemption_pool_creation(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_authorized<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg1, arg2, 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::futarchy_actions_version::current()));
        let v5 = RedemptionPoolIdKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<RedemptionPoolIdKey>(&arg3.id, v5), 14);
        let v6 = 0x2::coin::zero<T0>(arg5);
        v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let v7 = ExecutionProgressWitness{dummy_field: false};
            0x2::coin::join<T0>(&mut v6, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_coin<T0, T1, ExecutionProgressWitness>(arg0, arg2, v7, *0x1::vector::borrow<0x1::string::String>(&v3, v4)));
            v4 = v4 + 1;
        };
        let v8 = RedemptionPool<T0>{
            id                     : 0x2::object::new(arg5),
            dao_address            : arg3.dao_address,
            capability_id          : 0x2::object::id<DissolutionCapability>(arg3),
            total_asset_supply     : arg3.total_asset_supply,
            remaining_asset_supply : arg3.total_asset_supply,
            unlock_at_ms           : arg3.unlock_at_ms,
            coin_type              : 0x1::type_name::with_original_ids<T0>(),
            balance                : 0x2::coin::into_balance<T0>(v6),
        };
        let v9 = 0x2::object::id<RedemptionPool<T0>>(&v8);
        let v10 = RedemptionPoolIdKey{dummy_field: false};
        0x2::dynamic_field::add<RedemptionPoolIdKey, 0x2::object::ID>(&mut arg3.id, v10, v9);
        let v11 = RedemptionPoolCreated{
            pool_id         : v9,
            capability_id   : 0x2::object::id<DissolutionCapability>(arg3),
            dao_address     : arg3.dao_address,
            coin_type       : 0x1::type_name::with_original_ids<T0>(),
            initial_balance : 0x2::coin::value<T0>(&v6),
        };
        0x2::event::emit<RedemptionPoolCreated>(v11);
        0x2::transfer::share_object<RedemptionPool<T0>>(v8);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T1, CreateRedemptionPool<T0>, ExecutionProgressWitness>(arg0, arg2, v12);
    }

    public fun do_share_dissolution_capability<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: DissolutionCapability, arg4: UnsharedDissolutionCapabilityTicket, arg5: T1) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<ShareDissolutionCapability>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 11);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1)));
        assert!(arg3.dao_address == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1), 1);
        let v2 = RedemptionPoolIdKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RedemptionPoolIdKey>(&arg3.id, v2), 15);
        let UnsharedDissolutionCapabilityTicket { capability_id: v3 } = arg4;
        assert!(v3 == 0x2::object::id<DissolutionCapability>(&arg3), 18);
        let v4 = DissolutionCapabilityShared{
            capability_id : v3,
            dao_address   : arg3.dao_address,
        };
        0x2::event::emit<DissolutionCapabilityShared>(v4);
        0x2::transfer::share_object<DissolutionCapability>(arg3);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, ShareDissolutionCapability, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun is_unlocked(arg0: &DissolutionCapability, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_at_ms
    }

    public fun new_add_to_redemption_pool(arg0: 0x1::string::String, arg1: 0x2::object::ID) : AddToRedemptionPoolAction {
        AddToRedemptionPoolAction{
            resource_name : arg0,
            pool_id       : 0x2::object::id_to_address(&arg1),
        }
    }

    public fun new_create_dissolution_capability<T0>() : CreateDissolutionCapabilityAction<T0> {
        CreateDissolutionCapabilityAction<T0>{dummy_field: false}
    }

    public fun new_create_redemption_pool(arg0: vector<0x1::string::String>) : CreateRedemptionPoolAction {
        CreateRedemptionPoolAction{resource_names: arg0}
    }

    public fun pool_balance<T0>(arg0: &RedemptionPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_info<T0>(arg0: &RedemptionPool<T0>) : (address, 0x2::object::ID, u64, u64, u64) {
        (arg0.dao_address, arg0.capability_id, arg0.total_asset_supply, arg0.remaining_asset_supply, 0x2::balance::value<T0>(&arg0.balance))
    }

    public fun pool_is_unlocked<T0>(arg0: &RedemptionPool<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_at_ms
    }

    // decompiled from Move bytecode v6
}

