module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome: u8,
        shares: u64,
    }

    public fun burn(arg0: Position) : u64 {
        let Position {
            id        : v0,
            market_id : _,
            outcome   : _,
            shares    : v3,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public fun keep(arg0: Position, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Position>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun market_id(arg0: &Position) : 0x2::object::ID {
        arg0.market_id
    }

    public fun merge(arg0: &mut Position, arg1: Position) {
        assert!(arg0.market_id == arg1.market_id, 2);
        assert!(arg0.outcome == arg1.outcome, 1);
        let Position {
            id        : v0,
            market_id : _,
            outcome   : _,
            shares    : v3,
        } = arg1;
        0x2::object::delete(v0);
        arg0.shares = arg0.shares + v3;
    }

    public fun mint(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id        : 0x2::object::new(arg3),
            market_id : arg0,
            outcome   : arg1,
            shares    : arg2,
        }
    }

    public fun outcome(arg0: &Position) : u8 {
        arg0.outcome
    }

    public fun shares(arg0: &Position) : u64 {
        arg0.shares
    }

    public fun split(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Position {
        assert!(arg0.shares >= arg1, 0);
        arg0.shares = arg0.shares - arg1;
        Position{
            id        : 0x2::object::new(arg2),
            market_id : arg0.market_id,
            outcome   : arg0.outcome,
            shares    : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

