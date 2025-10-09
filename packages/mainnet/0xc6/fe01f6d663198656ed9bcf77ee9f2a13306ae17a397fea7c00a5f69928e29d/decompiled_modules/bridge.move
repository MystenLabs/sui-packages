module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge {
    struct QuorumChanged has copy, drop {
        new_quorum: u64,
    }

    struct BatchExecuted has copy, drop {
        batch_nonce_mvx: u64,
        transfers_count: u64,
        successful_transfers: u64,
    }

    struct BridgeMigrationStarted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct BridgeMigrationAborted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct BridgeMigrationCompleted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        pause: 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::Pause,
        quorum: u64,
        batch_settle_timeout_ms: u64,
        relayers: 0x2::vec_set::VecSet<address>,
        relayer_public_keys: 0x2::table::Table<address, vector<u8>>,
        executed_batches: 0x2::vec_set::VecSet<u64>,
        execution_timestamps: 0x2::table::Table<u64, u64>,
        cross_transfer_statuses: 0x2::table::Table<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::CrossTransferStatus>,
        transfer_statuses: vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>,
        safe: address,
        bridge_cap: 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeCap,
        executed_transfer_by_batch_type_arg: 0x2::vec_set::VecSet<vector<u8>>,
        successful_transfers_by_batch: 0x2::table::Table<u64, u64>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun abort_bridge_migration(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: &0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg2);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 18);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1));
        assert!(v0 == 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 19);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v0);
        let v1 = BridgeMigrationAborted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<BridgeMigrationAborted>(v1);
    }

    public fun add_relayer(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        let v0 = getAddressFromPublicKey(&arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.relayers, &v0), 15);
        0x2::vec_set::insert<address>(&mut arg0.relayers, v0);
        0x2::table::add<address, vector<u8>>(&mut arg0.relayer_public_keys, v0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_relayer_added(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun assert_bridge_is_compatible(arg0: &Bridge) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    fun assert_relayer(arg0: &Bridge, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.relayers, &arg1), 5);
    }

    public fun bridge_compatible_versions(arg0: &Bridge) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.compatible_versions)
    }

    public fun bridge_current_active_version(arg0: &Bridge) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
        if (0x1::vector::length<u64>(v0) == 1) {
            *0x1::vector::borrow<u64>(v0, 0)
        } else {
            0x1::u64::min(*0x1::vector::borrow<u64>(v0, 0), *0x1::vector::borrow<u64>(v0, 1))
        }
    }

    public fun bridge_pending_version(arg0: &Bridge) : 0x1::option::Option<u64> {
        if (0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2) {
            let v1 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
            0x1::option::some<u64>(0x1::u64::max(*0x1::vector::borrow<u64>(v1, 0), *0x1::vector::borrow<u64>(v1, 1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun complete_bridge_migration(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: &0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg2);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 18);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1);
        let v2 = 0x1::u64::min(v0, v1);
        assert!(0x1::u64::max(v0, v1) == 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 19);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v2);
        let v3 = BridgeMigrationCompleted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<BridgeMigrationCompleted>(v3);
    }

    public fun compute_message(arg0: u64, arg1: &vector<u8>, arg2: &vector<address>, arg3: &vector<u64>, arg4: &vector<u64>) : vector<u8> {
        let v0 = construct_batch_message(arg0, arg1, arg2, arg3, arg4);
        let v1 = x"030000";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&v0));
        0x2::hash::blake2b256(&v1)
    }

    fun construct_batch_message(arg0: u64, arg1: &vector<u8>, arg2: &vector<address>, arg3: &vector<u64>, arg4: &vector<u64>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(0x1::vector::borrow<address>(arg2, v1)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg3, v1)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg4, v1)));
            v1 = v1 + 1;
        };
        0x2::hash::blake2b256(&v0)
    }

    fun derive_key<T0>(arg0: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>());
        0x2::hash::blake2b256(&v0)
    }

    public fun execute_transfer<T0>(arg0: &mut Bridge, arg1: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: vector<vector<u8>>, arg7: bool, arg8: &mut 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_relayer(arg0, 0x2::tx_context::sender(arg10));
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::assert_not_paused(&arg0.pause);
        assert!(!was_batch_executed(arg0, arg5), 3);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 2);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 16);
        validate_quorum<T0>(arg0, arg5, &arg2, &arg3, &arg6, &arg4);
        mark_deposits_executed_in_batch_or_abort<T0>(arg0, arg5);
        if (0x2::table::contains<u64, u64>(&arg0.execution_timestamps, arg5)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.execution_timestamps, arg5) = 0x2::clock::timestamp_ms(arg9);
        } else {
            0x2::table::add<u64, u64>(&mut arg0.execution_timestamps, arg5, 0x2::clock::timestamp_ms(arg9));
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            if (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::transfer<T0>(arg1, &arg0.bridge_cap, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg8, arg10)) {
                0x1::vector::push_back<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>(&mut arg0.transfer_statuses, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::deposit_status_executed());
                if (0x2::table::contains<u64, u64>(&arg0.successful_transfers_by_batch, arg5)) {
                    let v2 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.successful_transfers_by_batch, arg5);
                    *v2 = *v2 + 1;
                } else {
                    0x2::table::add<u64, u64>(&mut arg0.successful_transfers_by_batch, arg5, 1);
                };
            } else {
                0x1::vector::push_back<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>(&mut arg0.transfer_statuses, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::deposit_status_rejected());
            };
            v1 = v1 + 1;
        };
        if (arg7) {
            0x2::vec_set::insert<u64>(&mut arg0.executed_batches, arg5);
            0x2::table::add<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::CrossTransferStatus>(&mut arg0.cross_transfer_statuses, arg5, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::create_cross_transfer_status(arg0.transfer_statuses, 0x2::clock::timestamp_ms(arg9)));
            arg0.transfer_statuses = 0x1::vector::empty<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>();
            let v3 = if (0x2::table::contains<u64, u64>(&arg0.successful_transfers_by_batch, arg5)) {
                *0x2::table::borrow<u64, u64>(&arg0.successful_transfers_by_batch, arg5)
            } else {
                0
            };
            if (0x2::table::contains<u64, u64>(&arg0.successful_transfers_by_batch, arg5)) {
                0x2::table::remove<u64, u64>(&mut arg0.successful_transfers_by_batch, arg5);
            };
            let v4 = BatchExecuted{
                batch_nonce_mvx      : arg5,
                transfers_count      : 0x1::vector::length<address>(&arg2),
                successful_transfers : v3,
            };
            0x2::event::emit<BatchExecuted>(v4);
        };
    }

    fun extract_public_key(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(arg0) - 32;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun extract_signature(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0) - 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun find_relayer_by_public_key(arg0: &Bridge, arg1: &vector<u8>) : 0x1::option::Option<address> {
        let v0 = 0x2::vec_set::keys<address>(&arg0.relayers);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            let v2 = *0x1::vector::borrow<address>(v0, v1);
            if (0x2::table::contains<address, vector<u8>>(&arg0.relayer_public_keys, v2)) {
                if (0x2::table::borrow<address, vector<u8>>(&arg0.relayer_public_keys, v2) == arg1) {
                    return 0x1::option::some<address>(v2)
                };
            };
            v1 = v1 + 1;
        };
        0x1::option::none<address>()
    }

    fun getAddressFromPublicKey(arg0: &vector<u8>) : address {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun get_admin(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe) : address {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::get_owner(arg0)
    }

    public fun get_batch(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch, bool) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::get_batch(arg0, arg1, arg2)
    }

    public fun get_batch_deposits(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>, bool) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::get_deposits(arg0, arg1, arg2)
    }

    public fun get_batch_settle_timeout_ms(arg0: &Bridge) : u64 {
        arg0.batch_settle_timeout_ms
    }

    public fun get_pause(arg0: &Bridge) : bool {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::is_paused(&arg0.pause)
    }

    public fun get_quorum(arg0: &Bridge) : u64 {
        arg0.quorum
    }

    public fun get_relayer_count(arg0: &Bridge) : u64 {
        0x2::vec_set::length<address>(&arg0.relayers)
    }

    public fun get_relayers(arg0: &Bridge) : &vector<address> {
        0x2::vec_set::keys<address>(&arg0.relayers)
    }

    public fun get_statuses_after_execution(arg0: &Bridge, arg1: u64, arg2: &0x2::clock::Clock) : (vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>, bool) {
        if (0x2::table::contains<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::CrossTransferStatus>(&arg0.cross_transfer_statuses, arg1)) {
            let v2 = 0x2::table::borrow<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::CrossTransferStatus>(&arg0.cross_transfer_statuses, arg1);
            (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::cross_transfer_status_statuses(v2), is_mvx_batch_final(arg0, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::cross_transfer_status_created_timestamp_ms(v2), arg2))
        } else {
            (0x1::vector::empty<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>(), false)
        }
    }

    public fun initialize(arg0: vector<vector<u8>>, arg1: u64, arg2: address, arg3: 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 3, 0);
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0x2::table::new<address, vector<u8>>(arg4);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0, v2);
            assert!(0x1::vector::length<u8>(&v3) == 32, 1);
            let v4 = getAddressFromPublicKey(&v3);
            0x2::vec_set::insert<address>(&mut v0, v4);
            0x2::table::add<address, vector<u8>>(&mut v1, v4, v3);
            v2 = v2 + 1;
        };
        let v5 = Bridge{
            id                                  : 0x2::object::new(arg4),
            pause                               : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::new(),
            quorum                              : arg1,
            batch_settle_timeout_ms             : 10000,
            relayers                            : v0,
            relayer_public_keys                 : v1,
            executed_batches                    : 0x2::vec_set::empty<u64>(),
            execution_timestamps                : 0x2::table::new<u64, u64>(arg4),
            cross_transfer_statuses             : 0x2::table::new<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::CrossTransferStatus>(arg4),
            transfer_statuses                   : 0x1::vector::empty<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::DepositStatus>(),
            safe                                : arg2,
            bridge_cap                          : arg3,
            executed_transfer_by_batch_type_arg : 0x2::vec_set::empty<vector<u8>>(),
            successful_transfers_by_batch       : 0x2::table::new<u64, u64>(arg4),
            compatible_versions                 : 0x2::vec_set::singleton<u64>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version()),
        };
        0x2::transfer::share_object<Bridge>(v5);
    }

    public fun is_bridge_migration_in_progress(arg0: &Bridge) : bool {
        0x2::vec_set::length<u64>(&arg0.compatible_versions) > 1
    }

    fun is_mvx_batch_final(arg0: &Bridge, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg1 == 0 && false || arg1 + arg0.batch_settle_timeout_ms <= 0x2::clock::timestamp_ms(arg2)
    }

    public fun is_relayer(arg0: &Bridge, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.relayers, &arg1)
    }

    fun mark_deposits_executed_in_batch_or_abort<T0>(arg0: &mut Bridge, arg1: u64) {
        let v0 = derive_key<T0>(arg1);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.executed_transfer_by_batch_type_arg, &v0), 6);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.executed_transfer_by_batch_type_arg, v0);
    }

    public fun pause_contract(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::pause(&mut arg0.pause);
    }

    public fun remove_relayer(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg3);
        assert!(0x2::vec_set::length<address>(&arg0.relayers) > arg0.quorum, 13);
        0x2::vec_set::remove<address>(&mut arg0.relayers, &arg2);
        if (0x2::table::contains<address, vector<u8>>(&arg0.relayer_public_keys, arg2)) {
            0x2::table::remove<address, vector<u8>>(&mut arg0.relayer_public_keys, arg2);
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_relayer_removed(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun set_batch_settle_timeout_ms(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg4);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::assert_paused(&arg0.pause);
        assert!(arg2 >= 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::get_batch_timeout_ms(arg1), 4);
        assert!(!0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::is_any_batch_in_progress(arg1, arg3), 7);
        arg0.batch_settle_timeout_ms = arg2;
    }

    public fun set_quorum(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg3);
        assert!(arg2 >= 3, 0);
        assert!(arg2 <= 0x2::vec_set::length<address>(&arg0.relayers), 12);
        arg0.quorum = arg2;
        let v0 = QuorumChanged{new_quorum: arg2};
        0x2::event::emit<QuorumChanged>(v0);
    }

    public fun start_bridge_migration(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: &0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg2);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 1, 17);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0) < 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 20);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version());
        let v0 = BridgeMigrationStarted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<BridgeMigrationStarted>(v0);
    }

    public fun unpause_contract(arg0: &mut Bridge, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg1, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::unpause(&mut arg0.pause);
    }

    fun validate_quorum<T0>(arg0: &Bridge, arg1: u64, arg2: &vector<address>, arg3: &vector<u64>, arg4: &vector<vector<u8>>, arg5: &vector<u64>) {
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        let v1 = 0x1::vector::length<vector<u8>>(arg4);
        assert!(v1 >= arg0.quorum, 11);
        let v2 = compute_message(arg1, &v0, arg2, arg3, arg5);
        let v3 = 0x2::vec_set::empty<address>();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<vector<u8>>(arg4, v4);
            assert!(0x1::vector::length<u8>(v5) == 96, 10);
            let v6 = extract_public_key(v5);
            let v7 = extract_signature(v5);
            let v8 = find_relayer_by_public_key(arg0, &v6);
            assert!(0x1::option::is_some<address>(&v8), 14);
            let v9 = 0x1::option::extract<address>(&mut v8);
            assert!(!0x2::vec_set::contains<address>(&v3, &v9), 9);
            assert!(0x2::ed25519::ed25519_verify(&v7, &v6, &v2), 8);
            0x2::vec_set::insert<address>(&mut v3, v9);
            v4 = v4 + 1;
        };
        assert!(0x2::vec_set::length<address>(&v3) >= arg0.quorum, 11);
    }

    public fun was_batch_executed(arg0: &Bridge, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.executed_batches, &arg1)
    }

    // decompiled from Move bytecode v6
}

