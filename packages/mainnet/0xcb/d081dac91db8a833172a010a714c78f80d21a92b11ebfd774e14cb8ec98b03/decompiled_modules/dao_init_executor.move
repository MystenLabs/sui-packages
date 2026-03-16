module 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_executor {
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

    public(friend) fun begin_bootstrap_execution(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome> {
        let (_, v1) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::create_init_executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg0, arg1, 0x1::string::utf8(bootstrap_intent_key()), 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), arg2, arg3);
        v1
    }

    public fun begin_execution(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>, DaoInitExecutionTicket) {
        let (v0, v1) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::create_init_executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg0, arg1, 0x1::string::utf8(dao_init_intent_key()), 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), arg2, arg3);
        let v2 = v0;
        assert!(0x1::option::is_none<0x2::object::ID>(0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::source_id(&v2)), 2);
        let v3 = DaoInitExecutionTicket{account_id: 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0)};
        (v1, v3)
    }

    public fun begin_execution_for_launchpad(arg0: 0x2::object::ID, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>, DaoInitExecutionTicket) {
        let (v0, v1) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::create_init_executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg1, arg2, 0x1::string::utf8(dao_init_intent_key()), 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), arg3, arg4);
        let v2 = v0;
        assert!(0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::is_for_raise(&v2, arg0), 1);
        let v3 = DaoInitExecutionTicket{account_id: 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1)};
        (v1, v3)
    }

    fun bootstrap_intent_key() : vector<u8> {
        b"bootstrap"
    }

    public(friend) fun cancel_launchpad_intent_if_present(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(dao_init_intent_key());
        let v1 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::intents(arg0);
        if (!0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::contains(v1, v0)) {
            return
        };
        assert!(0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::is_for_raise(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::outcome<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::get<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(v1, v0)), arg2), 1);
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::force_cancel_shared_intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg0, arg1, v0, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), arg3);
    }

    public(friend) fun confirm_bootstrap_execution(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::confirm_execution<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg0, arg1);
    }

    public(friend) fun create_bootstrap_intent(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg3));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_params(0x1::string::utf8(bootstrap_intent_key()), 0x1::string::utf8(b"DAO bootstrap: vaults, approvals, cap locking"), v0, 0x2::clock::timestamp_ms(arg3) + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::dao_init_intent_expiry_ms(), arg3, arg4), 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::new_for_factory(0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0)), 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v1, arg4);
        let v3 = &mut v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            let v5 = DaoInitIntent{dummy_field: false};
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_existing_action_spec<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(v3, *0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2, v4), v5);
            v4 = v4 + 1;
        };
        let v6 = DaoInitIntent{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::insert_intent_unshared<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v6);
    }

    public(friend) fun create_intents_from_specs_for_factory(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::new_for_factory(0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0));
        create_intents_internal_unshared(arg0, arg1, arg2, v0, b"DAO initialization actions", arg3, arg4);
    }

    public(friend) fun create_intents_from_specs_for_launchpad(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            return
        };
        let v0 = 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::new_for_launchpad(0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0), arg3);
        create_intents_internal_shared(arg0, arg1, arg2, v0, b"DAO initialization actions from launchpad raise", arg4, arg5);
    }

    fun create_intents_internal_shared(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_params(0x1::string::utf8(dao_init_intent_key()), 0x1::string::utf8(arg4), v0, 0x2::clock::timestamp_ms(arg5) + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::dao_init_intent_expiry_ms(), arg5, arg6), arg3, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v1, arg6);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_existing_action_spec<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(&mut v2, *0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2, v3), v1);
            v3 = v3 + 1;
        };
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::stage_intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v1);
    }

    fun create_intents_internal_unshared(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = DaoInitIntent{dummy_field: false};
        let v2 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_params(0x1::string::utf8(dao_init_intent_key()), 0x1::string::utf8(arg4), v0, 0x2::clock::timestamp_ms(arg5) + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::dao_init_intent_expiry_ms(), arg5, arg6), arg3, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v1, arg6);
        let v3 = &mut v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2)) {
            let v5 = DaoInitIntent{dummy_field: false};
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_existing_action_spec<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(v3, *0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(arg2, v4), v5);
            v4 = v4 + 1;
        };
        let v6 = DaoInitIntent{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::insert_intent_unshared<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome, DaoInitIntent>(arg0, arg1, v2, 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::factory_version::current(), v6);
    }

    public fun dao_init_intent_key() : vector<u8> {
        b"dao_init"
    }

    public(friend) fun dao_init_intent_witness() : DaoInitIntent {
        DaoInitIntent{dummy_field: false}
    }

    public fun finalize_execution(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>, arg3: DaoInitExecutionTicket, arg4: &0x2::clock::Clock) {
        let DaoInitExecutionTicket { account_id: v0 } = arg3;
        assert!(v0 == 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0), 3);
        let v1 = *0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::outcome<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(&arg2));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::confirm_execution<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(arg0, arg2);
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::mark_account_initialized(arg0);
        let v2 = DaoInitIntentExecuted{
            account_id : 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::account_id(&v1),
            source_id  : *0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::source_id(&v1),
            intent_key : 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::key<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome::DaoInitOutcome>(&arg2)),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DaoInitIntentExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

