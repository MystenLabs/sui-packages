module 0x850faed9b676813d324eef3c82db0b48c404381ea8b30b3cadd26e36d393e0cf::clob_v2 {
    struct WithdrawAsset<phantom T0> has copy, drop {
        pool_id: address,
        quantity: u64,
        owner: address,
    }

    struct DepositAsset<phantom T0> has copy, drop {
        pool_id: address,
        quantity: u64,
        owner: address,
    }

    public fun spoof<T0>(arg0: address, arg1: u64, arg2: address) {
        let v0 = DepositAsset<T0>{
            pool_id  : arg2,
            quantity : arg1,
            owner    : arg0,
        };
        0x2::event::emit<DepositAsset<T0>>(v0);
        let v1 = WithdrawAsset<T0>{
            pool_id  : arg2,
            quantity : arg1,
            owner    : arg0,
        };
        0x2::event::emit<WithdrawAsset<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

