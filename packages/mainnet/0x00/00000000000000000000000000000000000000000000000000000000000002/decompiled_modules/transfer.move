module 0x2::transfer {
    struct Receiving<phantom T0: key> has drop {
        id: 0x2::object::ID,
        version: u64,
    }

    public fun transfer<T0: key>(arg0: T0, arg1: address) {
        transfer_impl<T0>(arg0, arg1);
    }

    public fun freeze_object<T0: key>(arg0: T0) {
        freeze_object_impl<T0>(arg0);
    }

    native public(friend) fun freeze_object_impl<T0: key>(arg0: T0);
    public fun party_transfer<T0: key>(arg0: T0, arg1: 0x2::party::Party) {
        assert!(0x2::party::is_single_owner(&arg1), 13836747248740204551);
        let (v0, v1, v2) = 0x2::party::into_native(arg1);
        party_transfer_impl<T0>(arg0, v0, v1, v2);
    }

    native public(friend) fun party_transfer_impl<T0: key>(arg0: T0, arg1: u64, arg2: vector<address>, arg3: vector<u64>);
    public fun public_freeze_object<T0: store + key>(arg0: T0) {
        freeze_object_impl<T0>(arg0);
    }

    public fun public_party_transfer<T0: store + key>(arg0: T0, arg1: 0x2::party::Party) {
        assert!(0x2::party::is_single_owner(&arg1), 13836747317459681287);
        let (v0, v1, v2) = 0x2::party::into_native(arg1);
        party_transfer_impl<T0>(arg0, v0, v1, v2);
    }

    public fun public_receive<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: Receiving<T0>) : T0 {
        let Receiving {
            id      : v0,
            version : v1,
        } = arg1;
        receive_impl<T0>(0x2::object::uid_to_address(arg0), v0, v1)
    }

    public fun public_share_object<T0: store + key>(arg0: T0) {
        share_object_impl<T0>(arg0);
    }

    public fun public_transfer<T0: store + key>(arg0: T0, arg1: address) {
        transfer_impl<T0>(arg0, arg1);
    }

    public fun receive<T0: key>(arg0: &mut 0x2::object::UID, arg1: Receiving<T0>) : T0 {
        let Receiving {
            id      : v0,
            version : v1,
        } = arg1;
        receive_impl<T0>(0x2::object::uid_to_address(arg0), v0, v1)
    }

    native fun receive_impl<T0: key>(arg0: address, arg1: 0x2::object::ID, arg2: u64) : T0;
    public fun receiving_object_id<T0: key>(arg0: &Receiving<T0>) : 0x2::object::ID {
        arg0.id
    }

    public fun share_object<T0: key>(arg0: T0) {
        share_object_impl<T0>(arg0);
    }

    native public(friend) fun share_object_impl<T0: key>(arg0: T0);
    native public(friend) fun transfer_impl<T0: key>(arg0: T0, arg1: address);
    // decompiled from Move bytecode v6
}

