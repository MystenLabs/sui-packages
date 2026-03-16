module 0x21f9b7c25ec355536eb281bd86b061af80c9d1d6f5e345d04e9c0aabec87737e::quota_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct SetQuotas has drop {
        dummy_field: bool,
    }

    struct GovernanceQuotasSet has copy, drop {
        account_id: 0x2::object::ID,
        num_users: u64,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    struct SetQuotasAction has drop, store {
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    public fun do_set_quotas<T0: store, T1: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T0>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<T0>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T0>(arg0)), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::action_idx<T0>(arg0));
        let v2 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(v1);
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(v1) == 1, 0);
        let v3 = 0x2::bcs::new(*v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = 0;
        while (v5 < 0x2::bcs::peel_vec_length(&mut v3)) {
            0x1::vector::push_back<address>(&mut v4, 0x2::bcs::peel_address(&mut v3));
            v5 = v5 + 1;
        };
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v3);
        let v6 = SetQuotasAction{
            users                   : v4,
            period_ms               : 0x2::bcs::peel_u64(&mut v3),
            feeless_proposal_amount : 0x2::bcs::peel_u64(&mut v3),
            sponsor_amount          : 0x2::bcs::peel_u64(&mut v3),
        };
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::set_quotas_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v7, v6.users, v6.period_ms, v6.feeless_proposal_amount, v6.sponsor_amount, arg4);
        let v8 = GovernanceQuotasSet{
            account_id              : 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1),
            num_users               : 0x1::vector::length<address>(&v6.users),
            period_ms               : v6.period_ms,
            feeless_proposal_amount : v6.feeless_proposal_amount,
            sponsor_amount          : v6.sponsor_amount,
        };
        0x2::event::emit<GovernanceQuotasSet>(v8);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::increment_action_idx<T0, SetQuotas, ExecutionProgressWitness>(arg0, arg2, v9);
    }

    public fun feeless_proposal_amount(arg0: &SetQuotasAction) : u64 {
        arg0.feeless_proposal_amount
    }

    public fun new_set_quotas(arg0: vector<address>, arg1: u64, arg2: u64, arg3: u64) : SetQuotasAction {
        SetQuotasAction{
            users                   : arg0,
            period_ms               : arg1,
            feeless_proposal_amount : arg2,
            sponsor_amount          : arg3,
        }
    }

    public fun period_ms(arg0: &SetQuotasAction) : u64 {
        arg0.period_ms
    }

    public(friend) fun set_quotas_marker() : SetQuotas {
        SetQuotas{dummy_field: false}
    }

    public fun sponsor_amount(arg0: &SetQuotasAction) : u64 {
        arg0.sponsor_amount
    }

    public fun users(arg0: &SetQuotasAction) : &vector<address> {
        &arg0.users
    }

    // decompiled from Move bytecode v6
}

