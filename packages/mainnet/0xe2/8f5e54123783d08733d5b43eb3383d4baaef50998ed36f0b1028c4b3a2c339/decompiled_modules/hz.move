module 0xe28f5e54123783d08733d5b43eb3383d4baaef50998ed36f0b1028c4b3a2c339::hz {
    struct Ht {
        a: vector<u64>,
        b: vector<u64>,
        c: vector<0x2::object::ID>,
        d: vector<bool>,
        e: u64,
        f: u64,
        g: u64,
        h: bool,
        i: bool,
        j: u64,
        k: u64,
        l: u64,
        m: u64,
    }

    public fun ai(arg0: &Ht) : u64 {
        arg0.j
    }

    public fun ar(arg0: &Ht) : bool {
        arg0.i
    }

    public(friend) fun bl(arg0: &mut Ht, arg1: 0x2::object::ID, arg2: bool) : u64 {
        assert!(arg0.h, 153);
        assert!(arg0.g < arg0.e, 155);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.c, arg0.g) == arg1, 156);
        assert!(*0x1::vector::borrow<bool>(&arg0.d, arg0.g) == arg2, 157);
        arg0.g = arg0.g + 1;
        arg0.j
    }

    public fun ch(arg0: &mut Ht, arg1: &mut Ht) {
        assert!(arg0.h && arg1.h, 153);
        let v0 = if (arg0.i) {
            arg0.k - arg0.j
        } else {
            0
        };
        let v1 = if (arg1.i) {
            arg1.k - arg1.j
        } else {
            0
        };
        if (v0 >= v1) {
            dz(arg1);
        } else {
            dz(arg0);
        };
    }

    public(friend) fun cn(arg0: &Ht) : u64 {
        0x1::vector::length<u64>(&arg0.a)
    }

    fun dz(arg0: &mut Ht) {
        arg0.i = false;
        arg0.j = 0;
        arg0.k = 0;
    }

    public fun eo(arg0: &Ht) : u64 {
        arg0.k
    }

    public fun fz<T0>(arg0: Ht, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let Ht {
            a : _,
            b : _,
            c : _,
            d : _,
            e : v4,
            f : _,
            g : v6,
            h : v7,
            i : v8,
            j : _,
            k : _,
            l : v11,
            m : v12,
        } = arg0;
        assert!(v7, 153);
        assert!(v6 == v4, 155);
        assert!(0x2::clock::timestamp_ms(arg2) <= v12, 150);
        let v13 = 0x2::balance::value<T0>(&arg1);
        if (!v8) {
            assert!(v13 == 0, 158);
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        if ((v13 as u128) < (v11 as u128)) {
            abort gc((v11 as u128) - (v13 as u128))
        };
        if (v13 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::send_funds<T0>(arg1, 0x2::tx_context::sender(arg3));
        };
    }

    public(friend) fun gc(arg0: u128) : u64 {
        let v0 = if (arg0 > (281474976710655 as u128)) {
            281474976710655
        } else {
            (arg0 as u64)
        };
        200 + v0
    }

    public(friend) fun ia(arg0: &Ht) : bool {
        arg0.i
    }

    public fun mp(arg0: &Ht) : u64 {
        arg0.l
    }

    public(friend) fun np(arg0: &mut Ht, arg1: 0x2::object::ID, arg2: bool) {
        assert!(!arg0.h, 154);
        assert!(arg0.f < arg0.e, 155);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.c, arg1);
        0x1::vector::push_back<bool>(&mut arg0.d, arg2);
        arg0.f = arg0.f + 1;
    }

    public fun nw(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : Ht {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3, 150);
        assert!(0x2::tx_context::epoch(arg6) == arg4, 151);
        assert!(arg1 >= 2 && arg1 <= 4, 155);
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 >= 1 && v0 <= 8, 152);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v1) > 0, 152);
            if (v1 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg0, v1) > *0x1::vector::borrow<u64>(&arg0, v1 - 1), 152);
            };
            v1 = v1 + 1;
        };
        Ht{
            a : arg0,
            b : arg0,
            c : 0x1::vector::empty<0x2::object::ID>(),
            d : vector[],
            e : arg1,
            f : 0,
            g : 0,
            h : false,
            i : false,
            j : 0,
            k : 0,
            l : arg2,
            m : arg3,
        }
    }

    public(friend) fun ra(arg0: &Ht, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.b, arg1)
    }

    public fun sl(arg0: &mut Ht) {
        assert!(!arg0.h, 154);
        assert!(arg0.f == arg0.e, 155);
        arg0.h = true;
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0.a)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.b, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg0.a, v2);
            if (v3 > v4) {
                let v5 = v3 - v4;
                if (v5 > v0) {
                    v1 = v5;
                    arg0.j = v4;
                    arg0.k = v3;
                };
            };
            v2 = v2 + 1;
        };
        if (v1 >= arg0.l && v1 > 0) {
            arg0.i = true;
        } else {
            arg0.j = 0;
            arg0.k = 0;
        };
    }

    public(friend) fun sr(arg0: &mut Ht, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.b, arg1) = arg2;
    }

    public(friend) fun tk<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 < arg1) {
            abort gc(((arg1 - v0) as u128))
        };
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

