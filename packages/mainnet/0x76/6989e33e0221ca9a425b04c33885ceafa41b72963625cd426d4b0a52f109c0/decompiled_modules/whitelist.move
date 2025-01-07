module 0x766989e33e0221ca9a425b04c33885ceafa41b72963625cd426d4b0a52f109c0::whitelist {
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

    public fun can_invest_second_sale(arg0: &Whitelist, arg1: address) : bool {
        if (contains(arg0, arg1)) {
            return !0x2::table::borrow<address, WhitelistItem>(&arg0.allowed_addresses, arg1).invested
        };
        true
    }

    public(friend) fun investor_invested(arg0: &mut Whitelist, arg1: address) {
        0x2::table::borrow_mut<address, WhitelistItem>(&mut arg0.allowed_addresses, arg1).invested = true;
    }

    // decompiled from Move bytecode v6
}

