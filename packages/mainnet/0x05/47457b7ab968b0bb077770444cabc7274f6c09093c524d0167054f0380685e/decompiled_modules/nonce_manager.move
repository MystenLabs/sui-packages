module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::nonce_manager {
    struct NonceManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct NonceManagerState has store, key {
        id: 0x2::object::UID,
        outbound_nonces: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
    }

    public fun get_incremented_outbound_nonce(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &NonceManagerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"nonce_manager"), 0x1::string::utf8(b"get_incremented_outbound_nonce"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<NonceManagerState>(arg0);
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&v0.outbound_nonces, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut v0.outbound_nonces, arg2, 0x2::table::new<address, u64>(arg4));
        };
        let v1 = 0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut v0.outbound_nonces, arg2);
        if (!0x2::table::contains<address, u64>(v1, arg3)) {
            0x2::table::add<address, u64>(v1, arg3, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, arg3);
        let v3 = *v2 + 1;
        *v2 = v3;
        v3
    }

    public fun get_outbound_nonce(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: u64, arg2: address) : u64 {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"nonce_manager"), 0x1::string::utf8(b"get_outbound_nonce"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<NonceManagerState>(arg0);
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&v0.outbound_nonces, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&v0.outbound_nonces, arg1);
        if (!0x2::table::contains<address, u64>(v1, arg2)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(v1, arg2)
    }

    public fun initialize(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 2);
        assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::contains<NonceManagerState>(arg0), 1);
        let v0 = NonceManagerState{
            id              : 0x2::object::new(arg2),
            outbound_nonces : 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg2),
        };
        let v1 = NonceManagerCap{id: 0x2::object::new(arg2)};
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::add<NonceManagerState>(arg0, arg1, v0, arg2);
        0x2::transfer::transfer<NonceManagerCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"NonceManager 1.6.0")
    }

    // decompiled from Move bytecode v6
}

