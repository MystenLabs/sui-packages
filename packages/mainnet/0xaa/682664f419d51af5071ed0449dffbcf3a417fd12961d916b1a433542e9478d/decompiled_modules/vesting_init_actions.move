module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vesting_init_actions {
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

    public fun add_cancel_vesting_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        let v0 = CancelVestingAction{
            vesting_id    : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vesting::CancelVesting<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vesting::cancel_vesting<T0>(), 0x2::bcs::to_bytes<CancelVestingAction>(&v0), 1));
    }

    public fun add_create_vesting_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String) {
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
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vesting::CreateVesting<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vesting::create_vesting<T0>(), 0x2::bcs::to_bytes<CreateVestingAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

