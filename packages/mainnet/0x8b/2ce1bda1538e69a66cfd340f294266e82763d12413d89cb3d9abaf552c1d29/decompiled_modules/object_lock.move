module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::object_lock {
    struct Lock<T0: store + key> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        unlock_ms: u64,
        asset: 0x1::option::Option<T0>,
    }

    struct Created has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        beneficiary: address,
        asset: 0x2::object::ID,
        unlock_ms: u64,
    }

    struct Released has copy, drop {
        id: 0x2::object::ID,
        beneficiary: address,
        asset: 0x2::object::ID,
    }

    public fun beneficiary<T0: store + key>(arg0: &Lock<T0>) : address {
        arg0.beneficiary
    }

    public fun create<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 != @0x0 && arg2 > 0x2::clock::timestamp_ms(arg3), 1);
        let v0 = Lock<T0>{
            id          : 0x2::object::new(arg4),
            beneficiary : arg1,
            unlock_ms   : arg2,
            asset       : 0x1::option::some<T0>(arg0),
        };
        let v1 = 0x2::object::id<Lock<T0>>(&v0);
        let v2 = Created{
            id          : v1,
            creator     : 0x2::tx_context::sender(arg4),
            beneficiary : arg1,
            asset       : 0x2::object::id<T0>(&arg0),
            unlock_ms   : arg2,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::share_object<Lock<T0>>(v0);
        v1
    }

    public fun release<T0: store + key>(arg0: &mut Lock<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 2);
        assert!(0x1::option::is_some<T0>(&arg0.asset), 3);
        let v0 = 0x1::option::extract<T0>(&mut arg0.asset);
        let v1 = Released{
            id          : 0x2::object::id<Lock<T0>>(arg0),
            beneficiary : arg0.beneficiary,
            asset       : 0x2::object::id<T0>(&v0),
        };
        0x2::event::emit<Released>(v1);
        0x2::transfer::public_transfer<T0>(v0, arg0.beneficiary);
    }

    // decompiled from Move bytecode v7
}

