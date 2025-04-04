module 0x9d01a914ce7ea3f61fac80906784b2c9439cc23cad9c8b0d99d8b3e611a8e0df::suins_workshop {
    struct WhiteListAddresses has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        whitelisted_addresses: 0x2::vec_set::VecSet<address>,
    }

    public fun add_whitelist(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &mut WhiteListAddresses, arg2: address) {
        assert!(arg1.nft_id == 0x2::object::uid_to_inner(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0)), 2);
        assert!(!0x2::vec_set::contains<address>(&arg1.whitelisted_addresses, &arg2), 4);
        0x2::vec_set::insert<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public fun create_whitelist(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : WhiteListAddresses {
        let v0 = 0x2::object::new(arg3);
        let v1 = WhiteListAddresses{
            id                    : v0,
            nft_id                : 0x2::object::uid_to_inner(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg1)),
            whitelisted_addresses : 0x2::vec_set::empty<address>(),
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_target_address(arg0, arg1, 0x1::option::some<address>(0x2::object::uid_to_address(&v0)), arg2);
        v1
    }

    public fun is_whitelisted(arg0: &WhiteListAddresses, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun remove_whitelist(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &mut WhiteListAddresses, arg2: address) {
        assert!(arg1.nft_id == 0x2::object::uid_to_inner(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0)), 2);
        assert!(0x2::vec_set::contains<address>(&arg1.whitelisted_addresses, &arg2), 3);
        0x2::vec_set::remove<address>(&mut arg1.whitelisted_addresses, &arg2);
    }

    public fun share(arg0: WhiteListAddresses) {
        0x2::transfer::share_object<WhiteListAddresses>(arg0);
    }

    public fun whitelist_id(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String) : 0x2::object::ID {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1));
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0));
        assert!(0x1::option::is_some<address>(&v1), 1);
        0x2::object::id_from_address(0x1::option::get_with_default<address>(&v1, @0x0))
    }

    public fun whitelisted_addresses(arg0: &WhiteListAddresses) : 0x2::vec_set::VecSet<address> {
        arg0.whitelisted_addresses
    }

    // decompiled from Move bytecode v6
}

