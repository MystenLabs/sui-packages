module 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool_idx: u64,
        pool_id: 0x2::object::ID,
        lp_locked_amount: u64,
        xflx_locked_amount: u64,
        point_history: vector<0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point>,
        point_change: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point,
        acc_pending_rewards: u64,
        lock_duration_ms: u64,
        ended_at_ms: u64,
    }

    struct PositionCreated has copy, drop {
        id: 0x2::object::ID,
        pool_idx: u64,
        pool_id: 0x2::object::ID,
    }

    struct PositionIncreased has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct PositionDecreased has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct PositionLocked has copy, drop {
        id: 0x2::object::ID,
        lock_duration_ms: u64,
        ended_at_ms: u64,
        sender: address,
    }

    struct PositionBoosted has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct PositionUnboosted has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public fun new(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = Position{
            id                  : 0x2::object::new(arg3),
            pool_idx            : arg0,
            pool_id             : arg1,
            lp_locked_amount    : 0,
            xflx_locked_amount  : 0,
            point_history       : 0x1::vector::singleton<0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point>(0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::new(arg2, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::zero())),
            point_change        : 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::new(arg2, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::zero()),
            acc_pending_rewards : 0,
            lock_duration_ms    : 0,
            ended_at_ms         : 0,
        };
        let v1 = PositionCreated{
            id       : 0x2::object::id<Position>(&v0),
            pool_idx : arg0,
            pool_id  : arg1,
        };
        0x2::event::emit<PositionCreated>(v1);
        v0
    }

    public(friend) fun add_point(arg0: &mut Position, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point) {
        0x1::vector::push_back<0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point>(&mut arg0.point_history, arg1);
    }

    public(friend) fun decrease_last_checkpoint(arg0: &mut Position, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128) {
        0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::decrease(0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::last_checkpoint_mut(&mut arg0.point_history), arg1);
    }

    public(friend) fun decrease_lp_locked(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.lp_locked_amount >= arg1, 1);
        arg0.lp_locked_amount = arg0.lp_locked_amount - arg1;
        let v0 = PositionDecreased{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionDecreased>(v0);
    }

    public(friend) fun decrease_pending_rewards(arg0: &mut Position, arg1: u64) {
        assert!(arg0.acc_pending_rewards >= arg1, 3);
        arg0.acc_pending_rewards = arg0.acc_pending_rewards - arg1;
    }

    public(friend) fun decrease_xflx_locked(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.xflx_locked_amount >= arg1, 2);
        arg0.xflx_locked_amount = arg0.xflx_locked_amount - arg1;
        let v0 = PositionUnboosted{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionUnboosted>(v0);
    }

    public fun ended_at(arg0: &Position) : u64 {
        arg0.ended_at_ms
    }

    public(friend) fun increase_last_checkpoint(arg0: &mut Position, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128) {
        0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::increase(0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::last_checkpoint_mut(&mut arg0.point_history), arg1);
    }

    public(friend) fun increase_lp_locked(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 18446744073709551615 - arg0.lp_locked_amount, 0);
        arg0.lp_locked_amount = arg0.lp_locked_amount + arg1;
        let v0 = PositionIncreased{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionIncreased>(v0);
    }

    public(friend) fun increase_pending_rewards(arg0: &mut Position, arg1: u64) {
        assert!(arg1 < 18446744073709551615 - arg0.acc_pending_rewards, 0);
        arg0.acc_pending_rewards = arg0.acc_pending_rewards + arg1;
    }

    public(friend) fun increase_xflx_locked(arg0: &mut Position, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 18446744073709551615 - arg0.xflx_locked_amount, 0);
        arg0.xflx_locked_amount = arg0.xflx_locked_amount + arg1;
        let v0 = PositionBoosted{
            id     : 0x2::object::id<Position>(arg0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionBoosted>(v0);
    }

    public(friend) fun lock(arg0: &0x2::clock::Clock, arg1: &mut Position, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::clock::timestamp_ms(arg0) < arg2) {
            arg2
        } else {
            0x2::clock::timestamp_ms(arg0)
        };
        assert!(arg3 < 18446744073709551615 - v0, 0);
        arg1.lock_duration_ms = arg3;
        arg1.ended_at_ms = v0 + arg3;
        let v1 = PositionLocked{
            id               : 0x2::object::id<Position>(arg1),
            lock_duration_ms : arg3,
            ended_at_ms      : arg1.ended_at_ms,
            sender           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PositionLocked>(v1);
    }

    public fun lock_duration(arg0: &Position) : u64 {
        arg0.lock_duration_ms
    }

    public fun lp_locked_amount(arg0: &Position) : u64 {
        arg0.lp_locked_amount
    }

    public fun pending_rewards(arg0: &Position) : u64 {
        arg0.acc_pending_rewards
    }

    public fun point_change(arg0: &Position) : &0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point {
        &arg0.point_change
    }

    public fun point_history(arg0: &Position) : &vector<0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point> {
        &arg0.point_history
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_idx(arg0: &Position) : u64 {
        arg0.pool_idx
    }

    public(friend) fun set_point_change(arg0: &mut Position, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point::Point) {
        arg0.point_change = arg1;
    }

    public fun xflx_locked_amount(arg0: &Position) : u64 {
        arg0.xflx_locked_amount
    }

    // decompiled from Move bytecode v6
}

