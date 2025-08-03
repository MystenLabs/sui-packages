module 0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::jackpot {
    struct JackpotCreatedEvent<phantom T0> has copy, drop {
        jackpot_id: 0x2::object::ID,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        accounting_balance: 0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::accounting_balance::AccountingBalance,
        go_jackpot: bool,
        jackpot_hit: bool,
    }

    public fun accounting_balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::accounting_balance::value(&arg0.accounting_balance)
    }

    public(friend) fun accounting_add<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        if (arg0.go_jackpot) {
            0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::accounting_balance::add(&mut arg0.accounting_balance, arg1);
        };
    }

    public(friend) fun accounting_sub<T0>(arg0: &mut Jackpot<T0>, arg1: u64) {
        0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::accounting_balance::sub(&mut arg0.accounting_balance, arg1);
    }

    public fun add_accounting_balance<T0>(arg0: &mut Jackpot<T0>, arg1: &0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::admin::AdminCap, arg2: u64) {
        accounting_add<T0>(arg0, arg2);
    }

    public fun assert_jackpot_not_hit<T0>(arg0: &Jackpot<T0>) {
        if (arg0.jackpot_hit) {
            err_jackpot_hit();
        };
    }

    public fun create<T0>(arg0: &0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Jackpot<T0>{
            id                 : 0x2::object::new(arg1),
            accounting_balance : 0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::accounting_balance::zero(),
            go_jackpot         : false,
            jackpot_hit        : false,
        };
        let v1 = JackpotCreatedEvent<T0>{jackpot_id: 0x2::object::id<Jackpot<T0>>(&v0)};
        0x2::event::emit<JackpotCreatedEvent<T0>>(v1);
        0x2::transfer::share_object<Jackpot<T0>>(v0);
    }

    fun err_jackpot_hit() {
        abort 100
    }

    public fun go_jackpot<T0>(arg0: &Jackpot<T0>) : bool {
        arg0.go_jackpot
    }

    public fun reset_jackpot_hit<T0>(arg0: &mut Jackpot<T0>, arg1: &0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::admin::AdminCap) {
        arg0.jackpot_hit = false;
    }

    public fun set_go_jackpot<T0>(arg0: &mut Jackpot<T0>, arg1: &0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::admin::AdminCap, arg2: bool) {
        arg0.go_jackpot = arg2;
    }

    public(friend) fun set_jackpot_hit<T0>(arg0: &mut Jackpot<T0>) {
        arg0.jackpot_hit = true;
    }

    public fun sub_accounting_balance<T0>(arg0: &mut Jackpot<T0>, arg1: &0x4c431b5a602b4c98a8142a588c807afcae6964b228b2bdba5626eb2869440de2::admin::AdminCap, arg2: u64) {
        accounting_sub<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

