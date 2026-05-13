module 0xc3c44efaaac1dcb88e6da74cf7cae92e161c79e2a66eaa44c37fd0e5beea1687::receipt {
    struct ContributionReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        sui_amount: u64,
        token_share: u64,
        created_at_ms: u64,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ContributionReceipt<T0> {
        ContributionReceipt<T0>{
            id            : 0x2::object::new(arg4),
            project_id    : arg0,
            sui_amount    : arg1,
            token_share   : arg2,
            created_at_ms : arg3,
        }
    }

    public fun created_at_ms<T0>(arg0: &ContributionReceipt<T0>) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun destroy<T0>(arg0: ContributionReceipt<T0>) : (0x2::object::ID, 0x2::object::ID, u64, u64) {
        let ContributionReceipt {
            id            : v0,
            project_id    : v1,
            sui_amount    : v2,
            token_share   : v3,
            created_at_ms : _,
        } = arg0;
        let v5 = v0;
        0x2::object::delete(v5);
        (0x2::object::uid_to_inner(&v5), v1, v2, v3)
    }

    public fun project_id<T0>(arg0: &ContributionReceipt<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun sui_amount<T0>(arg0: &ContributionReceipt<T0>) : u64 {
        arg0.sui_amount
    }

    public fun token_share<T0>(arg0: &ContributionReceipt<T0>) : u64 {
        arg0.token_share
    }

    // decompiled from Move bytecode v7
}

