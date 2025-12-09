module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::receiver_registry {
    struct ReceiverConfig has copy, drop, store {
        module_name: 0x1::string::String,
        proof_typename: 0x1::ascii::String,
    }

    struct ReceiverRegistry has store, key {
        id: 0x2::object::UID,
        receiver_configs: 0x2::linked_table::LinkedTable<address, ReceiverConfig>,
    }

    struct ReceiverRegistered has copy, drop {
        receiver_package_id: address,
        receiver_module_name: 0x1::string::String,
        proof_typename: 0x1::ascii::String,
    }

    struct ReceiverUnregistered has copy, drop {
        receiver_package_id: address,
    }

    public fun get_receiver_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : ReceiverConfig {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"receiver_registry"), 0x1::string::utf8(b"get_receiver_config"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<ReceiverRegistry>(arg0);
        assert!(0x2::linked_table::contains<address, ReceiverConfig>(&v0.receiver_configs, arg1), 3);
        *0x2::linked_table::borrow<address, ReceiverConfig>(&v0.receiver_configs, arg1)
    }

    public fun get_receiver_config_fields(arg0: ReceiverConfig) : (0x1::string::String, 0x1::ascii::String) {
        (arg0.module_name, arg0.proof_typename)
    }

    public fun get_receiver_info(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : (0x1::string::String, 0x1::ascii::String) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"receiver_registry"), 0x1::string::utf8(b"get_receiver_info"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<ReceiverRegistry>(arg0);
        if (0x2::linked_table::contains<address, ReceiverConfig>(&v0.receiver_configs, arg1)) {
            let v1 = 0x2::linked_table::borrow<address, ReceiverConfig>(&v0.receiver_configs, arg1);
            return (v1.module_name, v1.proof_typename)
        };
        (0x1::string::utf8(b""), 0x1::ascii::string(b""))
    }

    public fun initialize(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 4);
        assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::contains<ReceiverRegistry>(arg0), 2);
        let v0 = ReceiverRegistry{
            id               : 0x2::object::new(arg2),
            receiver_configs : 0x2::linked_table::new<address, ReceiverConfig>(arg2),
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::add<ReceiverRegistry>(arg0, arg1, v0, arg2);
    }

    public fun is_registered_receiver(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: address) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"receiver_registry"), 0x1::string::utf8(b"is_registered_receiver"), 1);
        0x2::linked_table::contains<address, ReceiverConfig>(&0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<ReceiverRegistry>(arg0).receiver_configs, arg1)
    }

    public fun register_receiver<T0: drop>(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::PublisherWrapper<T0>, arg2: T0) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"receiver_registry"), 0x1::string::utf8(b"register_receiver"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<ReceiverRegistry>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::string::from_ascii(0x1::type_name::module_string(&v1));
        let v3 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper::get_package_address<T0>(arg1);
        assert!(!0x2::linked_table::contains<address, ReceiverConfig>(&v0.receiver_configs, v3), 1);
        let v4 = ReceiverConfig{
            module_name    : v2,
            proof_typename : 0x1::type_name::into_string(v1),
        };
        0x2::linked_table::push_back<address, ReceiverConfig>(&mut v0.receiver_configs, v3, v4);
        let v5 = ReceiverRegistered{
            receiver_package_id  : v3,
            receiver_module_name : v2,
            proof_typename       : 0x1::type_name::into_string(v1),
        };
        0x2::event::emit<ReceiverRegistered>(v5);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"ReceiverRegistry 1.6.0")
    }

    public fun unregister_receiver(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"receiver_registry"), 0x1::string::utf8(b"unregister_receiver"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 4);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<ReceiverRegistry>(arg0);
        assert!(0x2::linked_table::contains<address, ReceiverConfig>(&v0.receiver_configs, arg2), 3);
        0x2::linked_table::remove<address, ReceiverConfig>(&mut v0.receiver_configs, arg2);
        let v1 = ReceiverUnregistered{receiver_package_id: arg2};
        0x2::event::emit<ReceiverUnregistered>(v1);
    }

    // decompiled from Move bytecode v6
}

