module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::setup {
    struct SetupRegistry has key {
        id: 0x2::object::UID,
        deployers: 0x2::vec_set::VecSet<address>,
        admin: address,
    }

    struct SetupFinalize {
        dummy_field: bool,
    }

    public fun setup<T0: key>(arg0: &mut SetupRegistry, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::ds_token::Treasury<T0>, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, SetupFinalize) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.deployers, &v0), 13835058385994645505);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 13835621340243296261);
        let v1 = uid_mut(arg0);
        let v2 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::new<T0>(v1, arg5);
        let v3 = uid_mut(arg0);
        let v4 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::ds_token::new<T0>(v3, &mut v2, arg1, arg2, arg3, arg4, arg5);
        let v5 = uid_mut(arg0);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::wallet_manager::new<T0>(&mut v2, arg4, arg5);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::lock_manager::new<T0>(&mut v2, arg4, arg5);
        let v6 = SetupFinalize{dummy_field: false};
        (v2, v4, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::new<T0>(v5, &mut v2, arg4, arg5), 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::new<T0>(uid_mut(arg0), &mut v2, arg4, arg5), v6)
    }

    public fun add_deployer(arg0: &mut SetupRegistry, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 13835340075719852035);
        0x2::vec_set::insert<address>(&mut arg0.deployers, arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_deployer_added_event(arg1);
    }

    public fun admin(arg0: &SetupRegistry) : address {
        arg0.admin
    }

    public fun finalize_setup<T0: key>(arg0: SetupFinalize, arg1: 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::ds_token::Treasury<T0>, arg3: 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg4: 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, arg5: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg5);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::share<T0>(arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::ds_token::share<T0>(arg2);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::share<T0>(arg3);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::share<T0>(arg4);
        let SetupFinalize {  } = arg0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SetupRegistry{
            id        : 0x2::object::new(arg0),
            deployers : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            admin     : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<SetupRegistry>(v0);
    }

    public fun is_deployer(arg0: &SetupRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.deployers, &arg1)
    }

    public fun migrate_version(arg0: &SetupRegistry, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 13835340268993380355);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::migrate(arg1);
    }

    public fun remove_deployer(arg0: &mut SetupRegistry, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 13835340148734296067);
        0x2::vec_set::remove<address>(&mut arg0.deployers, &arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_deployer_removed_event(arg1);
    }

    public fun switch_admin(arg0: &mut SetupRegistry, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 13835340221748740099);
        arg0.admin = arg1;
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_admin_switched_event(0x2::tx_context::sender(arg3), arg1);
    }

    public(friend) fun uid_mut(arg0: &mut SetupRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

