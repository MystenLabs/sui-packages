module 0x27661592b857dbba729eb332eeec123ce31dd1677514096b6f556a777319f147::balance_keeper {
    struct BalanceKeeper has key {
        id: 0x2::object::UID,
    }

    struct MinerBalance has store, key {
        id: 0x2::object::UID,
        balance: u64,
    }

    struct BALANCE_KEEPER has drop {
        dummy_field: bool,
    }

    public(friend) fun deposit(arg0: &mut BalanceKeeper, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, MinerBalance>(&mut arg0.id, v0);
            v1.balance = v1.balance + arg1;
        } else {
            let v2 = MinerBalance{
                id      : 0x2::object::new(arg2),
                balance : arg1,
            };
            0x2::dynamic_field::add<address, MinerBalance>(&mut arg0.id, v0, v2);
        };
    }

    fun init(arg0: BALANCE_KEEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceKeeper{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<BalanceKeeper>(v0);
    }

    public(friend) fun withdraw_all(arg0: &mut BalanceKeeper, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, MinerBalance>(&mut arg0.id, v0);
            v1.balance = 0;
            return v1.balance
        };
        0
    }

    // decompiled from Move bytecode v6
}

