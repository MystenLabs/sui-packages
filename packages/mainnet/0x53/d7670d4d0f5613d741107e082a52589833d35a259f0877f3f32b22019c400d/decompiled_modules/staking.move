module 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::staking {
    struct Position has drop, store {
        amount: u64,
        weight: u128,
        locked_until: u64,
        snap: u256,
        pending: u64,
    }

    struct PosKey has copy, drop, store {
        player: address,
        locked: bool,
    }

    struct Pool has store {
        staked: 0x2::balance::Balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>,
        rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        total_amount: u64,
        total_weight: u128,
        acc: u256,
        paid_total: u64,
        positions: 0x2::table::Table<PosKey, Position>,
    }

    struct Schedule has store {
        warm: 0x2::table::Table<PosKey, Warm>,
        warm_q: 0x2::table::Table<u64, Due>,
        warm_head: u64,
        warm_tail: u64,
        lock_q: 0x2::table::Table<u64, Due>,
        lock_head: u64,
        lock_tail: u64,
    }

    struct Warm has drop, store {
        amount: u64,
        at: u64,
    }

    struct Due has drop, store {
        player: address,
        locked: bool,
        at: u64,
    }

    struct WarmedUp has copy, drop {
        player: address,
        locked: bool,
        amount: u64,
    }

    struct Staked has copy, drop {
        player: address,
        locked: bool,
        amount: u64,
        total: u64,
        locked_until: u64,
    }

    struct Unstaked has copy, drop {
        player: address,
        locked: bool,
        amount: u64,
        total: u64,
    }

    struct YieldClaimed has copy, drop {
        player: address,
        sui: u64,
    }

    struct LockEnded has copy, drop {
        player: address,
        amount: u64,
    }

    struct StakeRewarded has copy, drop {
        round_id: u64,
        amount: u64,
        total_weight: u128,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            staked       : 0x2::balance::zero<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(),
            rewards      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_amount : 0,
            total_weight : 0,
            acc          : 0,
            paid_total   : 0,
            positions    : 0x2::table::new<PosKey, Position>(arg0),
        }
    }

    public(friend) fun claim(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0;
        let v2 = PosKey{
            player : v0,
            locked : false,
        };
        let v3 = PosKey{
            player : v0,
            locked : true,
        };
        let v4 = 0x1::vector::empty<PosKey>();
        let v5 = &mut v4;
        0x1::vector::push_back<PosKey>(v5, v2);
        0x1::vector::push_back<PosKey>(v5, v3);
        let v6 = 0;
        while (v6 < 2) {
            let v7 = *0x1::vector::borrow<PosKey>(&v4, v6);
            if (0x2::table::contains<PosKey, Position>(&arg0.positions, v7)) {
                let v8 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v7);
                settle_pos(v8, arg0.acc);
                v1 = v1 + v8.pending;
                v8.pending = 0;
                if (v8.amount == 0) {
                    0x2::table::remove<PosKey, Position>(&mut arg0.positions, v7);
                };
            };
            v6 = v6 + 1;
        };
        if (v1 > 0) {
            let v9 = YieldClaimed{
                player : v0,
                sui    : v1,
            };
            0x2::event::emit<YieldClaimed>(v9);
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rewards, v1), arg1)
    }

    fun earned(arg0: &Position, arg1: u256) : u64 {
        (((arg0.weight as u256) * (arg1 - arg0.snap) / 1000000000000000000) as u64)
    }

    public(friend) fun enqueue_lock(arg0: &Pool, arg1: &mut Schedule, arg2: address) : bool {
        let v0 = PosKey{
            player : arg2,
            locked : true,
        };
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<PosKey, Position>(&arg0.positions, v0);
        if (v1.weight <= weight_of(v1.amount - warming(arg1, v0), false)) {
            return false
        };
        if (arg1.lock_head < arg1.lock_tail && 0x2::table::borrow<u64, Due>(&arg1.lock_q, arg1.lock_tail - 1).at > v1.locked_until) {
            return false
        };
        let v2 = Due{
            player : arg2,
            locked : true,
            at     : v1.locked_until,
        };
        0x2::table::add<u64, Due>(&mut arg1.lock_q, arg1.lock_tail, v2);
        arg1.lock_tail = arg1.lock_tail + 1;
        true
    }

    fun expire(arg0: &mut Pool, arg1: &Schedule, arg2: address, arg3: u64) {
        let v0 = PosKey{
            player : arg2,
            locked : true,
        };
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v0);
        let v2 = v1.amount - warming(arg1, v0);
        if (v1.weight <= weight_of(v2, false) || arg3 < v1.locked_until) {
            return
        };
        settle_pos(v1, arg0.acc);
        set_weight(arg0, v0, v2, false);
        let v3 = LockEnded{
            player : arg2,
            amount : v1.amount,
        };
        0x2::event::emit<LockEnded>(v3);
    }

    public(friend) fun has_stakers(arg0: &Pool) : bool {
        arg0.total_weight > 0
    }

    public fun lock_ms() : u64 {
        604800000
    }

    public(friend) fun new_schedule(arg0: &mut 0x2::tx_context::TxContext) : Schedule {
        Schedule{
            warm      : 0x2::table::new<PosKey, Warm>(arg0),
            warm_q    : 0x2::table::new<u64, Due>(arg0),
            warm_head : 0,
            warm_tail : 0,
            lock_q    : 0x2::table::new<u64, Due>(arg0),
            lock_head : 0,
            lock_tail : 0,
        }
    }

    public(friend) fun next_due(arg0: &Schedule, arg1: u64) : (bool, address) {
        if (arg0.warm_head < arg0.warm_tail) {
            let v0 = 0x2::table::borrow<u64, Due>(&arg0.warm_q, arg0.warm_head);
            if (v0.at <= arg1) {
                return (true, v0.player)
            };
        };
        if (arg0.lock_head < arg0.lock_tail) {
            let v1 = 0x2::table::borrow<u64, Due>(&arg0.lock_q, arg0.lock_head);
            if (v1.at <= arg1) {
                return (true, v1.player)
            };
        };
        (false, @0x0)
    }

    public(friend) fun poke(arg0: &mut Pool, arg1: &mut Schedule, arg2: address, arg3: &0x2::clock::Clock) {
        refresh(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun position(arg0: &Pool, arg1: address, arg2: bool) : (u64, u64, u64) {
        let v0 = PosKey{
            player : arg1,
            locked : arg2,
        };
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            return (0, 0, 0)
        };
        let v1 = 0x2::table::borrow<PosKey, Position>(&arg0.positions, v0);
        (v1.amount, v1.locked_until, v1.pending + earned(v1, arg0.acc))
    }

    public(friend) fun queued(arg0: &Schedule) : (u64, u64) {
        (arg0.warm_tail - arg0.warm_head, arg0.lock_tail - arg0.lock_head)
    }

    fun refresh(arg0: &mut Pool, arg1: &mut Schedule, arg2: address, arg3: u64) {
        let v0 = PosKey{
            player : arg2,
            locked : false,
        };
        warm_up(arg0, arg1, v0, arg3);
        let v1 = PosKey{
            player : arg2,
            locked : true,
        };
        warm_up(arg0, arg1, v1, arg3);
        expire(arg0, arg1, arg2, arg3);
    }

    public(friend) fun reward(arg0: &mut Pool, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        arg0.acc = arg0.acc + (v0 as u256) * 1000000000000000000 / (arg0.total_weight as u256);
        arg0.paid_total = arg0.paid_total + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.rewards, arg2);
        let v1 = StakeRewarded{
            round_id     : arg1,
            amount       : v0,
            total_weight : arg0.total_weight,
        };
        0x2::event::emit<StakeRewarded>(v1);
    }

    public(friend) fun run_due(arg0: &mut Pool, arg1: &mut Schedule, arg2: u64) {
        if (arg1.warm_head < arg1.warm_tail && 0x2::table::borrow<u64, Due>(&arg1.warm_q, arg1.warm_head).at <= arg2) {
            let Due {
                player : v0,
                locked : _,
                at     : _,
            } = 0x2::table::remove<u64, Due>(&mut arg1.warm_q, arg1.warm_head);
            arg1.warm_head = arg1.warm_head + 1;
            refresh(arg0, arg1, v0, arg2);
        } else if (arg1.lock_head < arg1.lock_tail && 0x2::table::borrow<u64, Due>(&arg1.lock_q, arg1.lock_head).at <= arg2) {
            let Due {
                player : v3,
                locked : _,
                at     : _,
            } = 0x2::table::remove<u64, Due>(&mut arg1.lock_q, arg1.lock_head);
            arg1.lock_head = arg1.lock_head + 1;
            refresh(arg0, arg1, v3, arg2);
        };
    }

    fun set_weight(arg0: &mut Pool, arg1: PosKey, arg2: u64, arg3: bool) {
        let v0 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, arg1);
        let v1 = weight_of(arg2, arg3);
        arg0.total_weight = arg0.total_weight - v0.weight + v1;
        v0.weight = v1;
    }

    fun settle_pos(arg0: &mut Position, arg1: u256) {
        arg0.pending = arg0.pending + earned(arg0, arg1);
        arg0.snap = arg1;
    }

    public(friend) fun stake(arg0: &mut Pool, arg1: &mut Schedule, arg2: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        refresh(arg0, arg1, v1, v2);
        let v3 = PosKey{
            player : v1,
            locked : arg3,
        };
        let v4 = arg0.acc;
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v3)) {
            let v5 = Position{
                amount       : 0,
                weight       : 0,
                locked_until : 0,
                snap         : v4,
                pending      : 0,
            };
            0x2::table::add<PosKey, Position>(&mut arg0.positions, v3, v5);
        };
        let v6 = v2 + 3600000;
        if (0x2::table::contains<PosKey, Warm>(&arg1.warm, v3)) {
            let v7 = 0x2::table::borrow_mut<PosKey, Warm>(&mut arg1.warm, v3);
            v7.amount = v7.amount + v0;
            v7.at = v6;
        } else {
            let v8 = Warm{
                amount : v0,
                at     : v6,
            };
            0x2::table::add<PosKey, Warm>(&mut arg1.warm, v3, v8);
        };
        let v9 = Due{
            player : v1,
            locked : arg3,
            at     : v6,
        };
        0x2::table::add<u64, Due>(&mut arg1.warm_q, arg1.warm_tail, v9);
        arg1.warm_tail = arg1.warm_tail + 1;
        let v10 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v3);
        settle_pos(v10, v4);
        v10.amount = v10.amount + v0;
        if (arg3) {
            v10.locked_until = v2 + 604800000;
        };
        let v11 = v10.amount;
        let v12 = v10.locked_until;
        if (arg3) {
            let v13 = Due{
                player : v1,
                locked : true,
                at     : v12,
            };
            0x2::table::add<u64, Due>(&mut arg1.lock_q, arg1.lock_tail, v13);
            arg1.lock_tail = arg1.lock_tail + 1;
        };
        set_weight(arg0, v3, v11 - warming(arg1, v3), arg3);
        arg0.total_amount = arg0.total_amount + v0;
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.staked, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg2));
        let v14 = Staked{
            player       : v1,
            locked       : arg3,
            amount       : v0,
            total        : v11,
            locked_until : v12,
        };
        0x2::event::emit<Staked>(v14);
    }

    public(friend) fun total_weight(arg0: &Pool) : u128 {
        arg0.total_weight
    }

    public(friend) fun totals(arg0: &Pool) : (u64, u128, u64, u64) {
        (arg0.total_amount, arg0.total_weight, arg0.paid_total, 0x2::balance::value<0x2::sui::SUI>(&arg0.rewards))
    }

    public(friend) fun unstake(arg0: &mut Pool, arg1: &mut Schedule, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        refresh(arg0, arg1, v0, v1);
        let v2 = PosKey{
            player : v0,
            locked : arg3,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v2), 4);
        let v3 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v2);
        assert!(arg2 <= v3.amount, 2);
        assert!(!arg3 || v1 >= v3.locked_until, 3);
        settle_pos(v3, arg0.acc);
        v3.amount = v3.amount - arg2;
        let v4 = v3.amount;
        let v5 = arg3 && v1 < v3.locked_until;
        let v6 = warming(arg1, v2);
        let v7 = if (v6 > arg2) {
            v6 - arg2
        } else {
            0
        };
        if (v6 > 0) {
            if (v7 == 0) {
                0x2::table::remove<PosKey, Warm>(&mut arg1.warm, v2);
            } else {
                0x2::table::borrow_mut<PosKey, Warm>(&mut arg1.warm, v2).amount = v7;
            };
        };
        set_weight(arg0, v2, v4 - v7, v5);
        arg0.total_amount = arg0.total_amount - arg2;
        let v8 = Unstaked{
            player : v0,
            locked : arg3,
            amount : arg2,
            total  : v4,
        };
        0x2::event::emit<Unstaked>(v8);
        0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.staked, arg2), arg5)
    }

    public fun warm_ms() : u64 {
        3600000
    }

    fun warm_up(arg0: &mut Pool, arg1: &mut Schedule, arg2: PosKey, arg3: u64) {
        if (!0x2::table::contains<PosKey, Warm>(&arg1.warm, arg2) || 0x2::table::borrow<PosKey, Warm>(&arg1.warm, arg2).at > arg3) {
            return
        };
        let Warm {
            amount : v0,
            at     : _,
        } = 0x2::table::remove<PosKey, Warm>(&mut arg1.warm, arg2);
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, arg2)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, arg2);
        settle_pos(v2, arg0.acc);
        let v3 = arg2.locked && arg3 < v2.locked_until;
        set_weight(arg0, arg2, v2.amount, v3);
        let v4 = WarmedUp{
            player : arg2.player,
            locked : arg2.locked,
            amount : v0,
        };
        0x2::event::emit<WarmedUp>(v4);
    }

    fun warming(arg0: &Schedule, arg1: PosKey) : u64 {
        if (0x2::table::contains<PosKey, Warm>(&arg0.warm, arg1)) {
            0x2::table::borrow<PosKey, Warm>(&arg0.warm, arg1).amount
        } else {
            0
        }
    }

    public(friend) fun warming_of(arg0: &Schedule, arg1: address, arg2: bool) : (u64, u64) {
        let v0 = PosKey{
            player : arg1,
            locked : arg2,
        };
        if (!0x2::table::contains<PosKey, Warm>(&arg0.warm, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<PosKey, Warm>(&arg0.warm, v0);
        (v1.amount, v1.at)
    }

    public(friend) fun weight(arg0: &Pool, arg1: address, arg2: bool) : u128 {
        let v0 = PosKey{
            player : arg1,
            locked : arg2,
        };
        if (0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            0x2::table::borrow<PosKey, Position>(&arg0.positions, v0).weight
        } else {
            0
        }
    }

    fun weight_of(arg0: u64, arg1: bool) : u128 {
        let v0 = if (arg1) {
            15
        } else {
            10
        };
        (arg0 as u128) * v0
    }

    // decompiled from Move bytecode v7
}

