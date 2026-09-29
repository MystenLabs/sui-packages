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

    fun expire(arg0: &mut Pool, arg1: address, arg2: u64) {
        let v0 = PosKey{
            player : arg1,
            locked : true,
        };
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v0);
        if (v1.weight <= weight_of(v1.amount, false) || arg2 < v1.locked_until) {
            return
        };
        settle_pos(v1, arg0.acc);
        let v2 = weight_of(v1.amount, false);
        arg0.total_weight = arg0.total_weight - v1.weight + v2;
        v1.weight = v2;
        let v3 = LockEnded{
            player : arg1,
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

    public(friend) fun poke(arg0: &mut Pool, arg1: address, arg2: &0x2::clock::Clock) {
        expire(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
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

    fun settle_pos(arg0: &mut Position, arg1: u256) {
        arg0.pending = arg0.pending + earned(arg0, arg1);
        arg0.snap = arg1;
    }

    public(friend) fun stake(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        expire(arg0, v1, v2);
        let v3 = PosKey{
            player : v1,
            locked : arg2,
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
        let v6 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v3);
        settle_pos(v6, v4);
        v6.amount = v6.amount + v0;
        if (arg2) {
            v6.locked_until = v2 + 604800000;
        };
        let v7 = weight_of(v6.amount, arg2);
        arg0.total_weight = arg0.total_weight - v6.weight + v7;
        v6.weight = v7;
        arg0.total_amount = arg0.total_amount + v0;
        0x2::balance::join<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.staked, 0x2::coin::into_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(arg1));
        let v8 = Staked{
            player       : v1,
            locked       : arg2,
            amount       : v0,
            total        : v6.amount,
            locked_until : v6.locked_until,
        };
        0x2::event::emit<Staked>(v8);
    }

    public(friend) fun totals(arg0: &Pool) : (u64, u128, u64, u64) {
        (arg0.total_amount, arg0.total_weight, arg0.paid_total, 0x2::balance::value<0x2::sui::SUI>(&arg0.rewards))
    }

    public(friend) fun unstake(arg0: &mut Pool, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS> {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        expire(arg0, v0, v1);
        let v2 = PosKey{
            player : v0,
            locked : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v2), 4);
        let v3 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v2);
        assert!(arg1 <= v3.amount, 2);
        assert!(!arg2 || v1 >= v3.locked_until, 3);
        settle_pos(v3, arg0.acc);
        v3.amount = v3.amount - arg1;
        let v4 = arg2 && v1 < v3.locked_until;
        let v5 = weight_of(v3.amount, v4);
        arg0.total_weight = arg0.total_weight - v3.weight + v5;
        v3.weight = v5;
        arg0.total_amount = arg0.total_amount - arg1;
        let v6 = Unstaked{
            player : v0,
            locked : arg2,
            amount : arg1,
            total  : v3.amount,
        };
        0x2::event::emit<Unstaked>(v6);
        0x2::coin::from_balance<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(0x2::balance::split<0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts::GTS>(&mut arg0.staked, arg1), arg4)
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

