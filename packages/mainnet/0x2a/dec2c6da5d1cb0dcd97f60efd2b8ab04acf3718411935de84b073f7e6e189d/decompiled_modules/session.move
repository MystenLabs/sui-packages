module 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session {
    struct Session {
        principal: u64,
        min_profit: u64,
        hops: u8,
        quoted: vector<u64>,
        armed: bool,
        decided: bool,
        vault: 0x2::bag::Bag,
    }

    public fun armed(arg0: &Session) : bool {
        arg0.armed
    }

    public fun assert_decided(arg0: &Session) {
        assert!(arg0.decided, 4);
    }

    public fun decide(arg0: &mut Session) {
        assert!(!arg0.decided, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.quoted)) {
            assert!(*0x1::vector::borrow<u64>(&arg0.quoted, v0) != 0, 3);
            v0 = v0 + 1;
        };
        arg0.armed = *0x1::vector::borrow<u64>(&arg0.quoted, 0x1::vector::length<u64>(&arg0.quoted) - 1) >= arg0.principal + arg0.min_profit;
        arg0.decided = true;
    }

    public fun decided(arg0: &Session) : bool {
        arg0.decided
    }

    public fun expected_out(arg0: &Session) : u64 {
        *0x1::vector::borrow<u64>(&arg0.quoted, 0x1::vector::length<u64>(&arg0.quoted) - 1)
    }

    public fun finish<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            principal  : _,
            min_profit : _,
            hops       : v2,
            quoted     : _,
            armed      : _,
            decided    : _,
            vault      : v6,
        } = arg0;
        let v7 = v6;
        let v8 = if (0x2::bag::contains<u8>(&v7, v2)) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v7, v2), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        };
        0x2::bag::destroy_empty(v7);
        v8
    }

    public fun has_slot(arg0: &Session, arg1: u8) : bool {
        0x2::bag::contains<u8>(&arg0.vault, arg1)
    }

    public fun hops(arg0: &Session) : u8 {
        arg0.hops
    }

    public fun principal(arg0: &Session) : u64 {
        arg0.principal
    }

    public fun put<T0>(arg0: &mut Session, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1, arg2);
    }

    public fun quote_in(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < arg0.hops, 1);
        if (arg1 == 0) {
            arg0.principal
        } else {
            *0x1::vector::borrow<u64>(&arg0.quoted, ((arg1 - 1) as u64))
        }
    }

    public fun record_quote(arg0: &mut Session, arg1: u8, arg2: u64) {
        assert!(!arg0.decided, 2);
        assert!(arg1 < arg0.hops, 1);
        *0x1::vector::borrow_mut<u64>(&mut arg0.quoted, (arg1 as u64)) = arg2;
    }

    public fun record_quote_ratio(arg0: &mut Session, arg1: u8, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 7);
        let v0 = (quote_in(arg0, arg1) as u128) * (arg3 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 5);
        record_quote(arg0, arg1, (v0 as u64));
    }

    public fun record_quote_u256(arg0: &mut Session, arg1: u8, arg2: u256) {
        assert!(arg2 <= 18446744073709551615, 5);
        record_quote(arg0, arg1, (arg2 as u64));
    }

    public fun seed<T0>(arg0: &mut Session, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.principal, 6);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun settle<T0>(arg0: &mut Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.decided, 4);
        let v0 = if (arg0.armed) {
            arg0.hops
        } else {
            0
        };
        let v1 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0);
        if (0x2::balance::value<T0>(&v1) > 0) {
            0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg0.hops, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, arg0.principal), arg1)
    }

    public fun start(arg0: u64, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Session {
        assert!(arg2 > 0 && arg2 <= 8, 0);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < (arg2 as u64)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        Session{
            principal  : arg0,
            min_profit : arg1,
            hops       : arg2,
            quoted     : v0,
            armed      : false,
            decided    : false,
            vault      : 0x2::bag::new(arg3),
        }
    }

    public fun take<T0>(arg0: &mut Session, arg1: u8) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1)
    }

    // decompiled from Move bytecode v7
}

