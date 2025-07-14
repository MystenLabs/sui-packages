module 0xf9f52fdb675f5817f8448b4ca18c9079312303e494d53f288c7d6522220a778f::vault_event {
    struct BuyShareEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        share_amount: u64,
    }

    struct SellShareEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        share_amount: u64,
    }

    struct TakeBalanceEvent<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct PutBalanceEvent<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun buy_share_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = BuyShareEvent<T0, T1>{
            vault_id     : arg0,
            base_amount  : arg1,
            share_amount : arg2,
        };
        0x2::event::emit<BuyShareEvent<T0, T1>>(v0);
    }

    public fun put_balance_event<T0, T1, T2: drop, T3>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PutBalanceEvent<T0, T1, T2, T3>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<PutBalanceEvent<T0, T1, T2, T3>>(v0);
    }

    public fun sell_share_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = SellShareEvent<T0, T1>{
            vault_id     : arg0,
            base_amount  : arg1,
            share_amount : arg2,
        };
        0x2::event::emit<SellShareEvent<T0, T1>>(v0);
    }

    public fun take_balance_event<T0, T1, T2: drop, T3>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = TakeBalanceEvent<T0, T1, T2, T3>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<TakeBalanceEvent<T0, T1, T2, T3>>(v0);
    }

    // decompiled from Move bytecode v6
}

