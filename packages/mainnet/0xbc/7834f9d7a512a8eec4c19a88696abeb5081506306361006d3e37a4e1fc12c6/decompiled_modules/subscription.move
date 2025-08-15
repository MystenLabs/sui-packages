module 0xbc7834f9d7a512a8eec4c19a88696abeb5081506306361006d3e37a4e1fc12c6::subscription {
    struct PackageVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PackageVersionCap has key {
        id: 0x2::object::UID,
    }

    struct Service has key {
        id: 0x2::object::UID,
        fee: u64,
        ttl: u64,
        owner: address,
    }

    struct Subscription has key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
        created_at: u64,
    }

    public fun transfer(arg0: Subscription, arg1: address) {
        0x2::transfer::transfer<Subscription>(arg0, arg1);
    }

    fun check_policy(arg0: vector<u8>, arg1: &PackageVersion, arg2: &Subscription, arg3: &Service, arg4: &0x2::clock::Clock) : bool {
        assert!(arg1.version == 1, 5);
        if (0x2::object::id<Service>(arg3) != arg2.service_id) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg4) > arg2.created_at + arg3.ttl) {
            return false
        };
        let v0 = 0x2::object::uid_to_bytes(&arg3.id);
        let v1 = 0;
        if (0x1::vector::length<u8>(&v0) > 0x1::vector::length<u8>(&arg0)) {
            return false
        };
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(&arg0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun create_service(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Service {
        Service{
            id    : 0x2::object::new(arg2),
            fee   : arg0,
            ttl   : arg1,
            owner : 0x2::tx_context::sender(arg2),
        }
    }

    entry fun create_service_entry(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Service>(create_service(arg0, arg1, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
        let v1 = PackageVersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackageVersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PackageVersion, arg2: &Subscription, arg3: &Service, arg4: &0x2::clock::Clock) {
        assert!(check_policy(arg0, arg1, arg2, arg3, arg4), 77);
    }

    public fun subscribe(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &Service, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Subscription {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.fee, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1.owner);
        Subscription{
            id         : 0x2::object::new(arg3),
            service_id : 0x2::object::id<Service>(arg1),
            created_at : 0x2::clock::timestamp_ms(arg2),
        }
    }

    // decompiled from Move bytecode v6
}

