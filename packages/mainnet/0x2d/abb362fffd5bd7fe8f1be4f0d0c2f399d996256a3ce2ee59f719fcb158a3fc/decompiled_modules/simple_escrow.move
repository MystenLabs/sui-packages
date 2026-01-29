module 0x2dabb362fffd5bd7fe8f1be4f0d0c2f399d996256a3ce2ee59f719fcb158a3fc::simple_escrow {
    struct EscrowConfig has key {
        id: 0x2::object::UID,
        executor: address,
        admin: address,
        total_created: u64,
        total_executed: u64,
        total_cancelled: u64,
    }

    struct SimpleEscrow has key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: address,
        expires_at: u64,
        auto_reopen: bool,
        reopen_range_percent: u64,
        remaining_repeats: u64,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: address,
        position_id: address,
        owner: address,
        pool_id: address,
        expires_at: u64,
        auto_reopen: bool,
    }

    struct EscrowExecuted has copy, drop {
        escrow_id: address,
        position_id: address,
        owner: address,
        executor: address,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: address,
        position_id: address,
        owner: address,
    }

    struct ConfigUpdated has copy, drop {
        old_executor: address,
        new_executor: address,
    }

    public fun cancel<T0: store + key>(arg0: &mut EscrowConfig, arg1: SimpleEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expires_at, 4);
        let SimpleEscrow {
            id                   : v0,
            owner                : v1,
            pool_id              : _,
            expires_at           : _,
            auto_reopen          : _,
            reopen_range_percent : _,
            remaining_repeats    : _,
        } = arg1;
        let v7 = v0;
        let v8 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v7, b"position");
        0x2::object::delete(v7);
        arg0.total_cancelled = arg0.total_cancelled + 1;
        let v9 = EscrowCancelled{
            escrow_id   : 0x2::object::uid_to_address(&v7),
            position_id : 0x2::object::id_address<T0>(&v8),
            owner       : v1,
        };
        0x2::event::emit<EscrowCancelled>(v9);
        v8
    }

    public entry fun cancel_and_return<T0: store + key>(arg0: &mut EscrowConfig, arg1: SimpleEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(cancel<T0>(arg0, arg1, arg2, arg3), arg1.owner);
    }

    public entry fun create_escrow<T0: store + key>(arg0: &mut EscrowConfig, arg1: T0, arg2: address, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg7), 5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = SimpleEscrow{
            id                   : 0x2::object::new(arg8),
            owner                : v0,
            pool_id              : arg2,
            expires_at           : arg3,
            auto_reopen          : arg4,
            reopen_range_percent : arg5,
            remaining_repeats    : arg6,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v1.id, b"position", arg1);
        0x2::transfer::share_object<SimpleEscrow>(v1);
        arg0.total_created = arg0.total_created + 1;
        let v2 = EscrowCreated{
            escrow_id   : 0x2::object::id_address<SimpleEscrow>(&v1),
            position_id : 0x2::object::id_address<T0>(&arg1),
            owner       : v0,
            pool_id     : arg2,
            expires_at  : arg3,
            auto_reopen : arg4,
        };
        0x2::event::emit<EscrowCreated>(v2);
    }

    public fun execute<T0: store + key>(arg0: &mut EscrowConfig, arg1: SimpleEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (T0, address) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_at, 3);
        let SimpleEscrow {
            id                   : v1,
            owner                : v2,
            pool_id              : _,
            expires_at           : _,
            auto_reopen          : _,
            reopen_range_percent : _,
            remaining_repeats    : _,
        } = arg1;
        let v8 = v1;
        let v9 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v8, b"position");
        0x2::object::delete(v8);
        arg0.total_executed = arg0.total_executed + 1;
        let v10 = EscrowExecuted{
            escrow_id   : 0x2::object::uid_to_address(&v8),
            position_id : 0x2::object::id_address<T0>(&v9),
            owner       : v2,
            executor    : v0,
        };
        0x2::event::emit<EscrowExecuted>(v10);
        (v9, v2)
    }

    public fun get_config_stats(arg0: &EscrowConfig) : (address, address, u64, u64, u64) {
        (arg0.executor, arg0.admin, arg0.total_created, arg0.total_executed, arg0.total_cancelled)
    }

    public fun get_escrow_info(arg0: &SimpleEscrow) : (address, address, u64, bool, u64, u64) {
        (arg0.owner, arg0.pool_id, arg0.expires_at, arg0.auto_reopen, arg0.reopen_range_percent, arg0.remaining_repeats)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = EscrowConfig{
            id              : 0x2::object::new(arg0),
            executor        : v0,
            admin           : v0,
            total_created   : 0,
            total_executed  : 0,
            total_cancelled : 0,
        };
        0x2::transfer::share_object<EscrowConfig>(v1);
    }

    public fun is_expired(arg0: &SimpleEscrow, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun owner(arg0: &SimpleEscrow) : address {
        arg0.owner
    }

    public fun pool_id(arg0: &SimpleEscrow) : address {
        arg0.pool_id
    }

    public entry fun set_executor(arg0: &mut EscrowConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.executor = arg1;
        let v0 = ConfigUpdated{
            old_executor : arg0.executor,
            new_executor : arg1,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun time_remaining(arg0: &SimpleEscrow, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.expires_at) {
            0
        } else {
            arg0.expires_at - v0
        }
    }

    public entry fun transfer_admin(arg0: &mut EscrowConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

