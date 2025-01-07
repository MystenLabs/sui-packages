module 0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::collector {
    struct COLLECTOR has drop {
        dummy_field: bool,
    }

    struct Collector has store, key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        col_id: 0x2::object::ID,
    }

    fun check_admin(arg0: &Collector, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<Collector>(arg0) == &arg1.col_id, 0);
    }

    fun init(arg0: COLLECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Collector{
            id       : v0,
            receiver : 0x2::tx_context::sender(arg1),
        };
        let v2 = AdminCap{
            id     : 0x2::object::new(arg1),
            col_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Collector>(v1);
    }

    public fun sendFee(arg0: &Collector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.receiver);
    }

    public fun setCollector(arg0: &AdminCap, arg1: &mut Collector, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        arg1.receiver = arg2;
    }

    // decompiled from Move bytecode v6
}

