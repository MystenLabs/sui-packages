module 0x88f20db4a12d96102e83d3f5fee59b789ce1d93a0d0a14432036da95b83b3b9d::subscription_usdc {
    struct Service has key {
        id: 0x2::object::UID,
        admin: address,
        fee: u64,
        ttl_ms: u64,
        name: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    struct Pass has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
        owner: address,
        expiry_ms: u64,
    }

    public fun create_service(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Service{
            id     : 0x2::object::new(arg3),
            admin  : 0x2::tx_context::sender(arg3),
            fee    : arg0,
            ttl_ms : arg1,
            name   : arg2,
        };
        let v1 = AdminCap{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(&v0),
        };
        0x2::transfer::share_object<Service>(v0);
        v1
    }

    public fun has_access(arg0: &Service, arg1: address, arg2: &0x2::clock::Clock) : bool {
        true
    }

    public fun policy(arg0: &Service, arg1: address, arg2: &0x2::clock::Clock) : bool {
        has_access(arg0, arg1, arg2)
    }

    public fun subscribe<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &Service, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Pass) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1.fee, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1.fee, arg3), arg1.admin);
        let v0 = Pass{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(arg1),
            owner      : 0x2::tx_context::sender(arg3),
            expiry_ms  : 0x2::clock::timestamp_ms(arg2) + arg1.ttl_ms,
        };
        (arg0, v0)
    }

    // decompiled from Move bytecode v6
}

