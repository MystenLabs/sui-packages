module 0x365778b66ee7d3e1bceb2122626e126e05dbf5849c947ce29e058fe1b5e6c4a0::account {
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

    public(friend) fun create_child_account_cao(arg0: &AccountCap, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg0.owner, 4000);
        AccountCap{
            id    : 0x2::object::new(arg1),
            owner : arg0.owner,
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

