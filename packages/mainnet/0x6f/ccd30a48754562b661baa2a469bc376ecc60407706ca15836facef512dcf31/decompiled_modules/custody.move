module 0x6fccd30a48754562b661baa2a469bc376ecc60407706ca15836facef512dcf31::custody {
    struct OwnerKey has copy, drop, store {
        addr: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Custody has key {
        id: 0x2::object::UID,
        parent: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
    }

    public fun deposit_parent(arg0: &AdminCap, arg1: &mut Custody, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) {
        assert!(0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.parent), 1);
        0x1::option::fill<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.parent, arg2);
    }

    fun full_leaf_name(arg0: &Custody, arg1: 0x1::string::String) : 0x1::string::String {
        0x1::string::append_utf8(&mut arg1, b".");
        0x1::string::append(&mut arg1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent)));
        arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Custody{
            id     : 0x2::object::new(arg0),
            parent : 0x1::option::none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(),
        };
        0x2::transfer::share_object<Custody>(v1);
    }

    fun record_owner(arg0: &mut Custody, arg1: address, arg2: 0x1::string::String) {
        let v0 = OwnerKey{addr: arg1};
        if (0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<OwnerKey, 0x1::string::String>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<OwnerKey, 0x1::string::String>(&mut arg0.id, v0, arg2);
        };
    }

    public fun register_initial(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = full_leaf_name(arg0, arg3);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::reverse_lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg1), v0);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg1, 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), arg2, v1, v0, arg4);
        if (!0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain>(&v2)) {
            0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_reverse_lookup(arg1, v1, arg4);
        };
        record_owner(arg0, v0, v1);
    }

    public fun set_as_default(arg0: &Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_reverse_lookup(arg1, full_leaf_name(arg0, arg2), arg3);
    }

    public fun subname_of(arg0: &Custody, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: address) : 0x1::option::Option<0x1::string::String> {
        let v0 = OwnerKey{addr: arg2};
        if (!0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v0)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v1 = *0x2::dynamic_field::borrow<OwnerKey, 0x1::string::String>(&arg0.id, v0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg1), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(v1));
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v2)) {
            let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v2));
            if (0x1::option::is_some<address>(&v3) && *0x1::option::borrow<address>(&v3) == arg2) {
                return 0x1::option::some<0x1::string::String>(v1)
            };
        };
        0x1::option::none<0x1::string::String>()
    }

    public fun withdraw_parent(arg0: &AdminCap, arg1: &mut Custody) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.parent), 0);
        0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.parent)
    }

    // decompiled from Move bytecode v7
}

