module 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::jackpot {
    struct JackpotCreatedEvent<phantom T0> has copy, drop {
        jackpot_id: 0x2::object::ID,
    }

    struct JackpotDepositEvent<phantom T0> has copy, drop {
        jackpot_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct JackpotWithdrawEvent<phantom T0> has copy, drop {
        jackpot_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        accounting_balance: 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::accounting_balance::AccountingBalance,
    }

    public fun balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun accounting_balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::accounting_balance::value(&arg0.accounting_balance)
    }

    public(friend) fun accounting_add<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::accounting_balance::add(&mut arg0.accounting_balance, arg1);
    }

    public(friend) fun accounting_sub<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::accounting_balance::sub(&mut arg0.accounting_balance, arg1);
    }

    public fun create<T0>(arg0: &0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Jackpot<T0>{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<T0>(),
            accounting_balance : 0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::accounting_balance::zero(),
        };
        let v1 = JackpotCreatedEvent<T0>{jackpot_id: 0x2::object::id<Jackpot<T0>>(&v0)};
        0x2::event::emit<JackpotCreatedEvent<T0>>(v1);
        0x2::transfer::share_object<Jackpot<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Jackpot<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        accounting_add<T0>(arg0, v0);
        let v1 = JackpotDepositEvent<T0>{
            jackpot_id : 0x2::object::id<Jackpot<T0>>(arg0),
            amount     : v0,
            balance    : 0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1)),
        };
        0x2::event::emit<JackpotDepositEvent<T0>>(v1);
    }

    public fun withdraw<T0>(arg0: &mut Jackpot<T0>, arg1: &0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        accounting_sub<T0>(arg0, arg2);
        let v0 = JackpotWithdrawEvent<T0>{
            jackpot_id : 0x2::object::id<Jackpot<T0>>(arg0),
            amount     : arg2,
            balance    : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<JackpotWithdrawEvent<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    public fun withdraw_to<T0>(arg0: &mut Jackpot<T0>, arg1: &0xdbc73f566b02feef1f26c4c30f02ae33984ee27f31d095dcef75428460767c2b::admin::AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

