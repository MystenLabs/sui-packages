module 0xa563ace20f247f966b1819909d6cf24a52cc18c2ba14a72890c88d44be066545::events {
    struct NewPsmPool has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        decimal: u8,
        swap_in_fee_bps: u64,
        swap_out_fee_bps: u64,
    }

    struct PsmSwapIn<phantom T0> has copy, drop {
        asset_in_amount: u64,
        asset_balance: u64,
        usdb_out_amount: u64,
        usdb_supply: u64,
    }

    struct PsmSwapOut<phantom T0> has copy, drop {
        usdb_in_amount: u64,
        usdb_supply: u64,
        asset_out_amount: u64,
        asset_balance: u64,
    }

    public(friend) fun emit_new_pool<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = NewPsmPool{
            pool_id          : arg0,
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            decimal          : arg1,
            swap_in_fee_bps  : arg2,
            swap_out_fee_bps : arg3,
        };
        0x2::event::emit<NewPsmPool>(v0);
    }

    public(friend) fun emit_swap_in<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PsmSwapIn<T0>{
            asset_in_amount : arg0,
            asset_balance   : arg1,
            usdb_out_amount : arg2,
            usdb_supply     : arg3,
        };
        0x2::event::emit<PsmSwapIn<T0>>(v0);
    }

    public(friend) fun emit_swap_out<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PsmSwapOut<T0>{
            usdb_in_amount   : arg0,
            usdb_supply      : arg1,
            asset_out_amount : arg2,
            asset_balance    : arg3,
        };
        0x2::event::emit<PsmSwapOut<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

