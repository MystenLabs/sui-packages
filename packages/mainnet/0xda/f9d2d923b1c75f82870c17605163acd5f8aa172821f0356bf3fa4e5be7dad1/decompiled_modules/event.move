module 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event {
    struct PoolCreated<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
    }

    struct LiquidityAdded<phantom T0, phantom T1> has copy, drop {
        deposit_x: u64,
        deposit_y: u64,
        lp_token: u64,
    }

    struct LiquidityRemoved<phantom T0, phantom T1> has copy, drop {
        withdrawl_x: u64,
        withdrawl_y: u64,
        lp_token: u64,
    }

    struct Swap<phantom T0, phantom T1> has copy, drop {
        input: u64,
        output: u64,
    }

    struct Sync<phantom T0, phantom T1> has copy, drop {
        res_x: u64,
        res_y: u64,
    }

    struct Fee<phantom T0> has copy, drop {
        amount: u64,
    }

    struct Claim<phantom T0, phantom T1> has copy, drop {
        from: address,
        amount_x: u64,
        amount_y: u64,
    }

    public fun swap<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = Swap<T0, T1>{
            input  : arg0,
            output : arg1,
        };
        0x2::event::emit<Swap<T0, T1>>(v0);
    }

    public fun claim<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = Claim<T0, T1>{
            from     : arg0,
            amount_x : arg1,
            amount_y : arg2,
        };
        0x2::event::emit<Claim<T0, T1>>(v0);
    }

    public fun fee<T0>(arg0: u64) {
        let v0 = Fee<T0>{amount: arg0};
        0x2::event::emit<Fee<T0>>(v0);
    }

    public fun liquidity_added<T0, T1>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = LiquidityAdded<T0, T1>{
            deposit_x : arg0,
            deposit_y : arg1,
            lp_token  : arg2,
        };
        0x2::event::emit<LiquidityAdded<T0, T1>>(v0);
    }

    public fun liquidity_removed<T0, T1>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = LiquidityRemoved<T0, T1>{
            withdrawl_x : arg0,
            withdrawl_y : arg1,
            lp_token    : arg2,
        };
        0x2::event::emit<LiquidityRemoved<T0, T1>>(v0);
    }

    public fun pool_created<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = PoolCreated<T0, T1>{
            pool_id : arg0,
            creator : arg1,
        };
        0x2::event::emit<PoolCreated<T0, T1>>(v0);
    }

    public fun sync<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = Sync<T0, T1>{
            res_x : arg0,
            res_y : arg1,
        };
        0x2::event::emit<Sync<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

