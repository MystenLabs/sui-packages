module 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Init has key {
        id: 0x2::object::UID,
        admin: address,
        addresses: 0x2::vec_set::VecSet<address>,
    }

    public fun expect<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun get_init_data(arg0: &Init) : (address, 0x2::vec_set::VecSet<address>) {
        (arg0.admin, arg0.addresses)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Init{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Init>(v1);
    }

    public fun update_addresses(arg0: &AdminCap, arg1: &mut Init, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_set::contains<address>(&arg1.addresses, &v1)) {
                0x2::vec_set::insert<address>(&mut arg1.addresses, v1);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

