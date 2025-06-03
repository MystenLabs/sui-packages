module 0x4d36a2e7d1eb6e7a46efa7492d9a031fd6f16ba8890516fae9cc23c3eac63fad::main {
    struct Lawyer has store, key {
        id: 0x2::object::UID,
        address: address,
        is_whitelisted: bool,
        is_delegate: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LawyerWhitelisted has copy, drop {
        lawyer_id: address,
        admin: address,
    }

    struct DelegateAdded has copy, drop {
        lawyer_id: address,
        admin: address,
    }

    public entry fun add_delegate(arg0: &AdminCap, arg1: &mut Lawyer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_whitelisted, 0);
        assert!(!arg1.is_delegate, 2);
        arg1.is_delegate = true;
        let v0 = DelegateAdded{
            lawyer_id : arg1.address,
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DelegateAdded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_lawyer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Lawyer{
            id             : 0x2::object::new(arg0),
            address        : 0x2::tx_context::sender(arg0),
            is_whitelisted : false,
            is_delegate    : false,
        };
        0x2::transfer::share_object<Lawyer>(v0);
    }

    public entry fun whitelist_lawyer(arg0: &AdminCap, arg1: &mut Lawyer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_whitelisted, 1);
        arg1.is_whitelisted = true;
        let v0 = LawyerWhitelisted{
            lawyer_id : arg1.address,
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LawyerWhitelisted>(v0);
    }

    // decompiled from Move bytecode v6
}

