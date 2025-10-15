module 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::admin {
    struct Admin has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
        is_init: bool,
    }

    struct ChangeAdminRequest has key {
        id: 0x2::object::UID,
        address: address,
        deadline: u64,
    }

    public fun add_admin(arg0: &mut Admin, arg1: vector<address>) {
        assert!(!arg0.is_init, 2);
        0x1::vector::append<address>(&mut arg0.addresses, arg1);
        arg0.is_init = true;
    }

    public fun create_add_admin_request(arg0: &mut Admin, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_init, 1);
        assert!(!0x1::vector::contains<address>(&arg0.addresses, &arg1), 2);
        let v0 = ChangeAdminRequest{
            id       : 0x2::object::new(arg3),
            address  : arg1,
            deadline : arg2,
        };
        0x2::transfer::share_object<ChangeAdminRequest>(v0);
    }

    public fun create_admin(arg0: &mut 0x2::tx_context::TxContext) : Admin {
        Admin{
            id        : 0x2::object::new(arg0),
            addresses : 0x1::vector::empty<address>(),
            is_init   : false,
        }
    }

    public(friend) fun is_admin(arg0: &Admin, arg1: address) : bool {
        assert!(arg0.is_init, 1);
        0x1::vector::contains<address>(&arg0.addresses, &arg1)
    }

    public fun is_init(arg0: &Admin) : bool {
        arg0.is_init
    }

    public fun num_of_admin(arg0: &Admin) : u64 {
        assert!(arg0.is_init, 1);
        0x1::vector::length<address>(&arg0.addresses)
    }

    public fun vote_add_admin(arg0: &mut Admin, arg1: &mut ChangeAdminRequest) {
        assert!(arg0.is_init, 1);
        assert!(!0x1::vector::contains<address>(&arg0.addresses, &arg1.address), 2);
        0x1::vector::push_back<address>(&mut arg0.addresses, arg1.address);
    }

    // decompiled from Move bytecode v6
}

