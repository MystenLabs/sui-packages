module 0x4603c1f0d68c7896f7d0b758cce219f92d9d360501dbefc208c96a95fdb63a31::object_manager_demo {
    struct ObjectManager has store, key {
        id: 0x2::object::UID,
        managed_objects: vector<address>,
        owner: address,
    }

    struct DemoObject has store, key {
        id: 0x2::object::UID,
        value: u64,
        creator: address,
    }

    struct ManagerCreated has copy, drop {
        manager_id: address,
        owner: address,
    }

    struct ObjectReceived has copy, drop {
        manager_id: address,
        object_id: address,
        from: address,
    }

    struct ObjectReturned has copy, drop {
        manager_id: address,
        object_id: address,
        to: address,
    }

    public fun create_demo_object(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : DemoObject {
        DemoObject{
            id      : 0x2::object::new(arg1),
            value   : arg0,
            creator : 0x2::tx_context::sender(arg1),
        }
    }

    public fun create_object_manager(arg0: &mut 0x2::tx_context::TxContext) : ObjectManager {
        let v0 = ObjectManager{
            id              : 0x2::object::new(arg0),
            managed_objects : 0x1::vector::empty<address>(),
            owner           : 0x2::tx_context::sender(arg0),
        };
        let v1 = ManagerCreated{
            manager_id : 0x2::object::uid_to_address(&v0.id),
            owner      : v0.owner,
        };
        0x2::event::emit<ManagerCreated>(v1);
        v0
    }

    public fun get_demo_object_creator(arg0: &DemoObject) : address {
        arg0.creator
    }

    public fun get_demo_object_value(arg0: &DemoObject) : u64 {
        arg0.value
    }

    public fun get_managed_objects(arg0: &ObjectManager) : &vector<address> {
        &arg0.managed_objects
    }

    public fun receive_object<T0: store + key>(arg0: &mut ObjectManager, arg1: 0x2::transfer::Receiving<T0>, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg1);
        let v1 = 0x2::object::id_address<T0>(&v0);
        0x1::vector::push_back<address>(&mut arg0.managed_objects, v1);
        let v2 = ObjectReceived{
            manager_id : 0x2::object::uid_to_address(&arg0.id),
            object_id  : v1,
            from       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ObjectReceived>(v2);
        v0
    }

    public fun return_object<T0: store + key>(arg0: &mut ObjectManager, arg1: T0, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<T0>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.managed_objects, &v0);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.managed_objects, v2);
        };
        let v3 = ObjectReturned{
            manager_id : 0x2::object::uid_to_address(&arg0.id),
            object_id  : v0,
            to         : arg2,
        };
        0x2::event::emit<ObjectReturned>(v3);
        0x2::transfer::public_transfer<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

