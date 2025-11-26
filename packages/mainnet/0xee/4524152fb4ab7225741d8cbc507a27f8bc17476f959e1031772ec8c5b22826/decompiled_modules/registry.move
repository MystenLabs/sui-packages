module 0xee4524152fb4ab7225741d8cbc507a27f8bc17476f959e1031772ec8c5b22826::registry {
    struct WhiteListMintRegistry has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    struct WhitelistAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct AddressWhitelisted has copy, drop {
        address: address,
    }

    struct AddressRemovedFromWhitelist has copy, drop {
        address: address,
    }

    public fun add_to_whitelist(arg0: &mut WhiteListMintRegistry, arg1: &WhitelistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<WhiteListMintRegistry>(arg0) == arg1.registry_id, 1);
        if (!0x2::vec_set::contains<address>(&arg0.whitelist, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.whitelist, arg2);
            let v0 = AddressWhitelisted{address: arg2};
            0x2::event::emit<AddressWhitelisted>(v0);
        };
    }

    public entry fun add_to_whitelist_entry(arg0: &mut WhiteListMintRegistry, arg1: &WhitelistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        add_to_whitelist(arg0, arg1, arg2, arg3);
    }

    public entry fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhiteListMintRegistry{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<WhiteListMintRegistry>(v0);
        let v1 = WhitelistAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<WhiteListMintRegistry>(&v0),
        };
        0x2::transfer::public_transfer<WhitelistAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &WhiteListMintRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun registry_id(arg0: &WhiteListMintRegistry) : 0x2::object::ID {
        0x2::object::id<WhiteListMintRegistry>(arg0)
    }

    public fun remove_from_whitelist(arg0: &mut WhiteListMintRegistry, arg1: &WhitelistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<WhiteListMintRegistry>(arg0) == arg1.registry_id, 1);
        if (0x2::vec_set::contains<address>(&arg0.whitelist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.whitelist, &arg2);
            let v0 = AddressRemovedFromWhitelist{address: arg2};
            0x2::event::emit<AddressRemovedFromWhitelist>(v0);
        };
    }

    public entry fun remove_from_whitelist_entry(arg0: &mut WhiteListMintRegistry, arg1: &WhitelistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        remove_from_whitelist(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

