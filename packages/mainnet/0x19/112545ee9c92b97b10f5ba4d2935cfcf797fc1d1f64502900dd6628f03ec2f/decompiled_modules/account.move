module 0x19112545ee9c92b97b10f5ba4d2935cfcf797fc1d1f64502900dd6628f03ec2f::account {
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

    public(friend) fun create_child_account_cap(arg0: &AccountCap, arg1: &mut 0x2::tx_context::TxContext, arg2: &0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle::PriceOracle) : AccountCap {
        let v0 = arg0.owner;
        assert!(0x2::object::uid_to_address(&arg0.id) == v0, 0);
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

