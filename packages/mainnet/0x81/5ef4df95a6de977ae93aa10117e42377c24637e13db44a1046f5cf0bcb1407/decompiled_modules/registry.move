module 0x815ef4df95a6de977ae93aa10117e42377c24637e13db44a1046f5cf0bcb1407::registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
        reversed_registry: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct RecordAddedEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        name: 0x1::string::String,
        sender: address,
    }

    struct RecordUpdatedEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        sender: address,
    }

    struct RecordRemovedEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        name: 0x1::string::String,
        sender: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id                : 0x2::object::new(arg0),
            registry          : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg0),
            reversed_registry : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        }
    }

    public(friend) fun add_record(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.registry, arg2), 1);
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg0.registry, arg2, arg1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.reversed_registry, arg1, arg2);
        let v0 = RecordAddedEvent{
            obligation_id : arg2,
            name          : arg1,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RecordAddedEvent>(v0);
    }

    public(friend) fun destroy(arg0: Registry) {
        let Registry {
            id                : v0,
            registry          : v1,
            reversed_registry : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::drop<0x2::object::ID, 0x1::string::String>(v1);
        0x2::table::drop<0x1::string::String, 0x2::object::ID>(v2);
    }

    public fun has_id(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.registry, arg1)
    }

    public fun has_name(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.reversed_registry, arg1)
    }

    public fun lookup_by_id(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x1::string::String> {
        if (has_id(arg0, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x2::object::ID, 0x1::string::String>(&arg0.registry, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun lookup_by_name(arg0: &Registry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (has_name(arg0, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.reversed_registry, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun remove_record(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.registry, arg1), 2);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x1::string::String>(&mut arg0.registry, arg1);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.reversed_registry, v0);
        let v1 = RecordRemovedEvent{
            obligation_id : arg1,
            name          : v0,
            sender        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RecordRemovedEvent>(v1);
    }

    public(friend) fun update_record(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x1::string::String>(&mut arg0.registry, arg2);
        let v1 = *v0;
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.reversed_registry, v1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.reversed_registry, arg1, arg2);
        *v0 = arg1;
        let v2 = RecordUpdatedEvent{
            obligation_id : arg2,
            old_name      : v1,
            new_name      : arg1,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RecordUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

