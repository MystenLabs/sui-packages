module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session {
    struct Session {
        tag: u128,
        sender: address,
        principal: u64,
        flash_fee: u64,
        min_profit: u64,
        gas_reserve: u64,
        hops: u8,
        quoted: vector<u64>,
        executed: u8,
        pools: vector<address>,
        repeated_pool: bool,
        deadline_ms: u64,
        phase: u8,
        armed: bool,
        vault: 0x2::bag::Bag,
    }

    struct Armed has copy, drop {
        tag: u128,
        sender: address,
        armed: bool,
        principal: u64,
        expected_out: u64,
        required_out: u64,
        hops: u8,
    }

    struct Finished has copy, drop {
        tag: u128,
        sender: address,
        armed: bool,
        principal: u64,
        out: u64,
        profit: u64,
        repeated_pool: bool,
    }

    public fun new(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Session {
        assert!(arg4 > 0 && arg4 <= 8, 6);
        Session{
            tag           : arg0,
            sender        : 0x2::tx_context::sender(arg6),
            principal     : 0,
            flash_fee     : arg1,
            min_profit    : arg2,
            gas_reserve   : arg3,
            hops          : arg4,
            quoted        : vector[],
            executed      : 0,
            pools         : vector[],
            repeated_pool : false,
            deadline_ms   : arg5,
            phase         : 0,
            armed         : false,
            vault         : 0x2::bag::new(arg6),
        }
    }

    public fun sender(arg0: &Session) : address {
        arg0.sender
    }

    public fun arm(arg0: &mut Session, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.phase == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.deadline_ms, 3);
        assert!(0x1::vector::length<u64>(&arg0.quoted) == arg3, 7);
        let v0 = required_out(arg0, arg1);
        assert!(arg1 > 0 && arg2 >= v0, 8);
        arg0.armed = true;
        arg0.principal = arg1;
        arg0.phase = 1;
        let v1 = Armed{
            tag          : arg0.tag,
            sender       : arg0.sender,
            armed        : true,
            principal    : arg0.principal,
            expected_out : arg2,
            required_out : v0,
            hops         : arg0.hops,
        };
        0x2::event::emit<Armed>(v1);
    }

    public fun armed(arg0: &Session) : bool {
        arg0.armed
    }

    public fun executed(arg0: &Session) : u8 {
        arg0.executed
    }

    public fun finish<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            tag           : v0,
            sender        : v1,
            principal     : v2,
            flash_fee     : _,
            min_profit    : v4,
            gas_reserve   : v5,
            hops          : v6,
            quoted        : _,
            executed      : v8,
            pools         : _,
            repeated_pool : v10,
            deadline_ms   : _,
            phase         : _,
            armed         : v13,
            vault         : v14,
        } = arg0;
        let v15 = v14;
        assert!(v8 == v6, 5);
        let v16 = if (0x2::bag::contains<u8>(&v15, v6)) {
            0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v15, v6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v17 = v16;
        0x2::bag::destroy_empty(v15);
        let v18 = 0x2::balance::value<T0>(&v17);
        assert!(v13 && v18 >= v5 + v4, 4);
        let v19 = Finished{
            tag           : v0,
            sender        : v1,
            armed         : v13,
            principal     : v2,
            out           : v2 + v18,
            profit        : v18,
            repeated_pool : v10,
        };
        0x2::event::emit<Finished>(v19);
        0x2::coin::from_balance<T0>(v17, arg1)
    }

    public fun flash_fee(arg0: &Session) : u64 {
        arg0.flash_fee
    }

    public fun hops(arg0: &Session) : u8 {
        arg0.hops
    }

    public fun principal(arg0: &Session) : u64 {
        arg0.principal
    }

    public fun put_out<T0>(arg0: &mut Session, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        assert!(arg0.phase == 1, 1);
        assert!(arg1 == arg0.executed, 2);
        assert!(!0x1::vector::contains<address>(&arg0.pools, &arg3), 9);
        0x1::vector::push_back<address>(&mut arg0.pools, arg3);
        if (arg0.armed && arg1 + 1 == arg0.hops) {
            assert!(0x2::balance::value<T0>(&arg2) >= required_out(arg0, arg0.principal), 4);
        };
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1 + 1, arg2);
        arg0.executed = arg1 + 1;
    }

    public fun quotes(arg0: &Session) : &vector<u64> {
        &arg0.quoted
    }

    public fun record_quote(arg0: &mut Session, arg1: u64) {
        assert!(arg0.phase == 0, 1);
        0x1::vector::push_back<u64>(&mut arg0.quoted, arg1);
    }

    public fun repeated_pool(arg0: &Session) : bool {
        arg0.repeated_pool
    }

    public fun required_out(arg0: &Session, arg1: u64) : u64 {
        arg1 + arg0.flash_fee + arg0.gas_reserve + arg0.min_profit
    }

    public fun seed<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 1, 1);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0, arg1);
    }

    public fun settle<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg0.hops, arg1);
    }

    public fun tag(arg0: &Session) : u128 {
        arg0.tag
    }

    public fun take_final<T0>(arg0: &mut Session) : 0x2::balance::Balance<T0> {
        assert!(arg0.executed == arg0.hops, 5);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg0.hops)
    }

    public fun take_in<T0>(arg0: &mut Session, arg1: u8) : 0x2::balance::Balance<T0> {
        assert!(arg0.phase == 1, 1);
        assert!(arg1 == arg0.executed, 2);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1)
    }

    // decompiled from Move bytecode v7
}

