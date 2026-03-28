module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::vesting {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreateVesting<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CancelVesting<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VestingRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VestingEntry has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        is_cancellable: bool,
    }

    struct VestingRegistry has store {
        entries: 0x2::vec_map::VecMap<0x2::object::ID, VestingEntry>,
    }

    struct VestingCap has store, key {
        id: 0x2::object::UID,
        vesting_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        dao_address: address,
    }

    struct Vesting<phantom T0> has key {
        id: 0x2::object::UID,
        dao_address: address,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
        amount_per_iteration: u64,
        claimed_amount: u64,
        first_unclaimed_iteration: u64,
        partial_claimed_in_iteration: u64,
        start_time: u64,
        iterations_total: u64,
        iteration_period_ms: u64,
        is_cancellable: bool,
        metadata: 0x1::option::Option<0x1::string::String>,
    }

    struct VestingCreated has copy, drop {
        vesting_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        account_id: address,
        coin_type: 0x1::type_name::TypeName,
        beneficiary: address,
        total_amount: u64,
        amount_per_iteration: u64,
        iterations_total: u64,
        iteration_period_ms: u64,
        start_time: u64,
        is_cancellable: bool,
    }

    struct VestingClaimed has copy, drop {
        vesting_id: 0x2::object::ID,
        account_id: address,
        coin_type: 0x1::type_name::TypeName,
        claimer: address,
        amount: u64,
        remaining_balance: u64,
        total_claimed: u64,
    }

    struct VestingCancelled has copy, drop {
        vesting_id: 0x2::object::ID,
        account_id: address,
        coin_type: 0x1::type_name::TypeName,
        refunded_to_dao: u64,
    }

    public fun destroy_empty<T0>(arg0: Vesting<T0>, arg1: VestingCap, arg2: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg3: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry) {
        let Vesting {
            id                           : v0,
            dao_address                  : _,
            balance                      : v2,
            coin_type                    : _,
            amount_per_iteration         : _,
            claimed_amount               : _,
            first_unclaimed_iteration    : _,
            partial_claimed_in_iteration : _,
            start_time                   : _,
            iterations_total             : _,
            iteration_period_ms          : _,
            is_cancellable               : _,
            metadata                     : _,
        } = arg0;
        let v13 = v2;
        let v14 = v0;
        let v15 = 0x2::object::uid_to_inner(&v14);
        assert!(arg1.vesting_id == v15, 8);
        assert!(arg1.dao_address == 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg2), 8);
        assert!(0x2::balance::value<T0>(&v13) == 0, 0);
        let v16 = VestingRegistryKey{dummy_field: false};
        if (0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<VestingRegistryKey>(arg2, v16)) {
            let v17 = VestingRegistryKey{dummy_field: false};
            let v18 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_mut_with_package_witness<VestingRegistryKey, VestingRegistry>(arg2, arg3, v17, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::actions_version::current());
            if (0x2::vec_map::contains<0x2::object::ID, VestingEntry>(&v18.entries, &v15)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, VestingEntry>(&mut v18.entries, &v15);
            };
        };
        0x2::balance::destroy_zero<T0>(v13);
        0x2::object::delete(v14);
        let VestingCap {
            id          : v21,
            vesting_id  : _,
            account_id  : _,
            dao_address : _,
        } = arg1;
        0x2::object::delete(v21);
    }

    public fun balance_value<T0>(arg0: &Vesting<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun calculate_claimable<T0>(arg0: &Vesting<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::option::none<u64>();
        let (v1, _, _) = 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::stream_utils::calculate_available_with_tracking(arg0.amount_per_iteration, arg0.first_unclaimed_iteration, arg0.partial_claimed_in_iteration, arg0.start_time, arg0.iterations_total, arg0.iteration_period_ms, 0x2::clock::timestamp_ms(arg1), &v0);
        v1
    }

    public(friend) fun cancel_vesting<T0>() : CancelVesting<T0> {
        CancelVesting<T0>{dummy_field: false}
    }

    public fun claim<T0>(arg0: &mut Vesting<T0>, arg1: &VestingCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vesting_id == 0x2::object::uid_to_inner(&arg0.id), 8);
        assert!(arg1.dao_address == arg0.dao_address, 8);
        do_claim_internal<T0>(arg0, arg2, arg3, arg4)
    }

    public fun cleanup_depleted_vesting<T0>(arg0: &Vesting<T0>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry) {
        assert!(arg0.dao_address == 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1), 7);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 0);
        let v0 = 0x2::object::id<Vesting<T0>>(arg0);
        let v1 = VestingRegistryKey{dummy_field: false};
        if (0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<VestingRegistryKey>(arg1, v1)) {
            let v2 = VestingRegistryKey{dummy_field: false};
            let v3 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_mut_with_package_witness<VestingRegistryKey, VestingRegistry>(arg1, arg2, v2, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::actions_version::current());
            if (0x2::vec_map::contains<0x2::object::ID, VestingEntry>(&v3.entries, &v0)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, VestingEntry>(&mut v3.entries, &v0);
            };
        };
    }

    public(friend) fun create_vesting<T0>() : CreateVesting<T0> {
        CreateVesting<T0>{dummy_field: false}
    }

    public fun destroy_vesting_cap(arg0: VestingCap) {
        let VestingCap {
            id          : v0,
            vesting_id  : _,
            account_id  : _,
            dao_address : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun do_cancel_vesting<T0: store, T1, T2: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T0>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: Vesting<T1>, arg4: &0x2::clock::Clock, arg5: T2, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T0>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T0>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T0>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<CancelVesting<T1>>(v1);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v1) == 1, 6);
        let v2 = 0x2::bcs::new(*0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<Vesting<T1>>(&arg3) == v3, 2);
        assert!(arg3.dao_address == 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1), 7);
        assert!(arg3.is_cancellable, 4);
        let v4 = VestingRegistryKey{dummy_field: false};
        if (0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<VestingRegistryKey>(arg1, v4)) {
            let v5 = VestingRegistryKey{dummy_field: false};
            let v6 = ExecutionProgressWitness{dummy_field: false};
            let v7 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_mut<VestingRegistryKey, VestingRegistry, T0, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
            if (0x2::vec_map::contains<0x2::object::ID, VestingEntry>(&v7.entries, &v3)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, VestingEntry>(&mut v7.entries, &v3);
            };
        };
        let Vesting {
            id                           : v10,
            dao_address                  : v11,
            balance                      : v12,
            coin_type                    : _,
            amount_per_iteration         : _,
            claimed_amount               : _,
            first_unclaimed_iteration    : _,
            partial_claimed_in_iteration : _,
            start_time                   : _,
            iterations_total             : _,
            iteration_period_ms          : _,
            is_cancellable               : _,
            metadata                     : _,
        } = arg3;
        let v23 = v12;
        let v24 = v10;
        let v25 = VestingCancelled{
            vesting_id      : 0x2::object::uid_to_inner(&v24),
            account_id      : v11,
            coin_type       : 0x1::type_name::get<T1>(),
            refunded_to_dao : 0x2::balance::value<T1>(&v23),
        };
        0x2::event::emit<VestingCancelled>(v25);
        0x2::object::delete(v24);
        let v26 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable_resources::provide_coin<T1, T0, ExecutionProgressWitness>(arg0, arg2, v26, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 0x2::coin::from_balance<T1>(v23, arg6), arg6);
        let v27 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T0, CancelVesting<T1>, ExecutionProgressWitness>(arg0, arg2, v27);
    }

    fun do_claim_internal<T0>(arg0: &mut Vesting<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 16);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance) > 0, 3);
        let v1 = 0x1::option::none<u64>();
        let (v2, v3, v4) = 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::stream_utils::calculate_available_with_tracking(arg0.amount_per_iteration, arg0.first_unclaimed_iteration, arg0.partial_claimed_in_iteration, arg0.start_time, arg0.iterations_total, arg0.iteration_period_ms, v0, &v1);
        assert!(v2 >= arg1, 10);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 10);
        let (v5, v6) = 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::stream_utils::advance_claim_tracking(v3, v4, arg1, arg0.amount_per_iteration);
        arg0.first_unclaimed_iteration = v5;
        arg0.partial_claimed_in_iteration = v6;
        arg0.claimed_amount = arg0.claimed_amount + arg1;
        let v7 = VestingClaimed{
            vesting_id        : 0x2::object::uid_to_inner(&arg0.id),
            account_id        : arg0.dao_address,
            coin_type         : 0x1::type_name::get<T0>(),
            claimer           : 0x2::tx_context::sender(arg3),
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance) - arg1,
            total_claimed     : arg0.claimed_amount,
        };
        0x2::event::emit<VestingClaimed>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3)
    }

    public fun do_create_vesting<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T1>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T1>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<CreateVesting<T2>>(v1);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v1) == 1, 6);
        let v2 = 0x2::bcs::new(*0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_address(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v2))
        } else {
            0x1::option::none<u64>()
        };
        let v6 = v5;
        let v7 = 0x2::bcs::peel_u64(&mut v2);
        let v8 = 0x2::bcs::peel_u64(&mut v2);
        let v9 = 0x2::bcs::peel_bool(&mut v2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v3 != @0x0, 19);
        let v10 = if (0x1::option::is_some<u64>(&v6)) {
            *0x1::option::borrow<u64>(&v6)
        } else {
            0x2::clock::timestamp_ms(arg3)
        };
        let v11 = 0x1::option::none<u64>();
        assert!(0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::stream_utils::validate_iteration_parameters(v10, v7, v8, &v11, 0x2::clock::timestamp_ms(arg3)), 15);
        assert!(v4 > 0, 16);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        let v13 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable_resources::take_coin<T2, T1, ExecutionProgressWitness>(arg0, arg2, v12, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        let v14 = (v4 as u128) * (v7 as u128);
        assert!(v14 <= 18446744073709551615, 15);
        assert!(0x2::coin::value<T2>(&v13) == (v14 as u64), 17);
        let v15 = 0x2::object::new(arg5);
        let v16 = 0x2::object::uid_to_inner(&v15);
        let v17 = VestingRegistryKey{dummy_field: false};
        if (!0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<VestingRegistryKey>(arg1, v17)) {
            let v18 = VestingRegistryKey{dummy_field: false};
            let v19 = VestingRegistry{entries: 0x2::vec_map::empty<0x2::object::ID, VestingEntry>()};
            let v20 = ExecutionProgressWitness{dummy_field: false};
            0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::add_managed_data<VestingRegistryKey, VestingRegistry, T1, ExecutionProgressWitness>(arg1, arg2, v18, v19, arg0, v20);
        };
        let v21 = VestingRegistryKey{dummy_field: false};
        let v22 = ExecutionProgressWitness{dummy_field: false};
        let v23 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_mut<VestingRegistryKey, VestingRegistry, T1, ExecutionProgressWitness>(arg1, arg2, v21, arg0, v22);
        assert!(0x2::vec_map::size<0x2::object::ID, VestingEntry>(&v23.entries) < 100, 20);
        let v24 = VestingEntry{
            coin_type      : 0x1::type_name::get<T2>(),
            is_cancellable : v9,
        };
        0x2::vec_map::insert<0x2::object::ID, VestingEntry>(&mut v23.entries, v16, v24);
        let v25 = Vesting<T2>{
            id                           : v15,
            dao_address                  : 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1),
            balance                      : 0x2::coin::into_balance<T2>(v13),
            coin_type                    : 0x1::type_name::get<T2>(),
            amount_per_iteration         : v4,
            claimed_amount               : 0,
            first_unclaimed_iteration    : 0,
            partial_claimed_in_iteration : 0,
            start_time                   : v10,
            iterations_total             : v7,
            iteration_period_ms          : v8,
            is_cancellable               : v9,
            metadata                     : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::share_object<Vesting<T2>>(v25);
        let v26 = VestingCap{
            id          : 0x2::object::new(arg5),
            vesting_id  : v16,
            account_id  : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg1),
            dao_address : 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1),
        };
        0x2::transfer::public_transfer<VestingCap>(v26, v3);
        let v27 = VestingCreated{
            vesting_id           : v16,
            cap_id               : 0x2::object::id<VestingCap>(&v26),
            account_id           : 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1),
            coin_type            : 0x1::type_name::get<T2>(),
            beneficiary          : v3,
            total_amount         : 0x2::coin::value<T2>(&v13),
            amount_per_iteration : v4,
            iterations_total     : v7,
            iteration_period_ms  : v8,
            start_time           : v10,
            is_cancellable       : v9,
        };
        0x2::event::emit<VestingCreated>(v27);
        let v28 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T1, CreateVesting<T2>, ExecutionProgressWitness>(arg0, arg2, v28);
    }

    public fun has_vesting_registry(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account) : bool {
        let v0 = VestingRegistryKey{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<VestingRegistryKey>(arg0, v0)
    }

    public fun next_vest_time<T0>(arg0: &Vesting<T0>, arg1: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_time) {
            let v1 = (arg0.start_time as u128) + (arg0.iteration_period_ms as u128);
            if (v1 > 18446744073709551615) {
                return 0x1::option::none<u64>()
            };
            return 0x1::option::some<u64>((v1 as u64))
        };
        let v2 = (v0 - arg0.start_time) / arg0.iteration_period_ms;
        if (v2 >= arg0.iterations_total) {
            return 0x1::option::none<u64>()
        };
        let v3 = (arg0.start_time as u128) + ((v2 as u128) + 1) * (arg0.iteration_period_ms as u128);
        if (v3 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v3 as u64))
    }

    public fun total_amount<T0>(arg0: &Vesting<T0>) : u64 {
        let v0 = (arg0.amount_per_iteration as u128) * (arg0.iterations_total as u128);
        assert!(v0 <= 18446744073709551615, 15);
        (v0 as u64)
    }

    public fun vesting_amount_per_iteration<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.amount_per_iteration
    }

    public fun vesting_cap_account_id(arg0: &VestingCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun vesting_cap_dao_address(arg0: &VestingCap) : address {
        arg0.dao_address
    }

    public fun vesting_cap_vesting_id(arg0: &VestingCap) : 0x2::object::ID {
        arg0.vesting_id
    }

    public fun vesting_claimed_amount<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.claimed_amount
    }

    public fun vesting_dao<T0>(arg0: &Vesting<T0>) : address {
        arg0.dao_address
    }

    public fun vesting_entry_coin_type(arg0: &VestingEntry) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun vesting_entry_is_cancellable(arg0: &VestingEntry) : bool {
        arg0.is_cancellable
    }

    public fun vesting_is_cancellable<T0>(arg0: &Vesting<T0>) : bool {
        arg0.is_cancellable
    }

    public fun vesting_iteration_period_ms<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.iteration_period_ms
    }

    public fun vesting_iterations_total<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.iterations_total
    }

    public fun vesting_metadata<T0>(arg0: &Vesting<T0>) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata
    }

    public fun vesting_registry_entries(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry) : &0x2::vec_map::VecMap<0x2::object::ID, VestingEntry> {
        let v0 = VestingRegistryKey{dummy_field: false};
        &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_with_package_witness<VestingRegistryKey, VestingRegistry>(arg0, arg1, v0, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::actions_version::current()).entries
    }

    public fun vesting_start_time<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.start_time
    }

    // decompiled from Move bytecode v6
}

