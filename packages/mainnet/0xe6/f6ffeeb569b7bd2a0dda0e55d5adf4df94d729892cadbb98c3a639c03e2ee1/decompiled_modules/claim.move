module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim {
    struct Claim<phantom T0> has store, key {
        id: 0x2::object::UID,
        for_account: 0x2::object::ID,
        amount: u64,
        expiry_ms: u64,
    }

    public fun create<T0>(arg0: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg5: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg6: &mut 0x2::tx_context::TxContext) : Claim<T0> {
        let v0 = 0x2::object::new(arg6);
        Claim<T0>{
            id          : v0,
            for_account : 0x2::object::id<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>>(arg0),
            amount      : arg1,
            expiry_ms   : 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::add_hold<T0>(arg0, 0x2::object::uid_to_address(&v0), arg1, arg2, arg3, arg4, arg5),
        }
    }

    public entry fun destroy<T0>(arg0: Claim<T0>, arg1: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>) {
        assert!(arg0.for_account == 0x2::object::id<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>>(arg1), 0);
        let Claim {
            id          : v0,
            for_account : _,
            amount      : _,
            expiry_ms   : _,
        } = arg0;
        let v4 = v0;
        let v5 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::begin_with_object_id(&v4);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::release_held_funds<T0>(arg1, 0x2::object::uid_to_address(&v4), &v5);
        0x2::object::delete(v4);
    }

    public fun info<T0>(arg0: &Claim<T0>) : (0x2::object::ID, u64, u64) {
        (arg0.for_account, arg0.amount, arg0.expiry_ms)
    }

    public entry fun redeem_claim<T0>(arg0: &mut Claim<T0>, arg1: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg2: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::begin_with_object_id(&arg0.id);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::withdraw_from_held_funds_<T0>(arg1, arg2, 0x2::object::uid_to_address(&arg0.id), arg3, arg4, arg5, &v0, arg6);
        arg0.amount = arg0.amount - arg3;
    }

    public entry fun redeem_entire_claim<T0>(arg0: Claim<T0>, arg1: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg2: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg3: &0x2::clock::Clock, arg4: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        let Claim {
            id          : v0,
            for_account : _,
            amount      : v2,
            expiry_ms   : _,
        } = arg0;
        let v4 = v0;
        let v5 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::begin_with_object_id(&v4);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::withdraw_from_held_funds_<T0>(arg1, arg2, 0x2::object::uid_to_address(&v4), v2, arg3, arg4, &v5, arg5);
        0x2::object::delete(v4);
    }

    // decompiled from Move bytecode v6
}

