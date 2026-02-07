module 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        side: bool,
        amount: u64,
        bettor: address,
        created_at_ms: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id            : 0x2::object::new(arg5),
            market_id     : arg0,
            side          : arg1,
            amount        : arg2,
            bettor        : arg3,
            created_at_ms : arg4,
        }
    }

    public(friend) fun amount(arg0: &Position) : u64 {
        arg0.amount
    }

    public(friend) fun bettor(arg0: &Position) : address {
        arg0.bettor
    }

    public(friend) fun destroy(arg0: Position) : (0x2::object::ID, bool, u64, address) {
        let Position {
            id            : v0,
            market_id     : v1,
            side          : v2,
            amount        : v3,
            bettor        : v4,
            created_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4)
    }

    public(friend) fun market_id(arg0: &Position) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun side(arg0: &Position) : bool {
        arg0.side
    }

    public(friend) fun uid(arg0: &Position) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}

