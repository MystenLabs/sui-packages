module 0x7cd04d8756b4e9e904c7b7ec9510be520d1a3d9342436842b185ba022d0f4451::whitelist {
    struct WhitelistItem has store {
        invested: bool,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        allowed_addresses: 0x2::table::Table<address, WhitelistItem>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Whitelist {
        Whitelist{
            id                : 0x2::object::new(arg0),
            allowed_addresses : 0x2::table::new<address, WhitelistItem>(arg0),
        }
    }

    public fun contains(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, WhitelistItem>(&arg0.allowed_addresses, arg1)
    }

    public(friend) fun add_investor(arg0: &mut Whitelist, arg1: address) {
        if (!0x2::table::contains<address, WhitelistItem>(&arg0.allowed_addresses, arg1)) {
            let v0 = WhitelistItem{invested: false};
            0x2::table::add<address, WhitelistItem>(&mut arg0.allowed_addresses, arg1, v0);
        };
    }

    public(friend) fun add_to_whitelist(arg0: &mut Whitelist, arg1: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            add_investor(arg0, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun can_invest(arg0: &Whitelist, arg1: address) : bool {
        if (contains(arg0, arg1)) {
            return !0x2::table::borrow<address, WhitelistItem>(&arg0.allowed_addresses, arg1).invested
        };
        false
    }

    public(friend) fun investor_invested(arg0: &mut Whitelist, arg1: address) {
        0x2::table::borrow_mut<address, WhitelistItem>(&mut arg0.allowed_addresses, arg1).invested = true;
    }

    // decompiled from Move bytecode v6
}

