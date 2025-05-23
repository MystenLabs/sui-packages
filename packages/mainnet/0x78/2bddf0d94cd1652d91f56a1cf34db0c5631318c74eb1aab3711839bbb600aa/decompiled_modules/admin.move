module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        publisher: 0x2::package::Publisher,
    }

    public fun assert_admin_owner_is_sender(arg0: &mut AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::ENotAdmin());
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{
            id        : 0x2::object::new(arg1),
            owner     : v0,
            publisher : 0x2::package::claim<ADMIN>(arg0, arg1),
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public entry fun initialize(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg2);
        let v0 = 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::get_caller();
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::PRIVASUI>(arg1, &v0);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::price::initialize(v1, arg2);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::treasury::initialize(v1, arg2);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::profile::initialize(v1, arg2);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::initialize(v1, arg2);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::display::initialize(v1, &mut arg0.publisher, arg2);
    }

    public entry fun set_price(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg4);
        let v0 = 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::get_caller();
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::price::insert_price(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::PRIVASUI>(arg1, &v0), arg2, arg3);
    }

    public entry fun withdraw(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg3);
        let v0 = 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::get_caller();
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::treasury::withdrawToAddress(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller::PRIVASUI>(arg1, &v0), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

