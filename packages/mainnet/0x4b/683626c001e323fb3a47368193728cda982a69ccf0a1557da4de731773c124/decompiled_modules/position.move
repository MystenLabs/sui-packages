module 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        lower: u32,
        width: u32,
        shares: vector<u256>,
        fee_x_checkpoints: vector<u256>,
        fee_y_checkpoints: vector<u256>,
        owed_x: u64,
        owed_y: u64,
    }

    struct PositionOpened has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        lower: u32,
        width: u32,
    }

    struct PositionClosed has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : Position {
        assert!(arg2 > 0 && arg2 <= 70, 1);
        let v0 = (arg2 as u64);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v0) {
            0x1::vector::push_back<u256>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = vector[];
        let v6 = 0;
        while (v6 < v0) {
            0x1::vector::push_back<u256>(&mut v5, 0);
            v6 = v6 + 1;
        };
        let v7 = Position{
            id                : 0x2::object::new(arg3),
            pool              : arg0,
            lower             : arg1,
            width             : arg2,
            shares            : v1,
            fee_x_checkpoints : v3,
            fee_y_checkpoints : v5,
            owed_x            : 0,
            owed_y            : 0,
        };
        let v8 = PositionOpened{
            position : 0x2::object::id<Position>(&v7),
            pool     : arg0,
            lower    : arg1,
            width    : arg2,
        };
        0x2::event::emit<PositionOpened>(v8);
        v7
    }

    public(friend) fun add_shares(arg0: &mut Position, arg1: u64, arg2: u256) {
        *0x1::vector::borrow_mut<u256>(&mut arg0.shares, arg1) = *0x1::vector::borrow<u256>(&arg0.shares, arg1) + arg2;
    }

    public(friend) fun destroy(arg0: Position) {
        if (arg0.owed_x == 0) {
            if (arg0.owed_y == 0) {
                let v0 = &arg0.shares;
                let v1 = 0;
                let v2;
                while (v1 < 0x1::vector::length<u256>(v0)) {
                    if (!(*0x1::vector::borrow<u256>(v0, v1) == 0)) {
                        v2 = false;
                        /* label 8 */
                        /* label 9 */
                        assert!(v2, 3);
                        let v3 = PositionClosed{
                            position : 0x2::object::id<Position>(&arg0),
                            pool     : arg0.pool,
                        };
                        0x2::event::emit<PositionClosed>(v3);
                        let Position {
                            id                : v4,
                            pool              : _,
                            lower             : _,
                            width             : _,
                            shares            : _,
                            fee_x_checkpoints : _,
                            fee_y_checkpoints : _,
                            owed_x            : _,
                            owed_y            : _,
                        } = arg0;
                        0x2::object::delete(v4);
                        return
                    };
                    v1 = v1 + 1;
                };
                v2 = true;
                /* goto 8 */
            } else {
                /* goto 9 */
            };
        } else {
            /* goto 9 */
        };
    }

    fun earned(arg0: u256, arg1: u256) : u64 {
        ((arg0 * arg1 >> 128) as u64)
    }

    public fun index(arg0: &Position, arg1: u32) : u64 {
        assert!(arg1 >= arg0.lower && arg1 - arg0.lower < arg0.width, 2);
        ((arg1 - arg0.lower) as u64)
    }

    public fun lower(arg0: &Position) : u32 {
        arg0.lower
    }

    public fun max_width() : u32 {
        70
    }

    public fun owed(arg0: &Position) : (u64, u64) {
        (arg0.owed_x, arg0.owed_y)
    }

    public fun pool(arg0: &Position) : 0x2::object::ID {
        arg0.pool
    }

    public(friend) fun remove_shares(arg0: &mut Position, arg1: u64, arg2: u256) {
        *0x1::vector::borrow_mut<u256>(&mut arg0.shares, arg1) = *0x1::vector::borrow<u256>(&arg0.shares, arg1) - arg2;
    }

    public(friend) fun settle(arg0: &mut Position, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = *0x1::vector::borrow<u256>(&arg0.shares, arg1);
        if (v0 > 0) {
            arg0.owed_x = arg0.owed_x + earned(v0, arg2 - *0x1::vector::borrow<u256>(&arg0.fee_x_checkpoints, arg1));
            arg0.owed_y = arg0.owed_y + earned(v0, arg3 - *0x1::vector::borrow<u256>(&arg0.fee_y_checkpoints, arg1));
        };
        *0x1::vector::borrow_mut<u256>(&mut arg0.fee_x_checkpoints, arg1) = arg2;
        *0x1::vector::borrow_mut<u256>(&mut arg0.fee_y_checkpoints, arg1) = arg3;
    }

    public fun share(arg0: &Position, arg1: u64) : u256 {
        *0x1::vector::borrow<u256>(&arg0.shares, arg1)
    }

    public fun shares(arg0: &Position) : vector<u256> {
        arg0.shares
    }

    public fun shares_at(arg0: &Position, arg1: u32) : u256 {
        *0x1::vector::borrow<u256>(&arg0.shares, index(arg0, arg1))
    }

    public(friend) fun take_owed(arg0: &mut Position) : (u64, u64) {
        arg0.owed_x = 0;
        arg0.owed_y = 0;
        (arg0.owed_x, arg0.owed_y)
    }

    public fun width(arg0: &Position) : u32 {
        arg0.width
    }

    // decompiled from Move bytecode v7
}

