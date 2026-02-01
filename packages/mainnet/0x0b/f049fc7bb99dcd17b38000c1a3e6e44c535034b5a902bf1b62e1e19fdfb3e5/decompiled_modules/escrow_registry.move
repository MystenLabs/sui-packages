module 0xbf049fc7bb99dcd17b38000c1a3e6e44c535034b5a902bf1b62e1e19fdfb3e5::escrow_registry {
    struct EscrowRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_escrows: u64,
        total_closed: u64,
    }

    struct PositionEscrow has key {
        id: 0x2::object::UID,
        original_owner: address,
        pool_id: address,
        expires_at: u64,
        executed: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionDeposited has copy, drop {
        escrow_id: address,
        position_id: address,
        original_owner: address,
        pool_id: address,
        expires_at: u64,
    }

    struct PositionWithdrawn has copy, drop {
        escrow_id: address,
        position_id: address,
        original_owner: address,
        executor: address,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: address,
        position_id: address,
        original_owner: address,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun cancel_escrow<T0: store + key>(arg0: &mut EscrowRegistry, arg1: PositionEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg3) == arg1.original_owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expires_at, 4);
        let PositionEscrow {
            id             : v0,
            original_owner : v1,
            pool_id        : _,
            expires_at     : _,
            executed       : _,
        } = arg1;
        let v5 = v0;
        let v6 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v5, b"position");
        0x2::object::delete(v5);
        arg0.total_escrows = arg0.total_escrows - 1;
        let v7 = EscrowCancelled{
            escrow_id      : 0x2::object::uid_to_address(&v5),
            position_id    : 0x2::object::id_address<T0>(&v6),
            original_owner : v1,
        };
        0x2::event::emit<EscrowCancelled>(v7);
        v6
    }

    public entry fun cancel_escrow_and_return<T0: store + key>(arg0: &mut EscrowRegistry, arg1: PositionEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_escrow<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut EscrowRegistry, arg2: address) {
        arg1.admin = arg2;
        let v0 = AdminChanged{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun deposit_position<T0: store + key>(arg0: &mut EscrowRegistry, arg1: T0, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 6);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = PositionEscrow{
            id             : 0x2::object::new(arg5),
            original_owner : v0,
            pool_id        : arg2,
            expires_at     : arg3,
            executed       : false,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v1.id, b"position", arg1);
        0x2::transfer::share_object<PositionEscrow>(v1);
        arg0.total_escrows = arg0.total_escrows + 1;
        let v2 = PositionDeposited{
            escrow_id      : 0x2::object::id_address<PositionEscrow>(&v1),
            position_id    : 0x2::object::id_address<T0>(&arg1),
            original_owner : v0,
            pool_id        : arg2,
            expires_at     : arg3,
        };
        0x2::event::emit<PositionDeposited>(v2);
    }

    public fun get_escrow_info(arg0: &PositionEscrow) : (address, address, u64, bool) {
        (arg0.original_owner, arg0.pool_id, arg0.expires_at, arg0.executed)
    }

    public fun get_registry_stats(arg0: &EscrowRegistry) : (address, u64, u64) {
        (arg0.admin, arg0.total_escrows, arg0.total_closed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = EscrowRegistry{
            id            : 0x2::object::new(arg0),
            admin         : v0,
            total_escrows : 0,
            total_closed  : 0,
        };
        0x2::transfer::share_object<EscrowRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_expired(arg0: &PositionEscrow, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun time_remaining(arg0: &PositionEscrow, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.expires_at) {
            0
        } else {
            arg0.expires_at - v0
        }
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw_for_close<T0: store + key>(arg0: &AdminCap, arg1: &mut EscrowRegistry, arg2: PositionEscrow, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, address) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.expires_at, 3);
        let PositionEscrow {
            id             : v0,
            original_owner : v1,
            pool_id        : _,
            expires_at     : _,
            executed       : _,
        } = arg2;
        let v5 = v0;
        let v6 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v5, b"position");
        0x2::object::delete(v5);
        arg1.total_escrows = arg1.total_escrows - 1;
        arg1.total_closed = arg1.total_closed + 1;
        let v7 = PositionWithdrawn{
            escrow_id      : 0x2::object::uid_to_address(&v5),
            position_id    : 0x2::object::id_address<T0>(&v6),
            original_owner : v1,
            executor       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PositionWithdrawn>(v7);
        (v6, v1)
    }

    // decompiled from Move bytecode v6
}

