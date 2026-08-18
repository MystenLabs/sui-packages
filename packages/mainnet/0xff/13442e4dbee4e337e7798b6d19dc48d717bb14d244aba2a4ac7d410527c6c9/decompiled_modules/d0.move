module 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0 {
    struct C has copy, drop {
        d: 0x2::object::ID,
        n: u64,
        z: u64,
        pb: u64,
        pa: u64,
        tb: u64,
        tq: u64,
    }

    struct X has copy, drop {
        d: 0x2::object::ID,
        n: u64,
        r: u8,
        i: u64,
        o: u64,
        e: u64,
    }

    struct S1 has store, key {
        id: 0x2::object::UID,
        d: 0x2::object::ID,
    }

    struct U1 has store, key {
        id: 0x2::object::UID,
        d: 0x2::object::ID,
    }

    struct L has copy, drop, store {
        o: u128,
        x: u64,
        q: u64,
        t: u64,
        e: u64,
        m: u8,
        f: bool,
    }

    struct D<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        v: 0x2::object::ID,
        k: 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultTradeCap<T1>,
        a: 0x2::object::ID,
        m: 0x2::object::ID,
        po: 0x2::object::ID,
        pc: 0x2::object::ID,
        pb: 0x2::object::ID,
        pm: 0x2::object::ID,
        p: vector<u64>,
        h: vector<u64>,
        sk: 0x2::object::ID,
        uk: 0x2::object::ID,
        n: u64,
        ts: u64,
        cy: u64,
        b: L,
        x: L,
        z: bool,
    }

    struct SignalDiscarded has copy, drop {
        desk_id: 0x2::object::ID,
        sequence: u64,
        latest_sequence: u64,
        reason: u8,
    }

    struct XKey has copy, drop, store {
        k: u8,
    }

    public(friend) fun adm<T0, T1>(arg0: &mut D<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(fk(arg0.n, arg0.ts, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg0.p, 9), *0x1::vector::borrow<u64>(&arg0.p, 8)), 2);
        arg0.n = arg1;
        arg0.ts = arg2;
        arg0.cy = arg0.cy + 1;
    }

    public(friend) fun aid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.a
    }

    public fun c0<T0, T1>(arg0: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg2: 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultTradeCap<T1>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) : D<T0, T1> {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg0, arg1);
        check(&arg9);
        check_ceil(&arg9, &arg10);
        D<T0, T1>{
            id : 0x2::object::new(arg11),
            v  : 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg0),
            k  : arg2,
            a  : arg3,
            m  : arg4,
            po : arg5,
            pc : arg6,
            pb : arg7,
            pm : arg8,
            p  : arg9,
            h  : arg10,
            sk : 0x2::object::id_from_address(@0x0),
            uk : 0x2::object::id_from_address(@0x0),
            n  : 0,
            ts : 0,
            cy : 0,
            b  : el(),
            x  : el(),
            z  : false,
        }
    }

    fun check(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 19, 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 3) < *0x1::vector::borrow<u64>(arg0, 2), 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 7) >= 1, 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 13) > 0 && *0x1::vector::borrow<u64>(arg0, 14) > 0, 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 17) > 0, 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 9) > 0, 1);
        assert!(*0x1::vector::borrow<u64>(arg0, 18) > 0, 1);
    }

    fun check_ceil(arg0: &vector<u64>, arg1: &vector<u64>) {
        assert!(hk(arg0, arg1), 4);
    }

    public(friend) fun cks<T0, T1>(arg0: &D<T0, T1>, arg1: &S1) {
        assert!(0x2::object::id<S1>(arg1) == arg0.sk && arg1.d == 0x2::object::uid_to_inner(&arg0.id), 3);
    }

    public(friend) fun cy<T0, T1>(arg0: &D<T0, T1>) : u64 {
        arg0.cy
    }

    public(friend) fun did<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun el() : L {
        L{
            o : 0,
            x : 0,
            q : 0,
            t : 0,
            e : 0,
            m : 0,
            f : false,
        }
    }

    public(friend) fun emit_cycle(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = C{
            d  : arg0,
            n  : arg1,
            z  : arg2,
            pb : arg3,
            pa : arg4,
            tb : arg5,
            tq : arg6,
        };
        0x2::event::emit<C>(v0);
    }

    public(friend) fun emit_take(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = X{
            d : arg0,
            n : arg1,
            r : arg2,
            i : arg3,
            o : arg4,
            e : arg5,
        };
        0x2::event::emit<X>(v0);
    }

    public(friend) fun fk(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (arg2 <= arg0 || arg3 <= arg1) {
            return false
        };
        if (arg4 > arg3 && arg4 - arg3 > arg5) {
            return false
        };
        if (arg3 > arg4 && arg3 - arg4 > arg6) {
            return false
        };
        true
    }

    public(friend) fun fr(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u8 {
        if (arg2 <= arg0) {
            return 1
        };
        if (arg3 <= arg1) {
            return 2
        };
        if (arg4 > arg3 && arg4 - arg3 > arg5) {
            return 3
        };
        if (arg3 > arg4 && arg3 - arg4 > arg6) {
            return 4
        };
        0
    }

    public(friend) fun hk(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        if (0x1::vector::length<u64>(arg1) != 19) {
            return false
        };
        let v0 = vector[6, 8, 9, 13, 17];
        while (!0x1::vector::is_empty<u64>(&v0)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut v0);
            if (*0x1::vector::borrow<u64>(arg0, v1) > *0x1::vector::borrow<u64>(arg1, v1)) {
                return false
            };
        };
        true
    }

    public(friend) fun kb<T0, T1>(arg0: &D<T0, T1>) : &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultTradeCap<T1> {
        &arg0.k
    }

    public(friend) fun lclr<T0, T1>(arg0: &mut D<T0, T1>, arg1: bool) {
        let v0 = arg1 && arg0.b.f || arg0.x.f;
        let v1 = el();
        v1.f = v0;
        if (arg1) {
            arg0.b = v1;
        } else {
            arg0.x = v1;
        };
    }

    public(friend) fun le(arg0: &L) : u64 {
        arg0.e
    }

    public(friend) fun lf(arg0: &L) : bool {
        arg0.f
    }

    public(friend) fun lflag<T0, T1>(arg0: &mut D<T0, T1>, arg1: bool, arg2: bool) {
        if (arg1) {
            arg0.b.f = arg2;
        } else {
            arg0.x.f = arg2;
        };
    }

    public(friend) fun lg<T0, T1>(arg0: &D<T0, T1>, arg1: bool) : L {
        if (arg1) {
            arg0.b
        } else {
            arg0.x
        }
    }

    public(friend) fun lm(arg0: &L) : u8 {
        arg0.m
    }

    public(friend) fun lo(arg0: &L) : u128 {
        arg0.o
    }

    public(friend) fun lq(arg0: &L) : u64 {
        arg0.q
    }

    public(friend) fun lr(arg0: &L) : bool {
        arg0.o != 0
    }

    public(friend) fun lset<T0, T1>(arg0: &mut D<T0, T1>, arg1: bool, arg2: L) {
        if (arg1) {
            arg0.b = arg2;
        } else {
            arg0.x = arg2;
        };
    }

    public(friend) fun lt(arg0: &L) : u64 {
        arg0.t
    }

    public(friend) fun lx(arg0: &L) : u64 {
        arg0.x
    }

    public(friend) fun mid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.m
    }

    public(friend) fun mk(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: bool) : L {
        L{
            o : arg0,
            x : arg1,
            q : arg2,
            t : arg3,
            e : arg4,
            m : arg5,
            f : arg6,
        }
    }

    public fun n0<T0, T1>(arg0: &mut D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg3: &mut 0x2::tx_context::TxContext) : S1 {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 0);
        let v0 = S1{
            id : 0x2::object::new(arg3),
            d  : 0x2::object::uid_to_inner(&arg0.id),
        };
        arg0.sk = 0x2::object::id<S1>(&v0);
        v0
    }

    public fun n1<T0, T1>(arg0: &mut D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg3: &mut 0x2::tx_context::TxContext) : U1 {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 0);
        let v0 = U1{
            id : 0x2::object::new(arg3),
            d  : 0x2::object::uid_to_inner(&arg0.id),
        };
        arg0.uk = 0x2::object::id<U1>(&v0);
        v0
    }

    public(friend) fun pbid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.pb
    }

    public(friend) fun pcid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.pc
    }

    public(friend) fun pmid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.pm
    }

    public(friend) fun poid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.po
    }

    public(friend) fun pv<T0, T1>(arg0: &D<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.p, arg1)
    }

    public fun s0<T0, T1>(arg0: D<T0, T1>) {
        0x2::transfer::share_object<D<T0, T1>>(arg0);
    }

    public(friend) fun sq<T0, T1>(arg0: &D<T0, T1>) : u64 {
        arg0.n
    }

    public fun t0<T0, T1>(arg0: &mut D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg3: vector<u64>, arg4: vector<u64>) {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 0);
        check(&arg3);
        check_ceil(&arg3, &arg4);
        arg0.p = arg3;
        arg0.h = arg4;
    }

    public(friend) fun ta<T0, T1>(arg0: &mut D<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (bool, u8) {
        let v0 = fr(arg0.n, arg0.ts, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg0.p, 9), *0x1::vector::borrow<u64>(&arg0.p, 8));
        if (v0 != 0) {
            let v1 = SignalDiscarded{
                desk_id         : 0x2::object::uid_to_inner(&arg0.id),
                sequence        : arg1,
                latest_sequence : arg0.n,
                reason          : v0,
            };
            0x2::event::emit<SignalDiscarded>(v1);
            return (false, v0)
        };
        arg0.n = arg1;
        arg0.ts = arg2;
        arg0.cy = arg0.cy + 1;
        (true, 0)
    }

    public fun u0<T0, T1>(arg0: &mut D<T0, T1>, arg1: &U1, arg2: vector<u64>) {
        assert!(0x2::object::id<U1>(arg1) == arg0.uk && arg1.d == 0x2::object::uid_to_inner(&arg0.id), 3);
        check(&arg2);
        check_ceil(&arg2, &arg0.h);
        arg0.p = arg2;
    }

    public(friend) fun vid<T0, T1>(arg0: &D<T0, T1>) : 0x2::object::ID {
        arg0.v
    }

    public fun xb<T0, T1>(arg0: &mut D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg3: u8, arg4: 0x2::object::ID) {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 0);
        let v0 = XKey{k: arg3};
        if (0x2::dynamic_field::exists_<XKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<XKey, 0x2::object::ID>(&mut arg0.id, v0) = arg4;
        } else {
            0x2::dynamic_field::add<XKey, 0x2::object::ID>(&mut arg0.id, v0, arg4);
        };
    }

    public(friend) fun xg<T0, T1>(arg0: &D<T0, T1>, arg1: u8) : 0x2::object::ID {
        let v0 = XKey{k: arg1};
        if (0x2::dynamic_field::exists_<XKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<XKey, 0x2::object::ID>(&arg0.id, v0)
        } else {
            0x2::object::id_from_address(@0x0)
        }
    }

    public fun z0<T0, T1>(arg0: &mut D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::VaultAdminCap<T1>, arg3: bool) {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 0);
        arg0.z = arg3;
    }

    public(friend) fun zp<T0, T1>(arg0: &D<T0, T1>) : bool {
        arg0.z
    }

    // decompiled from Move bytecode v7
}

