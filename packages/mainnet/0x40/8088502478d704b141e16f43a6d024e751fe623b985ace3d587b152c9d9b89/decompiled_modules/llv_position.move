module 0x408088502478d704b141e16f43a6d024e751fe623b985ace3d587b152c9d9b89::llv_position {
    struct LLVPoolPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        user_shares: u128,
        user_yield_index: u128,
        deposited_assets: u128,
    }

    public(friend) fun destroy_empty<T0>(arg0: LLVPoolPosition<T0>) {
        let LLVPoolPosition {
            id               : v0,
            pool_id          : _,
            user_shares      : v2,
            user_yield_index : _,
            deposited_assets : _,
        } = arg0;
        assert!(v2 == 0, 2);
        0x2::object::delete(v0);
    }

    public fun id<T0>(arg0: &LLVPoolPosition<T0>) : 0x2::object::ID {
        0x2::object::id<LLVPoolPosition<T0>>(arg0)
    }

    public(friend) fun add_shares<T0>(arg0: &mut LLVPoolPosition<T0>, arg1: u128, arg2: u128) {
        arg0.user_shares = arg0.user_shares + arg1;
        arg0.deposited_assets = arg0.deposited_assets + arg2;
    }

    public(friend) fun create<T0>(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : LLVPoolPosition<T0> {
        LLVPoolPosition<T0>{
            id               : 0x2::object::new(arg4),
            pool_id          : arg0,
            user_shares      : arg1,
            user_yield_index : arg3,
            deposited_assets : arg2,
        }
    }

    public(friend) fun deduct_shares<T0>(arg0: &mut LLVPoolPosition<T0>, arg1: u128, arg2: u128) : u128 {
        assert!(arg0.user_shares >= arg1, 2);
        arg0.user_shares = arg0.user_shares - arg1;
        if (arg2 <= arg0.deposited_assets) {
            arg0.deposited_assets = arg0.deposited_assets - arg2;
        } else {
            arg0.deposited_assets = 0;
        };
        arg0.user_shares
    }

    public fun deposited_assets<T0>(arg0: &LLVPoolPosition<T0>) : u128 {
        arg0.deposited_assets
    }

    public fun is_empty<T0>(arg0: &LLVPoolPosition<T0>) : bool {
        arg0.user_shares == 0
    }

    public fun pool_id<T0>(arg0: &LLVPoolPosition<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun shares<T0>(arg0: &LLVPoolPosition<T0>) : u128 {
        arg0.user_shares
    }

    public(friend) fun transfer_to<T0>(arg0: LLVPoolPosition<T0>, arg1: address) {
        0x2::transfer::public_transfer<LLVPoolPosition<T0>>(arg0, arg1);
    }

    public fun yield_index<T0>(arg0: &LLVPoolPosition<T0>) : u128 {
        arg0.user_yield_index
    }

    // decompiled from Move bytecode v6
}

