module 0x6d91a0967f4e094877fec3890f62fdd12feaad42ece9ef7a7dcfe755fbed9ba0::subscription_usdc {
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

    struct Access has store {
        expiry_ms: u64,
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
        if (arg1 == arg0.admin) {
            return true
        };
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) <= 0x2::dynamic_field::borrow<address, Access>(&arg0.id, arg1).expiry_ms
    }

    public fun policy(arg0: &Service, arg1: address, arg2: &0x2::clock::Clock) : bool {
        seal_approve(arg0, arg1, arg2)
    }

    public fun seal_approve(arg0: &Service, arg1: address, arg2: &0x2::clock::Clock) : bool {
        has_access(arg0, arg1, arg2)
    }

    public fun subscribe<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Service, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Pass) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1.fee, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1.fee, arg3), arg1.admin);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2) + arg1.ttl_ms;
        let v2 = &mut arg1.id;
        upsert_access(v2, v0, v1);
        let v3 = Pass{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(arg1),
            owner      : v0,
            expiry_ms  : v1,
        };
        (arg0, v3)
    }

    fun upsert_access(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64) {
        if (0x2::dynamic_field::exists_<address>(arg0, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, Access>(arg0, arg1);
            if (arg2 > v0.expiry_ms) {
                v0.expiry_ms = arg2;
            };
        } else {
            let v1 = Access{expiry_ms: arg2};
            0x2::dynamic_field::add<address, Access>(arg0, arg1, v1);
        };
    }

    // decompiled from Move bytecode v6
}

