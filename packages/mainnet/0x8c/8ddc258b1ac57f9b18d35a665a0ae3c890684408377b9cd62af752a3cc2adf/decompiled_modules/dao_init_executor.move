module 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_executor {
    struct DaoInitIntent has copy, drop {
        dummy_field: bool,
    }

    struct DaoInitExecutionTicket {
        account_id: 0x2::object::ID,
    }

    struct DaoInitIntentExecuted has copy, drop {
        account_id: 0x2::object::ID,
        source_id: 0x1::option::Option<0x2::object::ID>,
        intent_key: 0x1::string::String,
        timestamp: u64,
    }

    public(friend) fun begin_bootstrap_execution(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome> {
        let (_, v1) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::create_init_executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg0, arg1, 0x1::string::utf8(bootstrap_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), arg2, arg3);
        v1
    }

    public fun begin_execution(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, DaoInitExecutionTicket) {
        let (_, v1) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::create_init_executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg0, arg1, 0x1::string::utf8(dao_init_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), arg2, arg3);
        let v2 = v1;
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::is_factory(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&v2))), 2);
        let v3 = DaoInitExecutionTicket{account_id: 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0)};
        (v2, v3)
    }

    public fun begin_failure_execution_for_launchpad(arg0: 0x2::object::ID, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, DaoInitExecutionTicket) {
        let (_, v1) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::create_init_executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg1, arg2, 0x1::string::utf8(launchpad_failure_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), arg3, arg4);
        let v2 = v1;
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&v2));
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::is_launchpad_failure_for_raise(v3, arg0), 1);
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::account_id(v3) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 6);
        let v4 = DaoInitExecutionTicket{account_id: 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1)};
        (v2, v4)
    }

    public fun begin_success_execution_for_launchpad(arg0: 0x2::object::ID, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, DaoInitExecutionTicket) {
        let (_, v1) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::create_init_executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg1, arg2, 0x1::string::utf8(launchpad_success_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), arg3, arg4);
        let v2 = v1;
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&v2));
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::is_launchpad_success_for_raise(v3, arg0), 1);
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::account_id(v3) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 6);
        let v4 = DaoInitExecutionTicket{account_id: 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1)};
        (v2, v4)
    }

    fun bootstrap_intent_key() : vector<u8> {
        b"bootstrap"
    }

    public(friend) fun cancel_launchpad_failure_intent_if_present(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : bool {
        cancel_launchpad_intent_if_present_by_key(arg0, arg1, arg2, 0x1::string::utf8(launchpad_failure_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::kind_launchpad_failure(), arg3)
    }

    fun cancel_launchpad_intent_if_present_by_key(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0);
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::contains(v0, arg3)) {
            return false
        };
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(v0, arg3);
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::is_for_raise(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(v1), arg2), 1);
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::kind(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(v1)) == arg4, 5);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::force_cancel_shared_intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg0, arg1, arg3, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), arg5);
        true
    }

    public(friend) fun cancel_launchpad_success_intent_if_present(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : bool {
        cancel_launchpad_intent_if_present_by_key(arg0, arg1, arg2, 0x1::string::utf8(launchpad_success_intent_key()), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::kind_launchpad_success(), arg3)
    }

    public(friend) fun confirm_bootstrap_execution(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::confirm_execution<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg0, arg1);
    }

    public(friend) fun create_bootstrap_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg3));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_params(0x1::string::utf8(bootstrap_intent_key()), 0x1::string::utf8(b"DAO bootstrap: vaults, approvals, cap locking"), v0, 0x2::clock::timestamp_ms(arg3) + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::dao_init_intent_expiry_ms(), arg3, arg4), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::new_for_factory(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0)), 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v1, arg4);
        let v3 = &mut v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            let v5 = DaoInitIntent{dummy_field: false};
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_existing_action_spec<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(v3, *0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2, v4), v5);
            v4 = v4 + 1;
        };
        let v6 = DaoInitIntent{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::insert_intent_unshared<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v6);
    }

    public(friend) fun create_failure_intents_for_launchpad(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::new_for_launchpad_failure(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), arg3);
        create_intents_internal_shared(arg0, arg1, arg2, 0x1::string::utf8(launchpad_failure_intent_key()), v0, b"DAO cleanup actions from failed launchpad raise", arg4, arg5);
    }

    public(friend) fun create_intents_from_specs_for_factory(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::new_for_factory(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0));
        create_intents_internal_unshared(arg0, arg1, arg2, v0, b"DAO initialization actions", arg3, arg4);
    }

    fun create_intents_internal_shared(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: 0x1::string::String, arg4: 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg6));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_params(arg3, 0x1::string::utf8(arg5), v0, 0x2::clock::timestamp_ms(arg6) + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::dao_init_intent_expiry_ms(), arg6, arg7), arg4, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v1, arg7);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_existing_action_spec<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(&mut v2, *0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2, v3), v1);
            v3 = v3 + 1;
        };
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::stage_intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v1);
    }

    fun create_intents_internal_unshared(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_params(0x1::string::utf8(dao_init_intent_key()), 0x1::string::utf8(arg4), v0, 0x2::clock::timestamp_ms(arg5) + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::dao_init_intent_expiry_ms(), arg5, arg6), arg3, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v1, arg6);
        let v3 = &mut v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            let v5 = DaoInitIntent{dummy_field: false};
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_existing_action_spec<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(v3, *0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2, v4), v5);
            v4 = v4 + 1;
        };
        let v6 = DaoInitIntent{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::insert_intent_unshared<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::factory_version::current(), v6);
    }

    public(friend) fun create_success_intents_for_launchpad(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::new_for_launchpad_success(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), arg3);
        create_intents_internal_shared(arg0, arg1, arg2, 0x1::string::utf8(launchpad_success_intent_key()), v0, b"DAO initialization actions from successful launchpad raise", arg4, arg5);
    }

    public fun dao_init_intent_key() : vector<u8> {
        b"dao_init"
    }

    public(friend) fun dao_init_intent_witness() : DaoInitIntent {
        DaoInitIntent{dummy_field: false}
    }

    public fun finalize_execution(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, arg3: DaoInitExecutionTicket, arg4: &0x2::clock::Clock) {
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::is_factory(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&arg2))), 4);
        finalize_execution_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun finalize_execution_internal(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, arg3: DaoInitExecutionTicket, arg4: &0x2::clock::Clock) {
        let DaoInitExecutionTicket { account_id: v0 } = arg3;
        assert!(v0 == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 3);
        let v1 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&arg2));
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::account_id(&v1) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 6);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::confirm_execution<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(arg0, arg2);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::mark_account_initialized(arg0);
        let v2 = DaoInitIntentExecuted{
            account_id : 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::account_id(&v1),
            source_id  : *0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::source_id(&v1),
            intent_key : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::key<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&arg2)),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DaoInitIntentExecuted>(v2);
    }

    public(friend) fun finalize_launchpad_execution(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>, arg3: DaoInitExecutionTicket, arg4: &0x2::clock::Clock) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::DaoInitOutcome>(&arg2));
        assert!(0x1::option::is_some<0x2::object::ID>(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::source_id(v0)), 7);
        assert!(0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome::account_id(v0) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 6);
        finalize_execution_internal(arg0, arg1, arg2, arg3, arg4);
    }

    public fun launchpad_failure_intent_key() : vector<u8> {
        b"launchpad_failure"
    }

    public fun launchpad_success_intent_key() : vector<u8> {
        b"launchpad_success"
    }

    // decompiled from Move bytecode v6
}

