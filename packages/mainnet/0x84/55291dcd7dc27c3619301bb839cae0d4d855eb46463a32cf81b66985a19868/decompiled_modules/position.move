module 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::position {
    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        tokens: 0x2::balance::Balance<T0>,
        lots: vector<Lot>,
        lock: 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::Lock,
    }

    struct Lot has copy, drop, store {
        amount: u64,
        entry_ms: u64,
    }

    public(friend) fun join<T0>(arg0: &mut Position<T0>, arg1: Position<T0>) {
        assert!(arg0.pool == arg1.pool && 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::same(&arg0.lock, &arg1.lock), 1);
        assert!(0x1::vector::length<Lot>(&arg0.lots) + 0x1::vector::length<Lot>(&arg1.lots) <= 64, 3);
        let Position {
            id     : v0,
            pool   : _,
            tokens : v2,
            lots   : v3,
            lock   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.tokens, v2);
        0x1::vector::append<Lot>(&mut arg0.lots, v3);
    }

    public(friend) fun split<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Position<T0> {
        assert!(arg1 > 0 && arg1 < 0x2::balance::value<T0>(&arg0.tokens), 2);
        let v0 = 0x1::vector::empty<Lot>();
        let v1 = 0;
        while (arg1 > 0) {
            let v2 = 0x1::vector::borrow_mut<Lot>(&mut arg0.lots, v1);
            let v3 = 0x1::u64::min(arg1, v2.amount);
            let v4 = Lot{
                amount   : v3,
                entry_ms : v2.entry_ms,
            };
            0x1::vector::push_back<Lot>(&mut v0, v4);
            v2.amount = v2.amount - v3;
            arg1 = arg1 - v3;
            v1 = v1 + 1;
        };
        let v5 = 0x1::vector::empty<Lot>();
        let v6 = arg0.lots;
        0x1::vector::reverse<Lot>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Lot>(&v6)) {
            let v8 = 0x1::vector::pop_back<Lot>(&mut v6);
            if (v8.amount > 0) {
                0x1::vector::push_back<Lot>(&mut v5, v8);
            };
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<Lot>(v6);
        arg0.lots = v5;
        Position<T0>{
            id     : 0x2::object::new(arg2),
            pool   : arg0.pool,
            tokens : 0x2::balance::split<T0>(&mut arg0.tokens, arg1),
            lots   : v0,
            lock   : arg0.lock,
        }
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = Lot{
            amount   : v0,
            entry_ms : arg2,
        };
        let v2 = 0x1::vector::empty<Lot>();
        0x1::vector::push_back<Lot>(&mut v2, v1);
        Position<T0>{
            id     : 0x2::object::new(arg3),
            pool   : arg0,
            tokens : arg1,
            lots   : v2,
            lock   : 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::flexible(),
        }
    }

    public(friend) fun upgrade<T0>(arg0: &mut Position<T0>, arg1: u8, arg2: u64, arg3: &0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::config::Params) {
        0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::upgrade(&mut arg0.lock, arg1, arg2, arg3);
    }

    public fun age_ms<T0>(arg0: &Position<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lot>(v1)) {
            let v3 = 0x1::vector::borrow<Lot>(v1, v2);
            v0 = v0 + (v3.amount as u256) * ((arg1 - v3.entry_ms) as u256);
            v2 = v2 + 1;
        };
        ((v0 / (0x2::balance::value<T0>(&arg0.tokens) as u256)) as u64)
    }

    public fun amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public(friend) fun clear_lock<T0>(arg0: &mut Position<T0>) {
        0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::clear(&mut arg0.lock);
    }

    public(friend) fun destroy<T0>(arg0: Position<T0>, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        assert!(arg0.pool == arg1, 1);
        let Position {
            id     : v0,
            pool   : _,
            tokens : v2,
            lots   : _,
            lock   : _,
        } = arg0;
        0x2::object::delete(v0);
        v2
    }

    public(friend) fun fee<T0>(arg0: &Position<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lot>(v1)) {
            let v3 = 0x1::vector::borrow<Lot>(v1, v2);
            v0 = v0 + (v3.amount as u256) * (0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::math::decay(arg1 - v3.entry_ms, arg2, arg3, arg4) as u256);
            v2 = v2 + 1;
        };
        (((v0 + 9999) / 10000) as u64)
    }

    public fun lock<T0>(arg0: &Position<T0>) : &0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::locks::Lock {
        &arg0.lock
    }

    public(friend) fun lot_amount(arg0: &Lot) : u64 {
        arg0.amount
    }

    public(friend) fun lot_entry(arg0: &Lot) : u64 {
        arg0.entry_ms
    }

    public(friend) fun lots<T0>(arg0: &Position<T0>) : vector<Lot> {
        arg0.lots
    }

    public fun pool_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.pool
    }

    // decompiled from Move bytecode v7
}

