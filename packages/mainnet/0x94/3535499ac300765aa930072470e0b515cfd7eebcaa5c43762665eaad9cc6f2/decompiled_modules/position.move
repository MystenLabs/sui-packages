module 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool_idx: u64,
        amount: u64,
        token_reward_debt: u256,
        flx_reward_debt: u256,
    }

    struct PositionCreated has copy, drop {
        id: 0x2::object::ID,
        pool_idx: u64,
        user: address,
    }

    struct PositionIncreased has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        user: address,
    }

    struct PositionDecreased has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        user: address,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = Position{
            id                : 0x2::object::new(arg1),
            pool_idx          : arg0,
            amount            : 0,
            token_reward_debt : 0,
            flx_reward_debt   : 0,
        };
        let v1 = PositionCreated{
            id       : 0x2::object::id<Position>(&v0),
            pool_idx : arg0,
            user     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PositionCreated>(v1);
        v0
    }

    public(friend) fun change_flx_reward_debt(arg0: &mut Position, arg1: u256) {
        arg0.flx_reward_debt = arg1;
    }

    public(friend) fun change_token_reward_debt(arg0: &mut Position, arg1: u256) {
        arg0.token_reward_debt = arg1;
    }

    public(friend) fun decrease(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.amount >= arg1, 0);
        arg0.amount = arg0.amount - arg1;
        let v0 = PositionDecreased{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            user   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionDecreased>(v0);
    }

    public fun flx_reward_debt(arg0: &Position) : u256 {
        arg0.flx_reward_debt
    }

    public(friend) fun increase(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 18446744073709551615 - arg0.amount, 0);
        arg0.amount = arg0.amount + arg1;
        let v0 = PositionIncreased{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            user   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionIncreased>(v0);
    }

    public fun pool_idx(arg0: &Position) : u64 {
        arg0.pool_idx
    }

    public fun token_reward_debt(arg0: &Position) : u256 {
        arg0.token_reward_debt
    }

    public fun value(arg0: &Position) : u64 {
        arg0.amount
    }

    // decompiled from Move bytecode v6
}

