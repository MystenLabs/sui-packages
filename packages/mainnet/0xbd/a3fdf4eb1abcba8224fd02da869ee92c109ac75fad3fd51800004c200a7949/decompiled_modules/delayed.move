module 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed {
    struct Delayed<T0: copy + drop + store> has store {
        value: T0,
        delay_ms: u64,
        pending: 0x1::option::Option<Pending<T0>>,
    }

    struct Pending<T0: copy + drop + store> has copy, drop, store {
        value: T0,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    public fun apply<T0: copy + drop + store>(arg0: &mut Delayed<T0>, arg1: &0x2::clock::Clock) : T0 {
        assert!(0x1::option::is_some<Pending<T0>>(&arg0.pending), 21);
        let (v0, v1) = take_ready<T0>(0x1::option::destroy_some<Pending<T0>>(arg0.pending), arg1);
        arg0.pending = 0x1::option::none<Pending<T0>>();
        arg0.value = v0;
        arg0.delay_ms = v1;
        v0
    }

    public fun assert_ready<T0: copy + drop + store>(arg0: &Delayed<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Pending<T0>>(&arg0.pending), 21);
        let (_, _) = take_ready<T0>(0x1::option::destroy_some<Pending<T0>>(arg0.pending), arg1);
    }

    public fun cancel<T0: copy + drop + store>(arg0: &mut Delayed<T0>) : T0 {
        assert!(0x1::option::is_some<Pending<T0>>(&arg0.pending), 21);
        let v0 = 0x1::option::extract<Pending<T0>>(&mut arg0.pending);
        v0.value
    }

    public fun delay_ms<T0: copy + drop + store>(arg0: &Delayed<T0>) : u64 {
        arg0.delay_ms
    }

    public fun new<T0: copy + drop + store>(arg0: T0, arg1: u64) : Delayed<T0> {
        Delayed<T0>{
            value    : arg0,
            delay_ms : arg1,
            pending  : 0x1::option::none<Pending<T0>>(),
        }
    }

    public fun new_pending<T0: copy + drop + store>(arg0: T0, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : Pending<T0> {
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg3), arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = 0x1::u64::checked_add(v1, arg2);
            assert!(0x1::option::is_some<u64>(&v2), 22);
            return Pending<T0>{
                value       : arg0,
                delay_ms    : arg2,
                ready_at_ms : v1,
            }
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 22
        };
    }

    public fun pending<T0: copy + drop + store>(arg0: &Delayed<T0>) : 0x1::option::Option<Pending<T0>> {
        arg0.pending
    }

    public fun pending_delay_ms<T0: copy + drop + store>(arg0: &Pending<T0>) : u64 {
        arg0.delay_ms
    }

    public fun pending_value<T0: copy + drop + store>(arg0: &Pending<T0>) : T0 {
        arg0.value
    }

    public fun ready_at_ms<T0: copy + drop + store>(arg0: &Pending<T0>) : u64 {
        arg0.ready_at_ms
    }

    public fun schedule<T0: copy + drop + store>(arg0: &mut Delayed<T0>, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = new_pending<T0>(arg1, arg0.delay_ms, arg2, arg3);
        arg0.pending = 0x1::option::some<Pending<T0>>(v0);
        v0.ready_at_ms
    }

    public fun schedule_delay<T0: copy + drop + store>(arg0: &mut Delayed<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.value;
        schedule<T0>(arg0, v0, arg1, arg2)
    }

    public fun schedule_value<T0: copy + drop + store>(arg0: &mut Delayed<T0>, arg1: T0, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.delay_ms;
        schedule<T0>(arg0, arg1, v0, arg2)
    }

    public fun take_ready<T0: copy + drop + store>(arg0: Pending<T0>, arg1: &0x2::clock::Clock) : (T0, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.ready_at_ms, 20);
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg1), arg0.delay_ms);
        assert!(0x1::option::is_some<u64>(&v0), 22);
        (arg0.value, arg0.delay_ms)
    }

    public fun value<T0: copy + drop + store>(arg0: &Delayed<T0>) : T0 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

