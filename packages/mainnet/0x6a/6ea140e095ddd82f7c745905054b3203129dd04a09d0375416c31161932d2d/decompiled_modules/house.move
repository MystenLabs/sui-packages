module 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house {
    struct DiscountHouseApp has drop {
        dummy_field: bool,
    }

    struct DiscountHouse has store, key {
        id: 0x2::object::UID,
        version: u8,
    }

    public fun assert_version_is_valid(arg0: &DiscountHouse) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun friend_add_registry_entry(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::assert_app_is_authorized<DiscountHouseApp>(arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::assert_valid_user_registerable_domain(&arg1);
        let v0 = DiscountHouseApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::add_record(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<DiscountHouseApp, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v0, arg0), arg1, 1, arg2, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiscountHouse{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<DiscountHouse>(v0);
    }

    public fun set_version(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut DiscountHouse, arg2: u8) {
        arg1.version = arg2;
    }

    public(friend) fun suins_app_auth() : DiscountHouseApp {
        DiscountHouseApp{dummy_field: false}
    }

    public(friend) fun uid_mut(arg0: &mut DiscountHouse) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

