module 0xe45480d205fd63134e15cddd110a6ffb30aa74ecd2ba170bbce641b3258a6009::account {
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
        0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray();
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

