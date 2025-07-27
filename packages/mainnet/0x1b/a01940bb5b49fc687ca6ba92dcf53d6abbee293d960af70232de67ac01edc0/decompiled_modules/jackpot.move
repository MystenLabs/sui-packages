module 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::jackpot {
    struct JackpotCreatedEvent<phantom T0> has copy, drop {
        jackpot_id: 0x2::object::ID,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        accounting_balance: 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance::AccountingBalance,
        go_jackpot: bool,
    }

    public fun accounting_balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance::value(&arg0.accounting_balance)
    }

    public(friend) fun accounting_add<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        if (arg0.go_jackpot) {
            0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance::add(&mut arg0.accounting_balance, arg1);
        };
    }

    public(friend) fun accounting_sub<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance::sub(&mut arg0.accounting_balance, arg1);
    }

    public fun add_accounting_balance<T0>(arg0: &mut Jackpot<T0>, arg1: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::admin::AdminCap, arg2: u64) {
        accounting_add<T0>(arg0, arg2);
    }

    public fun create<T0>(arg0: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Jackpot<T0>{
            id                 : 0x2::object::new(arg1),
            accounting_balance : 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance::zero(),
            go_jackpot         : false,
        };
        let v1 = JackpotCreatedEvent<T0>{jackpot_id: 0x2::object::id<Jackpot<T0>>(&v0)};
        0x2::event::emit<JackpotCreatedEvent<T0>>(v1);
        0x2::transfer::share_object<Jackpot<T0>>(v0);
    }

    public fun go_jackpot<T0>(arg0: &Jackpot<T0>) : bool {
        arg0.go_jackpot
    }

    public fun set_go_jackpot<T0>(arg0: &mut Jackpot<T0>, arg1: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::admin::AdminCap, arg2: bool) {
        arg0.go_jackpot = arg2;
    }

    public fun sub_accounting_balance<T0>(arg0: &mut Jackpot<T0>, arg1: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::admin::AdminCap, arg2: u64) {
        accounting_sub<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

