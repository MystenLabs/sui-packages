module 0x81df452fc006a3c9a5046ce7ae42bce21cd10341c7e85035d337bbe2c8e88e9b::subscription {
    struct Service has key {
        id: 0x2::object::UID,
        fee: u64,
        ttl: u64,
        owner: address,
        name: 0x1::string::String,
    }

    struct Subscription has key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
        created_at: u64,
    }

    struct Cap has key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    public fun transfer(arg0: Subscription, arg1: address) {
        0x2::transfer::transfer<Subscription>(arg0, arg1);
    }

    fun approve_internal(arg0: vector<u8>, arg1: &Subscription, arg2: &Service, arg3: &0x2::clock::Clock) : bool {
        if (0x2::object::id<Service>(arg2) != arg1.service_id) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg3) > arg1.created_at + arg2.ttl) {
            return false
        };
        0x81df452fc006a3c9a5046ce7ae42bce21cd10341c7e85035d337bbe2c8e88e9b::utils::is_prefix(0x2::object::uid_to_bytes(&arg2.id), arg0)
    }

    public fun create_service(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Cap {
        let v0 = Service{
            id    : 0x2::object::new(arg3),
            fee   : arg0,
            ttl   : arg1,
            owner : 0x2::tx_context::sender(arg3),
            name  : arg2,
        };
        let v1 = Cap{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(&v0),
        };
        0x2::transfer::share_object<Service>(v0);
        v1
    }

    entry fun create_service_entry(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_service(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Cap>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun publish(arg0: &mut Service, arg1: &Cap, arg2: 0x1::string::String) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, arg2, 3);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Subscription, arg2: &Service, arg3: &0x2::clock::Clock) {
        assert!(approve_internal(arg0, arg1, arg2, arg3), 2);
    }

    public fun subscribe(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &Service, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Subscription {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1.owner);
        Subscription{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(arg1),
            created_at : 0x2::clock::timestamp_ms(arg2),
        }
    }

    // decompiled from Move bytecode v6
}

