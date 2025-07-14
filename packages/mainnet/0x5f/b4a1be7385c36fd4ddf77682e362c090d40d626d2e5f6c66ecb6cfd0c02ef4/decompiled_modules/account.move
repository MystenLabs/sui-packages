module 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::account {
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
        assert!(0x2::object::uid_to_address(&arg0.id) == v0, 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::error::required_parent_account_cap());
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

