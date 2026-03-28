module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::memo {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct Memo has drop {
        dummy_field: bool,
    }

    struct MemoEmitted has copy, drop {
        dao_id: 0x2::object::ID,
        memo: 0x1::string::String,
        timestamp: u64,
        emitter: address,
    }

    public fun memo() : Memo {
        Memo{dummy_field: false}
    }

    public fun do_emit_memo<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T1>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: T2, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T1>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<Memo>(v1);
        let v2 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v1);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v1) == 1, 2);
        let v3 = 0x2::bcs::new(*v2);
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v3));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v3);
        assert!(0x1::string::length(&v4) > 0, 0);
        assert!(0x1::string::length(&v4) <= 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::actions_constants::max_memo_length(), 1);
        let v5 = MemoEmitted{
            dao_id    : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg1),
            memo      : v4,
            timestamp : 0x2::clock::timestamp_ms(arg4),
            emitter   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MemoEmitted>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T1, Memo, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    // decompiled from Move bytecode v6
}

