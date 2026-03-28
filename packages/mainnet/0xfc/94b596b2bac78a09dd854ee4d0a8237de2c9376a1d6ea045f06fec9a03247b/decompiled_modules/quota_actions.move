module 0xfc94b596b2bac78a09dd854ee4d0a8237de2c9376a1d6ea045f06fec9a03247b::quota_actions {
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

    public fun do_set_quotas<T0: store, T1: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T0>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T0>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T0>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T0>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<SetQuotas>(v1);
        let v2 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v1);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v1) == 1, 0);
        let v3 = 0x2::bcs::new(*v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = 0;
        while (v5 < 0x2::bcs::peel_vec_length(&mut v3)) {
            0x1::vector::push_back<address>(&mut v4, 0x2::bcs::peel_address(&mut v3));
            v5 = v5 + 1;
        };
        let v6 = 0x2::bcs::peel_u64(&mut v3);
        let v7 = 0x2::bcs::peel_u64(&mut v3);
        let v8 = 0x2::bcs::peel_u64(&mut v3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v3);
        let v9 = v7 == 0 && v8 == 0;
        if (!v9) {
            assert!(v6 > 0, 1);
        };
        let v10 = SetQuotasAction{
            users                   : v4,
            period_ms               : v6,
            feeless_proposal_amount : v7,
            sponsor_amount          : v8,
        };
        let v11 = ExecutionProgressWitness{dummy_field: false};
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::set_quotas_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v11, v10.users, v10.period_ms, v10.feeless_proposal_amount, v10.sponsor_amount, arg4);
        let v12 = GovernanceQuotasSet{
            account_id              : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg1),
            num_users               : 0x1::vector::length<address>(&v10.users),
            period_ms               : v10.period_ms,
            feeless_proposal_amount : v10.feeless_proposal_amount,
            sponsor_amount          : v10.sponsor_amount,
        };
        0x2::event::emit<GovernanceQuotasSet>(v12);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T0, SetQuotas, ExecutionProgressWitness>(arg0, arg2, v13);
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

