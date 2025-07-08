module 0x2::object {
    struct ID has copy, drop, store {
        bytes: address,
    }

    struct UID has store {
        id: ID,
    }

    public(friend) fun authenticator_state() : UID {
        let v0 = ID{bytes: @0x7};
        UID{id: v0}
    }

    public fun borrow_id<T0: key>(arg0: &T0) : &ID {
        &borrow_uid<T0>(arg0).id
    }

    native fun borrow_uid<T0: key>(arg0: &T0) : &UID;
    fun bridge() : UID {
        let v0 = ID{bytes: @0x9};
        UID{id: v0}
    }

    public(friend) fun clock() : UID {
        let v0 = ID{bytes: @0x6};
        UID{id: v0}
    }

    public fun delete(arg0: UID) {
        let UID { id: v0 } = arg0;
        let ID { bytes: v1 } = v0;
        delete_impl(v1);
    }

    native fun delete_impl(arg0: address);
    public fun id<T0: key>(arg0: &T0) : ID {
        borrow_uid<T0>(arg0).id
    }

    public fun id_address<T0: key>(arg0: &T0) : address {
        borrow_uid<T0>(arg0).id.bytes
    }

    public fun id_bytes<T0: key>(arg0: &T0) : vector<u8> {
        0x1::bcs::to_bytes<ID>(&borrow_uid<T0>(arg0).id)
    }

    public fun id_from_address(arg0: address) : ID {
        ID{bytes: arg0}
    }

    public fun id_from_bytes(arg0: vector<u8>) : ID {
        id_from_address(0x2::address::from_bytes(arg0))
    }

    public fun id_to_address(arg0: &ID) : address {
        arg0.bytes
    }

    public fun id_to_bytes(arg0: &ID) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0.bytes)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : UID {
        let v0 = ID{bytes: 0x2::tx_context::fresh_object_address(arg0)};
        UID{id: v0}
    }

    public(friend) fun new_uid_from_hash(arg0: address) : UID {
        record_new_uid(arg0);
        let v0 = ID{bytes: arg0};
        UID{id: v0}
    }

    public(friend) fun randomness_state() : UID {
        let v0 = ID{bytes: @0x8};
        UID{id: v0}
    }

    native fun record_new_uid(arg0: address);
    public(friend) fun sui_deny_list_object_id() : UID {
        let v0 = ID{bytes: @0x403};
        UID{id: v0}
    }

    fun sui_system_state(arg0: &0x2::tx_context::TxContext) : UID {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = ID{bytes: @0x5};
        UID{id: v0}
    }

    public fun uid_as_inner(arg0: &UID) : &ID {
        &arg0.id
    }

    public fun uid_to_address(arg0: &UID) : address {
        arg0.id.bytes
    }

    public fun uid_to_bytes(arg0: &UID) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0.id.bytes)
    }

    public fun uid_to_inner(arg0: &UID) : ID {
        arg0.id
    }

    // decompiled from Move bytecode v6
}

