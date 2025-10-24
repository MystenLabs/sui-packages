module 0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::account {
    struct AccountCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun account_owner(arg0: &AccountCap) : address {
        arg0.owner
    }

    public(friend) fun create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = 0x2::object::new(arg0);
        AccountCap{
            id    : v0,
            owner : 0x2::object::uid_to_address(&v0),
        }
    }

    public(friend) fun create_child_account_cap(arg0: &AccountCap, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = arg0.owner;
        assert!(0x2::object::uid_to_address(&arg0.id) == v0, 0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::error::required_parent_account_cap());
        AccountCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        }
    }

    public(friend) fun delete_account_cap(arg0: AccountCap) {
        let AccountCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

