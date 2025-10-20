module 0x3fa9e98b800828ece991fa7c773e5d4e60fae8af9c81dd79606f9416111e3f1e::address_lock {
    struct AddressLock has key {
        id: 0x2::object::UID,
        locked_address: address,
        owner: address,
        allowed_outbound: vector<address>,
        allowed_inbound: vector<address>,
        blocked_addresses: vector<address>,
        emergency_lock: bool,
        created_at: u64,
        last_modified: u64,
        transfer_count: u64,
    }

    struct LockRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        locked_addresses: vector<address>,
        total_locked: u64,
    }

    struct AddressLocked has copy, drop {
        victim_address: address,
        owner: address,
        timestamp: u64,
    }

    struct TransferAttempt has copy, drop {
        from: address,
        to: address,
        allowed: bool,
        reason: u8,
        timestamp: u64,
    }

    struct LockUpdated has copy, drop {
        lock_address: address,
        updated_by: address,
        operation: u8,
        timestamp: u64,
    }

    public fun add_allowed_inbound(arg0: &mut AddressLock, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.allowed_inbound, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.allowed_inbound, v1);
            };
            v0 = v0 + 1;
        };
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = LockUpdated{
            lock_address : arg0.locked_address,
            updated_by   : arg0.owner,
            operation    : 2,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<LockUpdated>(v2);
    }

    public fun add_allowed_outbound(arg0: &mut AddressLock, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.allowed_outbound, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.allowed_outbound, v1);
            };
            v0 = v0 + 1;
        };
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = LockUpdated{
            lock_address : arg0.locked_address,
            updated_by   : arg0.owner,
            operation    : 1,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<LockUpdated>(v2);
    }

    public fun block_addresses(arg0: &mut AddressLock, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.blocked_addresses, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.blocked_addresses, v1);
            };
            v0 = v0 + 1;
        };
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = LockUpdated{
            lock_address : arg0.locked_address,
            updated_by   : arg0.owner,
            operation    : 3,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<LockUpdated>(v2);
    }

    public fun block_all_except_whitelist(arg0: &mut AddressLock, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.allowed_outbound, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.allowed_outbound, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = vector[@0x5c79fa907c321fff2f4dc9847b4cc06ed3c8ba784abccdca6b90d383032ddbd8];
        v0 = 0;
        while (v0 < 0x1::vector::length<address>(&v2)) {
            let v3 = *0x1::vector::borrow<address>(&v2, v0);
            if (!0x1::vector::contains<address>(&arg0.blocked_addresses, &v3)) {
                0x1::vector::push_back<address>(&mut arg0.blocked_addresses, v3);
            };
            v0 = v0 + 1;
        };
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v4 = LockUpdated{
            lock_address : arg0.locked_address,
            updated_by   : arg0.owner,
            operation    : 5,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<LockUpdated>(v4);
    }

    fun check_inbound_allowed(arg0: &AddressLock, arg1: address, arg2: address) : bool {
        if (arg0.emergency_lock) {
            return false
        };
        if (arg0.locked_address != arg2) {
            return false
        };
        if (0x1::vector::contains<address>(&arg0.blocked_addresses, &arg1)) {
            return false
        };
        0x1::vector::contains<address>(&arg0.allowed_inbound, &arg1)
    }

    fun check_outbound_allowed(arg0: &AddressLock, arg1: address, arg2: address) : bool {
        if (arg0.emergency_lock) {
            return false
        };
        if (arg0.locked_address != arg1) {
            return false
        };
        if (0x1::vector::contains<address>(&arg0.blocked_addresses, &arg2)) {
            return false
        };
        0x1::vector::contains<address>(&arg0.allowed_outbound, &arg2)
    }

    fun get_error_code(arg0: &AddressLock, arg1: address, arg2: address) : u8 {
        if (arg0.emergency_lock) {
            return 1
        };
        if (0x1::vector::contains<address>(&arg0.blocked_addresses, &arg2)) {
            return 2
        };
        if (0x1::vector::contains<address>(&arg0.blocked_addresses, &arg1)) {
            return 3
        };
        if (!0x1::vector::contains<address>(&arg0.allowed_outbound, &arg2)) {
            return 4
        };
        if (!0x1::vector::contains<address>(&arg0.allowed_inbound, &arg1)) {
            return 5
        };
        6
    }

    public fun get_lock_info(arg0: &AddressLock) : (address, address, bool, u64) {
        (arg0.locked_address, arg0.owner, arg0.emergency_lock, arg0.transfer_count)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockRegistry{
            id               : 0x2::object::new(arg0),
            owner            : 0x2::tx_context::sender(arg0),
            locked_addresses : 0x1::vector::empty<address>(),
            total_locked     : 0,
        };
        0x2::transfer::share_object<LockRegistry>(v0);
    }

    public fun is_address_locked(arg0: &LockRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.locked_addresses, &arg1)
    }

    public fun is_inbound_allowed(arg0: &AddressLock, arg1: address, arg2: address) : bool {
        check_inbound_allowed(arg0, arg1, arg2)
    }

    public fun is_outbound_allowed(arg0: &AddressLock, arg1: address, arg2: address) : bool {
        check_outbound_allowed(arg0, arg1, arg2)
    }

    public fun lock_address(arg0: &mut LockRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        assert!(!0x1::vector::contains<address>(&arg0.locked_addresses, &arg1), 1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, v0);
        0x1::vector::push_back<address>(v2, @0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let v4 = AddressLock{
            id                : 0x2::object::new(arg2),
            locked_address    : arg1,
            owner             : v0,
            allowed_outbound  : v1,
            allowed_inbound   : v3,
            blocked_addresses : 0x1::vector::empty<address>(),
            emergency_lock    : false,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg2),
            last_modified     : 0x2::tx_context::epoch_timestamp_ms(arg2),
            transfer_count    : 0,
        };
        0x1::vector::push_back<address>(&mut arg0.locked_addresses, arg1);
        arg0.total_locked = arg0.total_locked + 1;
        0x2::transfer::share_object<AddressLock>(v4);
        let v5 = AddressLocked{
            victim_address : arg1,
            owner          : v0,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AddressLocked>(v5);
    }

    public fun toggle_emergency_lock(arg0: &mut AddressLock, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.emergency_lock = !arg0.emergency_lock;
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v0 = LockUpdated{
            lock_address : arg0.locked_address,
            updated_by   : arg0.owner,
            operation    : 4,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<LockUpdated>(v0);
    }

    public fun validate_inbound_transfer(arg0: &AddressLock, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = check_inbound_allowed(arg0, arg1, arg2);
        let v1 = if (v0) {
            0
        } else {
            get_error_code(arg0, arg1, arg2)
        };
        let v2 = TransferAttempt{
            from      : arg1,
            to        : arg2,
            allowed   : v0,
            reason    : v1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TransferAttempt>(v2);
        v0
    }

    public fun validate_outbound_transfer(arg0: &AddressLock, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = check_outbound_allowed(arg0, arg1, arg2);
        let v1 = if (v0) {
            0
        } else {
            get_error_code(arg0, arg1, arg2)
        };
        let v2 = TransferAttempt{
            from      : arg1,
            to        : arg2,
            allowed   : v0,
            reason    : v1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TransferAttempt>(v2);
        v0
    }

    // decompiled from Move bytecode v6
}

