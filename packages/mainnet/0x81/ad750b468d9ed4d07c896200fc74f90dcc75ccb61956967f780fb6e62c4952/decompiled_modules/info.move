module 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info {
    struct Info has drop, store {
        volume_base: u128,
        base: CurrencyInfo,
        quote: CurrencyInfo,
    }

    struct CurrencyInfo has drop, store {
        balance: u64,
        deposited: u128,
        withdrawn: u128,
    }

    public(friend) fun empty() : Info {
        let v0 = CurrencyInfo{
            balance   : 0,
            deposited : 0,
            withdrawn : 0,
        };
        let v1 = CurrencyInfo{
            balance   : 0,
            deposited : 0,
            withdrawn : 0,
        };
        Info{
            volume_base : 0,
            base        : v0,
            quote       : v1,
        }
    }

    public fun base_balance(arg0: &Info) : u64 {
        arg0.base.balance
    }

    public fun base_deposited(arg0: &Info) : u128 {
        arg0.base.deposited
    }

    public fun base_withdrawn(arg0: &Info) : u128 {
        arg0.base.withdrawn
    }

    public fun quote_balance(arg0: &Info) : u64 {
        arg0.quote.balance
    }

    public fun quote_deposited(arg0: &Info) : u128 {
        arg0.quote.deposited
    }

    public fun quote_withdrawn(arg0: &Info) : u128 {
        arg0.quote.withdrawn
    }

    public(friend) fun record_base_deposit(arg0: &mut Info, arg1: u64) {
        arg0.base.deposited = 0x1::u128::saturating_add(arg0.base.deposited, (arg1 as u128));
        arg0.base.balance = 0x1::u64::saturating_add(arg0.base.balance, arg1);
    }

    public(friend) fun record_base_withdraw(arg0: &mut Info, arg1: u64) {
        arg0.base.withdrawn = 0x1::u128::saturating_add(arg0.base.withdrawn, (arg1 as u128));
        arg0.base.balance = 0x1::u64::saturating_sub(arg0.base.balance, arg1);
    }

    public(friend) fun record_quote_deposit(arg0: &mut Info, arg1: u64) {
        arg0.quote.deposited = 0x1::u128::saturating_add(arg0.quote.deposited, (arg1 as u128));
        arg0.quote.balance = 0x1::u64::saturating_add(arg0.quote.balance, arg1);
    }

    public(friend) fun record_quote_withdraw(arg0: &mut Info, arg1: u64) {
        arg0.quote.withdrawn = 0x1::u128::saturating_add(arg0.quote.withdrawn, (arg1 as u128));
        arg0.quote.balance = 0x1::u64::saturating_sub(arg0.quote.balance, arg1);
    }

    public(friend) fun update(arg0: &mut Info, arg1: u128, arg2: u64, arg3: u64) {
        arg0.volume_base = arg1;
        arg0.base.balance = arg3;
        arg0.quote.balance = arg2;
    }

    public fun volume_base(arg0: &Info) : u128 {
        arg0.volume_base
    }

    // decompiled from Move bytecode v7
}

