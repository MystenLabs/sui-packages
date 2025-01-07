module 0xc967b7862d926720761ee15fbd0254a975afa928712abcaa4f7c17bb2b38d38b::denylist {
    struct Denylist has store {
        reserved: 0x2::table::Table<0x1::string::String, bool>,
        blocked: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct DenyListAuth has drop {
        dummy_field: bool,
    }

    fun denylist(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &Denylist {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<Denylist>(arg0)
    }

    public fun add_blocked_names(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: vector<0x1::string::String>) {
        let v0 = &mut denylist_mut(arg0).blocked;
        internal_add_names_to_list(v0, arg2);
    }

    public fun add_reserved_names(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: vector<0x1::string::String>) {
        let v0 = &mut denylist_mut(arg0).reserved;
        internal_add_names_to_list(v0, arg2);
    }

    fun denylist_mut(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &mut Denylist {
        let v0 = DenyListAuth{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<DenyListAuth, Denylist>(v0, arg0)
    }

    fun internal_add_names_to_list(arg0: &mut 0x2::table::Table<0x1::string::String, bool>, arg1: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) > 0, 1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            0x2::table::add<0x1::string::String, bool>(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), true);
        };
    }

    fun internal_remove_names_from_list(arg0: &mut 0x2::table::Table<0x1::string::String, bool>, arg1: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) > 0, 1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            0x2::table::remove<0x1::string::String, bool>(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v0));
        };
    }

    public fun is_blocked_name(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&denylist(arg0).blocked, arg1)
    }

    public fun is_reserved_name(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&denylist(arg0).reserved, arg1)
    }

    public fun remove_blocked_names(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: vector<0x1::string::String>) {
        let v0 = &mut denylist_mut(arg0).blocked;
        internal_remove_names_from_list(v0, arg2);
    }

    public fun remove_reserved_names(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: vector<0x1::string::String>) {
        let v0 = &mut denylist_mut(arg0).reserved;
        internal_remove_names_from_list(v0, arg2);
    }

    public fun setup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Denylist{
            reserved : 0x2::table::new<0x1::string::String, bool>(arg2),
            blocked  : 0x2::table::new<0x1::string::String, bool>(arg2),
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::add_registry<Denylist>(arg1, arg0, v0);
    }

    // decompiled from Move bytecode v6
}

