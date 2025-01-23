module 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl {
    struct ACL has store, key {
        id: 0x2::object::UID,
        permissions: 0x2::vec_map::VecMap<address, u128>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id          : 0x2::object::new(arg0),
            permissions : 0x2::vec_map::empty<address, u128>(),
        };
        0x2::vec_map::insert<address, u128>(&mut v0.permissions, 0x2::tx_context::sender(arg0), 1 << 127);
        0x2::transfer::share_object<ACL>(v0);
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 128, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::invalid_argument(0));
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::acl_invalid_permission());
        assert!(!has_role(arg0, arg1, arg2), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::acl_role_already_exists());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun admin_role() : u8 {
        127
    }

    public fun create_market_role() : u8 {
        2
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::invalid_argument(0));
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << 127 > 0) {
            return true
        };
        0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << arg2 > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new(arg0);
    }

    public fun register_sy_role() : u8 {
        1
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 128, 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::invalid_argument(0));
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::acl_invalid_permission());
        assert!(has_role(arg0, arg1, arg2), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::acl_role_not_exists());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 - (1 << arg2);
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::acl_invalid_permission());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            *0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    public fun update_config_role() : u8 {
        3
    }

    // decompiled from Move bytecode v6
}

