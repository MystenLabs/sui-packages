module 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vesting_init_actions {
    struct CreateVestingAction has copy, drop, store {
        beneficiary: address,
        amount_per_iteration: u64,
        start_time: 0x1::option::Option<u64>,
        iterations_total: u64,
        iteration_period_ms: u64,
        is_cancellable: bool,
        resource_name: 0x1::string::String,
    }

    struct CancelVestingAction has copy, drop, store {
        vesting_id: address,
        resource_name: 0x1::string::String,
    }

    public fun add_cancel_vesting_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        let v0 = CancelVestingAction{
            vesting_id    : arg1,
            resource_name : arg2,
        };
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vesting::CancelVesting<T0>>(), 0x2::bcs::to_bytes<CancelVestingAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_address(&mut v1, b"vesting_id", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vesting::CancelVesting<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_vesting_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 > 0, 2);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0, 2);
        let v0 = CreateVestingAction{
            beneficiary          : arg1,
            amount_per_iteration : arg2,
            start_time           : arg3,
            iterations_total     : arg4,
            iteration_period_ms  : arg5,
            is_cancellable       : arg6,
            resource_name        : arg7,
        };
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vesting::CreateVesting<T0>>(), 0x2::bcs::to_bytes<CreateVestingAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_address(&mut v1, b"beneficiary", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"amount_per_iteration", arg2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_option_u64(&mut v1, b"start_time", arg3);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"iterations_total", arg4);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"iteration_period_ms", arg5);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_bool(&mut v1, b"is_cancellable", arg6);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"resource_name", arg7);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vesting::CreateVesting<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

