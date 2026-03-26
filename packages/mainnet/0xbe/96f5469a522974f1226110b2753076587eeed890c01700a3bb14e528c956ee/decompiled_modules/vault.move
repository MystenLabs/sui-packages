module 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::vault {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct VaultDeposit<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultSpend<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultApproveCoinType<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultRemoveApprovedCoinType<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CancelStream<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CreateStream<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CollectStream<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultDepositExternal<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultDepositFromResources<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultDepositObjectFromResources<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultOpen has drop {
        dummy_field: bool,
    }

    struct VaultClose has drop {
        dummy_field: bool,
    }

    struct MintVaultAdminCap has drop {
        dummy_field: bool,
    }

    struct StreamCap has store, key {
        id: 0x2::object::UID,
        stream_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        account_addr: address,
        vault_name: 0x1::string::String,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
        vault_name: 0x1::string::String,
        account_id: 0x2::object::ID,
    }

    struct VaultKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct VaultNamesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault has store {
        bag: 0x2::bag::Bag,
        streams: 0x2::table::Table<0x2::object::ID, VaultStream>,
        approved_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VaultStream has drop, store {
        id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount_per_iteration: u64,
        claimed_amount: u64,
        first_unclaimed_iteration: u64,
        partial_claimed_in_iteration: u64,
        start_time: u64,
        iterations_total: u64,
        iteration_period_ms: u64,
        claim_window_ms: 0x1::option::Option<u64>,
    }

    struct VaultDeposited has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct VaultSpent has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        resource_name: 0x1::string::String,
    }

    struct CoinTypeApproved has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinTypeApprovalRemoved has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
    }

    struct VaultOpened has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
    }

    struct VaultClosed has copy, drop {
        account_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
    }

    struct StreamCreated has copy, drop {
        account_id: 0x2::object::ID,
        stream_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        beneficiary: address,
        total_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        iterations_total: u64,
        iteration_period_ms: u64,
    }

    struct StreamCollected has copy, drop {
        account_id: 0x2::object::ID,
        stream_id: 0x2::object::ID,
        amount: u64,
        remaining_vested: u64,
        resource_name: 0x1::string::String,
    }

    struct StreamCancelled has copy, drop {
        account_id: 0x2::object::ID,
        stream_id: 0x2::object::ID,
        refunded_amount: u64,
        final_payment: u64,
    }

    public fun balance<T0: store, T1>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : u64 {
        if (!has_vault(arg0, arg2)) {
            return 0
        };
        let v0 = VaultKey{pos0: arg2};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        if (!coin_type_exists<T1>(v1)) {
            return 0
        };
        coin_type_value<T1>(v1)
    }

    public fun max_vaults() : u64 {
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_constants::max_vaults()
    }

    public fun admin_cap_account_id(arg0: &VaultAdminCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun admin_cap_vault_name(arg0: &VaultAdminCap) : 0x1::string::String {
        arg0.vault_name
    }

    public fun borrow_vault(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : &Vault {
        let v0 = VaultKey{pos0: arg2};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current())
    }

    public fun calculate_claimable<T0: store>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : u64 {
        let v0 = VaultKey{pos0: arg2};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        assert!(0x2::table::contains<0x2::object::ID, VaultStream>(&v1.streams, arg3), 1);
        let v2 = 0x2::table::borrow<0x2::object::ID, VaultStream>(&v1.streams, arg3);
        let (v3, _, _) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::calculate_available_with_tracking(v2.amount_per_iteration, v2.first_unclaimed_iteration, v2.partial_claimed_in_iteration, v2.start_time, v2.iterations_total, v2.iteration_period_ms, 0x2::clock::timestamp_ms(arg4), &v2.claim_window_ms);
        v3
    }

    public(friend) fun cancel_stream_marker<T0>() : CancelStream<T0> {
        CancelStream<T0>{dummy_field: false}
    }

    public fun coin_type_exists<T0>(arg0: &Vault) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, 0x1::type_name::with_original_ids<T0>())
    }

    public fun coin_type_value<T0>(arg0: &Vault) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, 0x1::type_name::with_original_ids<T0>()))
    }

    public fun collect_stream<T0: store, T1>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &StreamCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0);
        assert!(arg2.account_id == v0, 37);
        assert!(arg2.account_addr == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg0), 37);
        let v1 = VaultKey{pos0: arg2.vault_name};
        let v2 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut_with_package_witness<VaultKey, Vault>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        assert!(0x2::table::contains<0x2::object::ID, VaultStream>(&v2.streams, arg2.stream_id), 1);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, VaultStream>(&mut v2.streams, arg2.stream_id);
        let v4 = v3.coin_type;
        let v5 = 0x2::clock::timestamp_ms(arg4);
        assert!(v5 >= v3.start_time, 2);
        let (v6, v7, v8) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::calculate_available_with_tracking(v3.amount_per_iteration, v3.first_unclaimed_iteration, v3.partial_claimed_in_iteration, v3.start_time, v3.iterations_total, v3.iteration_period_ms, v5, &v3.claim_window_ms);
        let v9 = if (arg3 == 0) {
            v6
        } else {
            arg3
        };
        assert!(v6 >= v9, 8);
        let (v10, v11) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::advance_claim_tracking(v7, v8, v9, v3.amount_per_iteration);
        v3.first_unclaimed_iteration = v10;
        v3.partial_claimed_in_iteration = v11;
        v3.claimed_amount = v3.claimed_amount + v9;
        let v12 = v10 >= v3.iterations_total;
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v2.bag, v4), 23);
        let v13 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v2.bag, v4);
        let v14 = StreamCollected{
            account_id       : v0,
            stream_id        : arg2.stream_id,
            amount           : v9,
            remaining_vested : v6 - v9,
            resource_name    : 0x1::string::utf8(b""),
        };
        0x2::event::emit<StreamCollected>(v14);
        if (0x2::balance::value<T1>(v13) == 0) {
            0x2::balance::destroy_zero<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v2.bag, v4));
        };
        if (v12) {
            0x2::table::remove<0x2::object::ID, VaultStream>(&mut v2.streams, arg2.stream_id);
        };
        0x2::coin::take<T1>(v13, v9, arg5)
    }

    public(friend) fun collect_stream_marker<T0>() : CollectStream<T0> {
        CollectStream<T0>{dummy_field: false}
    }

    public(friend) fun create_stream_internal<T0: store, T1>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::validate_iteration_parameters(arg5, arg6, arg7, &arg8, 0x2::clock::timestamp_ms(arg9)), 9);
        assert!(arg4 > 0, 20);
        assert!(arg3 != @0x0, 35);
        let v0 = VaultKey{pos0: arg2};
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultKey>(arg0, v0), 21);
        let v1 = 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0);
        let v2 = VaultKey{pos0: arg2};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut_with_package_witness<VaultKey, Vault>(arg0, arg1, v2, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v4 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v3.bag, v4), 22);
        let v5 = (arg4 as u128) * (arg6 as u128);
        assert!(v5 <= 18446744073709551615, 23);
        let v6 = 0x2::object::new(arg10);
        0x2::object::delete(v6);
        let v7 = VaultStream{
            id                           : 0x2::object::uid_to_inner(&v6),
            coin_type                    : v4,
            amount_per_iteration         : arg4,
            claimed_amount               : 0,
            first_unclaimed_iteration    : 0,
            partial_claimed_in_iteration : 0,
            start_time                   : arg5,
            iterations_total             : arg6,
            iteration_period_ms          : arg7,
            claim_window_ms              : arg8,
        };
        let v8 = v7.id;
        0x2::table::add<0x2::object::ID, VaultStream>(&mut v3.streams, v8, v7);
        let v9 = StreamCap{
            id           : 0x2::object::new(arg10),
            stream_id    : v8,
            account_id   : v1,
            account_addr : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg0),
            vault_name   : arg2,
        };
        0x2::transfer::public_transfer<StreamCap>(v9, arg3);
        let v10 = StreamCreated{
            account_id          : v1,
            stream_id           : v8,
            cap_id              : 0x2::object::id<StreamCap>(&v9),
            beneficiary         : arg3,
            total_amount        : (v5 as u64),
            coin_type           : v4,
            start_time          : arg5,
            iterations_total    : arg6,
            iteration_period_ms : arg7,
        };
        0x2::event::emit<StreamCreated>(v10);
        v8
    }

    public(friend) fun create_stream_marker<T0>() : CreateStream<T0> {
        CreateStream<T0>{dummy_field: false}
    }

    public fun default_vault_name() : 0x1::string::String {
        0x1::string::utf8(b"Main Vault")
    }

    public fun deposit_approved<T0: store, T1>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg3) > 0, 20);
        let v0 = VaultKey{pos0: arg2};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.approved_types, &v2), 5);
        if (coin_type_exists<T1>(v1)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.bag, v2), 0x2::coin::into_balance<T1>(arg3));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.bag, v2, 0x2::coin::into_balance<T1>(arg3));
        };
        let v3 = VaultDeposited{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0),
            vault_name : arg2,
            coin_type  : v2,
            amount     : 0x2::coin::value<T1>(&arg3),
        };
        0x2::event::emit<VaultDeposited>(v3);
    }

    public fun destroy_stream_cap(arg0: StreamCap, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) {
        let StreamCap {
            id           : v0,
            stream_id    : v1,
            account_id   : v2,
            account_addr : _,
            vault_name   : v4,
        } = arg0;
        assert!(v2 == 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1), 37);
        let v5 = VaultKey{pos0: v4};
        if (0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultKey>(arg1, v5)) {
            let v6 = VaultKey{pos0: v4};
            assert!(!0x2::table::contains<0x2::object::ID, VaultStream>(&0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg1, arg2, v6, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).streams, v1), 36);
        };
        0x2::object::delete(v0);
    }

    public fun destroy_vault_admin_cap(arg0: VaultAdminCap) {
        let VaultAdminCap {
            id         : v0,
            vault_name : _,
            account_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun do_approve_coin_type<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultApproveCoinType<T2>>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = VaultKey{pos0: v3};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        let v7 = 0x1::type_name::with_original_ids<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v6.approved_types, &v7)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v6.approved_types, v7);
        };
        let v8 = CoinTypeApproved{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v3,
            coin_type  : v7,
        };
        0x2::event::emit<CoinTypeApproved>(v8);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultApproveCoinType<T2>, ExecutionProgressWitness>(arg0, arg2, v9);
    }

    public fun do_cancel_stream<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<CancelStream<T2>>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = VaultKey{pos0: 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1))};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4);
        assert!(0x2::table::contains<0x2::object::ID, VaultStream>(&v5.streams, v2), 1);
        let v6 = 0x2::table::remove<0x2::object::ID, VaultStream>(&mut v5.streams, v2);
        assert!(v6.coin_type == 0x1::type_name::with_original_ids<T2>(), 5);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        let v8 = if (v7 >= v6.start_time) {
            let (v9, _, _) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::calculate_available_with_tracking(v6.amount_per_iteration, v6.first_unclaimed_iteration, v6.partial_claimed_in_iteration, v6.start_time, v6.iterations_total, v6.iteration_period_ms, v7, &v6.claim_window_ms);
            v9
        } else {
            0
        };
        let v12 = StreamCancelled{
            account_id      : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            stream_id       : v2,
            refunded_amount : 0,
            final_payment   : v8,
        };
        0x2::event::emit<StreamCancelled>(v12);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, CancelStream<T2>, ExecutionProgressWitness>(arg0, arg2, v13);
    }

    public fun do_collect_stream<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<CollectStream<T2>>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        let v6 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        let v8 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::take_object<StreamCap, T1, ExecutionProgressWitness>(arg0, arg2, v7, v6);
        let v9 = 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1);
        assert!(v8.stream_id == v3, 37);
        assert!(v8.account_id == v9, 37);
        assert!(v8.account_addr == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1), 37);
        assert!(v8.vault_name == v2, 37);
        let v10 = VaultKey{pos0: v2};
        let v11 = ExecutionProgressWitness{dummy_field: false};
        let v12 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v10, arg0, v11);
        assert!(0x2::table::contains<0x2::object::ID, VaultStream>(&v12.streams, v3), 1);
        let v13 = 0x2::table::borrow_mut<0x2::object::ID, VaultStream>(&mut v12.streams, v3);
        let v14 = v13.coin_type;
        let v15 = 0x2::clock::timestamp_ms(arg3);
        assert!(v15 >= v13.start_time, 2);
        let (v16, v17, v18) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::calculate_available_with_tracking(v13.amount_per_iteration, v13.first_unclaimed_iteration, v13.partial_claimed_in_iteration, v13.start_time, v13.iterations_total, v13.iteration_period_ms, v15, &v13.claim_window_ms);
        let v19 = if (v5 == 0) {
            v16
        } else {
            v5
        };
        assert!(v16 >= v19, 8);
        let (v20, v21) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::advance_claim_tracking(v17, v18, v19, v13.amount_per_iteration);
        v13.first_unclaimed_iteration = v20;
        v13.partial_claimed_in_iteration = v21;
        v13.claimed_amount = v13.claimed_amount + v19;
        let v22 = v20 >= v13.iterations_total;
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v12.bag, v14), 23);
        let v23 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v12.bag, v14);
        let v24 = StreamCollected{
            account_id       : v9,
            stream_id        : v3,
            amount           : v19,
            remaining_vested : v16 - v19,
            resource_name    : v4,
        };
        0x2::event::emit<StreamCollected>(v24);
        if (0x2::balance::value<T2>(v23) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v12.bag, v14));
        };
        if (v22) {
            0x2::table::remove<0x2::object::ID, VaultStream>(&mut v12.streams, v3);
        };
        let v25 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::provide_coin<T2, T1, ExecutionProgressWitness>(arg0, arg2, v25, v4, 0x2::coin::take<T2>(v23, v19, arg5), arg5);
        let v26 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::provide_object<StreamCap, T1, ExecutionProgressWitness>(arg0, arg2, v26, v6, v8, arg5);
        let v27 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, CollectStream<T2>, ExecutionProgressWitness>(arg0, arg2, v27);
    }

    public fun do_deposit_external<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: 0x2::coin::Coin<T2>, arg4: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultDepositExternal<T2>>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = 0x2::coin::value<T2>(&arg3);
        assert!(v3 == 0x2::bcs::peel_u64(&mut v1), 10);
        let v4 = VaultKey{pos0: v2};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        let v7 = 0x1::type_name::with_original_ids<T2>();
        if (!coin_type_exists<T2>(v6)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v6.bag, v7, 0x2::coin::into_balance<T2>(arg3));
        } else {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v6.bag, v7), 0x2::coin::into_balance<T2>(arg3));
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v6.approved_types, &v7)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v6.approved_types, v7);
        };
        let v8 = VaultDeposited{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v2,
            coin_type  : v7,
            amount     : v3,
        };
        0x2::event::emit<VaultDeposited>(v8);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultDepositExternal<T2>, ExecutionProgressWitness>(arg0, arg2, v9);
    }

    public fun do_init_close<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T2) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultClose>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = VaultKey{pos0: v3};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let Vault {
            bag            : v6,
            streams        : v7,
            approved_types : _,
        } = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::remove_managed_data<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        let v9 = v7;
        let v10 = v6;
        assert!(0x2::bag::is_empty(&v10), 0);
        assert!(0x2::table::is_empty<0x2::object::ID, VaultStream>(&v9), 0);
        0x2::bag::destroy_empty(v10);
        0x2::table::destroy_empty<0x2::object::ID, VaultStream>(v9);
        let v11 = VaultNamesKey{dummy_field: false};
        if (0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultNamesKey>(arg1, v11)) {
            let v12 = VaultNamesKey{dummy_field: false};
            let v13 = ExecutionProgressWitness{dummy_field: false};
            let v14 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultNamesKey, vector<0x1::string::String>, T1, ExecutionProgressWitness>(arg1, arg2, v12, arg0, v13);
            let (v15, v16) = 0x1::vector::index_of<0x1::string::String>(v14, &v3);
            if (v15) {
                0x1::vector::remove<0x1::string::String>(v14, v16);
            };
        };
        let v17 = VaultClosed{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v3,
        };
        0x2::event::emit<VaultClosed>(v17);
        let v18 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultClose, ExecutionProgressWitness>(arg0, arg2, v18);
    }

    public fun do_init_create_stream<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v2))
        } else {
            0x1::option::none<u64>()
        };
        let v4 = v3;
        let v5 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v2))
        } else {
            0x1::option::none<u64>()
        };
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v6 = if (0x1::option::is_some<u64>(&v4)) {
            *0x1::option::borrow<u64>(&v4)
        } else {
            0x2::clock::timestamp_ms(arg3)
        };
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, CreateStream<T2>, ExecutionProgressWitness>(arg0, arg2, v7);
        create_stream_internal<T0, T2>(arg1, arg2, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 0x2::bcs::peel_address(&mut v2), 0x2::bcs::peel_u64(&mut v2), v6, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), v5, arg3, arg5)
    }

    public fun do_init_deposit<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultDeposit<T2>>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::take_coin<T2, T1, ExecutionProgressWitness>(arg0, arg2, v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        assert!(v4 == 0x2::coin::value<T2>(&v6), 10);
        let v7 = VaultKey{pos0: v3};
        let v8 = ExecutionProgressWitness{dummy_field: false};
        let v9 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v7, arg0, v8);
        let v10 = 0x1::type_name::with_original_ids<T2>();
        if (!coin_type_exists<T2>(v9)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v9.bag, v10, 0x2::coin::into_balance<T2>(v6));
        } else {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v9.bag, v10), 0x2::coin::into_balance<T2>(v6));
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v9.approved_types, &v10)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v9.approved_types, v10);
        };
        let v11 = VaultDeposited{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v3,
            coin_type  : v10,
            amount     : v4,
        };
        0x2::event::emit<VaultDeposited>(v11);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultDeposit<T2>, ExecutionProgressWitness>(arg0, arg2, v12);
    }

    public fun do_init_deposit_from_resources<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultDepositFromResources<T2>>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        let v4 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::take_coin<T2, T1, ExecutionProgressWitness>(arg0, arg2, v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
        let v5 = VaultKey{pos0: v2};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        let v7 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
        let v8 = 0x1::type_name::with_original_ids<T2>();
        if (!coin_type_exists<T2>(v7)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, v8, 0x2::coin::into_balance<T2>(v4));
        } else {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, v8), 0x2::coin::into_balance<T2>(v4));
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v7.approved_types, &v8)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v7.approved_types, v8);
        };
        let v9 = VaultDeposited{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v2,
            coin_type  : v8,
            amount     : 0x2::coin::value<T2>(&v4),
        };
        0x2::event::emit<VaultDeposited>(v9);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultDepositFromResources<T2>, ExecutionProgressWitness>(arg0, arg2, v10);
    }

    public fun do_init_deposit_object_from_resources<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultDepositObjectFromResources<T2>>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        let v4 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::take_object<0x2::coin::Coin<T2>, T1, ExecutionProgressWitness>(arg0, arg2, v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
        let v5 = VaultKey{pos0: v2};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        let v7 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
        let v8 = 0x1::type_name::with_original_ids<T2>();
        if (!coin_type_exists<T2>(v7)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, v8, 0x2::coin::into_balance<T2>(v4));
        } else {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, v8), 0x2::coin::into_balance<T2>(v4));
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v7.approved_types, &v8)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v7.approved_types, v8);
        };
        let v9 = VaultDeposited{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v2,
            coin_type  : v8,
            amount     : 0x2::coin::value<T2>(&v4),
        };
        0x2::event::emit<VaultDeposited>(v9);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultDepositObjectFromResources<T2>, ExecutionProgressWitness>(arg0, arg2, v10);
    }

    public fun do_init_open<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultOpen>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = VaultKey{pos0: v3};
        assert!(!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultKey>(arg1, v4), 34);
        let v5 = VaultNamesKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultNamesKey>(arg1, v5)) {
            let v6 = VaultNamesKey{dummy_field: false};
            let v7 = ExecutionProgressWitness{dummy_field: false};
            0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data<VaultNamesKey, vector<0x1::string::String>, T1, ExecutionProgressWitness>(arg1, arg2, v6, 0x1::vector::empty<0x1::string::String>(), arg0, v7);
        };
        let v8 = VaultNamesKey{dummy_field: false};
        assert!(0x1::vector::length<0x1::string::String>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultNamesKey, vector<0x1::string::String>>(arg1, arg2, v8, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current())) < 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_constants::max_vaults(), 33);
        let v9 = VaultNamesKey{dummy_field: false};
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x1::vector::push_back<0x1::string::String>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultNamesKey, vector<0x1::string::String>, T1, ExecutionProgressWitness>(arg1, arg2, v9, arg0, v10), v3);
        let v11 = Vault{
            bag            : 0x2::bag::new(arg4),
            streams        : 0x2::table::new<0x2::object::ID, VaultStream>(arg4),
            approved_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v12 = VaultKey{pos0: v3};
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v12, v11, arg0, v13);
        let v14 = VaultOpened{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v3,
        };
        0x2::event::emit<VaultOpened>(v14);
        let v15 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultOpen, ExecutionProgressWitness>(arg0, arg2, v15);
    }

    public fun do_mint_vault_admin_cap<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<MintVaultAdminCap>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(has_vault(arg1, v2), 21);
        let v3 = VaultAdminCap{
            id         : 0x2::object::new(arg4),
            vault_name : v2,
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
        };
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::provide_object<VaultAdminCap, T0, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), v3, arg4);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, MintVaultAdminCap, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun do_remove_approved_coin_type<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultRemoveApprovedCoinType<T2>>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = VaultKey{pos0: v3};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        let v7 = 0x1::type_name::with_original_ids<T2>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&v6.approved_types, &v7)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v6.approved_types, &v7);
        };
        let v8 = CoinTypeApprovalRemoved{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name : v3,
            coin_type  : v7,
        };
        0x2::event::emit<CoinTypeApprovalRemoved>(v8);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultRemoveApprovedCoinType<T2>, ExecutionProgressWitness>(arg0, arg2, v9);
    }

    public fun do_spend<T0: store, T1: store, T2, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T3, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<VaultSpend<T2>>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 17);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v5 = VaultKey{pos0: v3};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        let v7 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<VaultKey, Vault, T1, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
        let v8 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, 0x1::type_name::with_original_ids<T2>());
        let v9 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x2::balance::value<T2>(v8)
        } else {
            0x2::bcs::peel_u64(&mut v2)
        };
        if (0x2::balance::value<T2>(v8) == 0) {
            0x2::balance::destroy_zero<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.bag, 0x1::type_name::with_original_ids<T2>()));
        };
        let v10 = VaultSpent{
            account_id    : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            vault_name    : v3,
            coin_type     : 0x1::type_name::with_original_ids<T2>(),
            amount        : v9,
            resource_name : v4,
        };
        0x2::event::emit<VaultSpent>(v10);
        let v11 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::provide_coin<T2, T1, ExecutionProgressWitness>(arg0, arg2, v11, v4, 0x2::coin::take<T2>(v8, v9, arg4), arg4);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, VaultSpend<T2>, ExecutionProgressWitness>(arg0, arg2, v12);
    }

    public fun get_total_balance<T0: store, T1>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) : u64 {
        let v0 = VaultNamesKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultNamesKey>(arg0, v0)) {
            return 0
        };
        let v1 = VaultNamesKey{dummy_field: false};
        let v2 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultNamesKey, vector<0x1::string::String>>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::type_name::with_original_ids<T1>();
        while (v4 < 0x1::vector::length<0x1::string::String>(v2)) {
            let v6 = 0x1::vector::borrow<0x1::string::String>(v2, v4);
            if (has_vault(arg0, *v6)) {
                let v7 = VaultKey{pos0: *v6};
                let v8 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v7, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
                if (0x2::bag::contains<0x1::type_name::TypeName>(&v8.bag, v5)) {
                    let v9 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&v8.bag, v5));
                    assert!(v3 <= 18446744073709551615 - v9, 24);
                    v3 = v3 + v9;
                };
            };
            v4 = v4 + 1;
        };
        v3
    }

    public fun has_stream(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x2::object::ID) : bool {
        let v0 = VaultKey{pos0: arg2};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultKey>(arg0, v0)) {
            return false
        };
        let v1 = VaultKey{pos0: arg2};
        0x2::table::contains<0x2::object::ID, VaultStream>(&0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).streams, arg3)
    }

    public fun has_vault(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String) : bool {
        let v0 = VaultKey{pos0: arg1};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultKey>(arg0, v0)
    }

    public fun is_coin_type_approved<T0: store, T1>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : bool {
        if (!has_vault(arg0, arg2)) {
            return false
        };
        let v0 = VaultKey{pos0: arg2};
        let v1 = 0x1::type_name::with_original_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).approved_types, &v1)
    }

    public(friend) fun mint_vault_admin_cap_marker() : MintVaultAdminCap {
        MintVaultAdminCap{dummy_field: false}
    }

    public fun size(arg0: &Vault) : u64 {
        0x2::bag::length(&arg0.bag)
    }

    public fun stream_cap_account_addr(arg0: &StreamCap) : address {
        arg0.account_addr
    }

    public fun stream_cap_account_id(arg0: &StreamCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun stream_cap_stream_id(arg0: &StreamCap) : 0x2::object::ID {
        arg0.stream_id
    }

    public fun stream_cap_vault_name(arg0: &StreamCap) : 0x1::string::String {
        arg0.vault_name
    }

    public fun stream_claimable_now(arg0: &Vault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, VaultStream>(&arg0.streams, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 < v0.start_time) {
            return 0
        };
        let (v2, _, _) = 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::stream_utils::calculate_available_with_tracking(v0.amount_per_iteration, v0.first_unclaimed_iteration, v0.partial_claimed_in_iteration, v0.start_time, v0.iterations_total, v0.iteration_period_ms, v1, &v0.claim_window_ms);
        v2
    }

    public fun stream_info<T0: store>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x2::object::ID) : (u64, u64, u64, u64, u64) {
        let v0 = VaultKey{pos0: arg2};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        assert!(0x2::table::contains<0x2::object::ID, VaultStream>(&v1.streams, arg3), 1);
        let v2 = 0x2::table::borrow<0x2::object::ID, VaultStream>(&v1.streams, arg3);
        (v2.amount_per_iteration, v2.claimed_amount, v2.start_time, v2.iterations_total, v2.iteration_period_ms)
    }

    public fun stream_next_vest_time(arg0: &Vault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::table::borrow<0x2::object::ID, VaultStream>(&arg0.streams, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 < v0.start_time) {
            let v2 = (v0.start_time as u128) + (v0.iteration_period_ms as u128);
            if (v2 > 18446744073709551615) {
                return 0x1::option::none<u64>()
            };
            return 0x1::option::some<u64>((v2 as u64))
        };
        let v3 = (v1 - v0.start_time) / v0.iteration_period_ms;
        if (v3 >= v0.iterations_total) {
            return 0x1::option::none<u64>()
        };
        let v4 = (v0.start_time as u128) + ((v3 as u128) + 1) * (v0.iteration_period_ms as u128);
        if (v4 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v4 as u64))
    }

    public fun treasury_vault() : vector<u8> {
        b"treasury"
    }

    public(friend) fun vault_approve_coin_type_marker<T0>() : VaultApproveCoinType<T0> {
        VaultApproveCoinType<T0>{dummy_field: false}
    }

    public(friend) fun vault_close_marker() : VaultClose {
        VaultClose{dummy_field: false}
    }

    public fun vault_count(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) : u64 {
        let v0 = VaultNamesKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultNamesKey>(arg0, v0)) {
            return 0
        };
        let v1 = VaultNamesKey{dummy_field: false};
        0x1::vector::length<0x1::string::String>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultNamesKey, vector<0x1::string::String>>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()))
    }

    public(friend) fun vault_deposit_external_marker<T0>() : VaultDepositExternal<T0> {
        VaultDepositExternal<T0>{dummy_field: false}
    }

    public(friend) fun vault_deposit_from_resources_marker<T0>() : VaultDepositFromResources<T0> {
        VaultDepositFromResources<T0>{dummy_field: false}
    }

    public(friend) fun vault_deposit_marker<T0>() : VaultDeposit<T0> {
        VaultDeposit<T0>{dummy_field: false}
    }

    public(friend) fun vault_deposit_object_from_resources_marker<T0>() : VaultDepositObjectFromResources<T0> {
        VaultDepositObjectFromResources<T0>{dummy_field: false}
    }

    public fun vault_names(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) : vector<0x1::string::String> {
        let v0 = VaultNamesKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<VaultNamesKey>(arg0, v0)) {
            return 0x1::vector::empty<0x1::string::String>()
        };
        let v1 = VaultNamesKey{dummy_field: false};
        *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<VaultNamesKey, vector<0x1::string::String>>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current())
    }

    public(friend) fun vault_open_marker() : VaultOpen {
        VaultOpen{dummy_field: false}
    }

    public(friend) fun vault_remove_approved_coin_type_marker<T0>() : VaultRemoveApprovedCoinType<T0> {
        VaultRemoveApprovedCoinType<T0>{dummy_field: false}
    }

    public(friend) fun vault_spend_marker<T0>() : VaultSpend<T0> {
        VaultSpend<T0>{dummy_field: false}
    }

    public fun withdraw_with_admin_cap<T0: store, T1>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &VaultAdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2.account_id == 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0), 38);
        assert!(arg3 > 0, 20);
        let v0 = VaultKey{pos0: arg2.vault_name};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut_with_package_witness<VaultKey, Vault>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v1.bag, v2), 22);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.bag, v2);
        assert!(0x2::balance::value<T1>(v3) >= arg3, 23);
        if (0x2::balance::value<T1>(v3) == 0) {
            0x2::balance::destroy_zero<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.bag, v2));
        };
        let v4 = VaultSpent{
            account_id    : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0),
            vault_name    : arg2.vault_name,
            coin_type     : v2,
            amount        : arg3,
            resource_name : 0x1::string::utf8(b"admin_cap_withdrawal"),
        };
        0x2::event::emit<VaultSpent>(v4);
        0x2::coin::take<T1>(v3, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

