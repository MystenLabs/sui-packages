module 0x5790373dae32f531d99449de51829ec593efb69f9e08b79b8aefc7935f8bd97c::registry {
    struct Deployments has store {
        factory_id: 0x2::object::ID,
        factory_cap_id: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun register<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = Deployments{
            factory_id     : arg1,
            factory_cap_id : arg2,
        };
        0x2::dynamic_field::add<0x1::ascii::String, Deployments>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0);
    }

    // decompiled from Move bytecode v6
}

