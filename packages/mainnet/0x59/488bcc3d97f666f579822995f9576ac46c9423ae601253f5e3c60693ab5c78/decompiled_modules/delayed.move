module 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed {
    struct Delayed<T0: copy + drop + store, T1: copy + drop + store> has store {
        parent: 0x2::object::ID,
        key: T0,
        value: T1,
        delay_ms: u64,
        pending: 0x1::option::Option<Proposal<T1>>,
    }

    struct Proposal<T0: copy + drop + store> has copy, drop, store {
        value: T0,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct PendingDelay has copy, drop, store {
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct Deadline has copy, drop, store {
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct DelayedCreated<T0: copy + drop + store, T1: copy + drop + store> has copy, drop {
        parent: 0x2::object::ID,
        key: T0,
        value: T1,
        delay_ms: u64,
    }

    struct DelayedScheduled<T0: copy + drop + store, T1: copy + drop + store> has copy, drop {
        parent: 0x2::object::ID,
        key: T0,
        value: T1,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct DelayedCancelled<T0: copy + drop + store, T1: copy + drop + store> has copy, drop {
        parent: 0x2::object::ID,
        key: T0,
        value: T1,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct DelayedApplied<T0: copy + drop + store, T1: copy + drop + store> has copy, drop {
        parent: 0x2::object::ID,
        key: T0,
        previous_value: T1,
        value: T1,
        delay_ms: u64,
    }

    struct DelayedDestroyed<T0: copy + drop + store, phantom T1: copy + drop + store> has copy, drop {
        parent: 0x2::object::ID,
        key: T0,
    }

    public fun apply<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>, arg1: &0x2::clock::Clock) : T1 {
        assert_ready<T0, T1>(arg0, arg1);
        let Proposal {
            value       : v0,
            delay_ms    : v1,
            ready_at_ms : _,
        } = 0x1::option::extract<Proposal<T1>>(&mut arg0.pending);
        arg0.value = v0;
        arg0.delay_ms = v1;
        let v3 = DelayedApplied<T0, T1>{
            parent         : arg0.parent,
            key            : arg0.key,
            previous_value : arg0.value,
            value          : v0,
            delay_ms       : v1,
        };
        0x2::event::emit<DelayedApplied<T0, T1>>(v3);
        v0
    }

    public(friend) fun assert_delay(arg0: u64) {
        assert!(arg0 <= 2592000000, 15);
    }

    public fun assert_ready<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Proposal<T1>>(&arg0.pending), 14);
        let v0 = 0x1::option::borrow<Proposal<T1>>(&arg0.pending);
        assert_ready_at(v0.ready_at_ms, v0.delay_ms, arg1);
    }

    public(friend) fun assert_ready_at(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0, 13);
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg2), arg1);
        assert!(0x1::option::is_some<u64>(&v0), 15);
    }

    public fun cancel<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>) {
        assert!(0x1::option::is_some<Proposal<T1>>(&arg0.pending), 14);
        cancel_replaced<T0, T1>(arg0);
    }

    fun cancel_replaced<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>) {
        if (0x1::option::is_none<Proposal<T1>>(&arg0.pending)) {
            return
        };
        let Proposal {
            value       : v0,
            delay_ms    : v1,
            ready_at_ms : v2,
        } = 0x1::option::extract<Proposal<T1>>(&mut arg0.pending);
        let v3 = DelayedCancelled<T0, T1>{
            parent      : arg0.parent,
            key         : arg0.key,
            value       : v0,
            delay_ms    : v1,
            ready_at_ms : v2,
        };
        0x2::event::emit<DelayedCancelled<T0, T1>>(v3);
    }

    public fun deadline_delay_ms(arg0: &Deadline) : u64 {
        arg0.delay_ms
    }

    public fun deadline_ready_at_ms(arg0: &Deadline) : u64 {
        arg0.ready_at_ms
    }

    public fun delay_ms<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : u64 {
        arg0.delay_ms
    }

    public fun destroy<T0: copy + drop + store, T1: copy + drop + store>(arg0: Delayed<T0, T1>) {
        assert!(0x1::option::is_none<Proposal<T1>>(&arg0.pending), 17);
        let Delayed {
            parent   : v0,
            key      : v1,
            value    : _,
            delay_ms : _,
            pending  : _,
        } = arg0;
        let v5 = DelayedDestroyed<T0, T1>{
            parent : v0,
            key    : v1,
        };
        0x2::event::emit<DelayedDestroyed<T0, T1>>(v5);
    }

    public fun is_guarded<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : bool {
        if (arg0.delay_ms > 0) {
            let v1 = &arg0.pending;
            0x1::option::is_none<Proposal<T1>>(v1) || 0x1::option::borrow<Proposal<T1>>(v1).delay_ms > 0
        } else {
            false
        }
    }

    public fun is_ready<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        let v0 = &arg0.pending;
        if (0x1::option::is_some<Proposal<T1>>(v0)) {
            let v2 = 0x1::option::borrow<Proposal<T1>>(v0);
            is_ready_at(v2.ready_at_ms, v2.delay_ms, arg1)
        } else {
            false
        }
    }

    public(friend) fun is_ready_at(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (0x2::clock::timestamp_ms(arg2) >= arg0) {
            let v1 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg2), arg1);
            0x1::option::is_some<u64>(&v1)
        } else {
            false
        }
    }

    public fun key<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : T0 {
        arg0.key
    }

    public fun max_delay_ms() : u64 {
        2592000000
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: &0x2::object::UID, arg2: T1, arg3: u64) : Delayed<T0, T1> {
        assert_delay(arg3);
        let v0 = 0x2::object::uid_to_inner(arg1);
        let v1 = DelayedCreated<T0, T1>{
            parent   : v0,
            key      : arg0,
            value    : arg2,
            delay_ms : arg3,
        };
        0x2::event::emit<DelayedCreated<T0, T1>>(v1);
        Delayed<T0, T1>{
            parent   : v0,
            key      : arg0,
            value    : arg2,
            delay_ms : arg3,
            pending  : 0x1::option::none<Proposal<T1>>(),
        }
    }

    public(friend) fun new_deadline(arg0: u64, arg1: u64) : Deadline {
        Deadline{
            delay_ms    : arg0,
            ready_at_ms : arg1,
        }
    }

    public(friend) fun new_pending_delay(arg0: u64, arg1: u64) : PendingDelay {
        PendingDelay{
            delay_ms    : arg0,
            ready_at_ms : arg1,
        }
    }

    public(friend) fun new_proposal<T0: copy + drop + store>(arg0: T0, arg1: u64, arg2: u64) : Proposal<T0> {
        Proposal<T0>{
            value       : arg0,
            delay_ms    : arg1,
            ready_at_ms : arg2,
        }
    }

    public fun parent<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : 0x2::object::ID {
        arg0.parent
    }

    public fun pending<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : 0x1::option::Option<Proposal<T1>> {
        arg0.pending
    }

    public fun pending_delay_ms(arg0: &PendingDelay) : u64 {
        arg0.delay_ms
    }

    public fun pending_delay_ready_at_ms(arg0: &PendingDelay) : u64 {
        arg0.ready_at_ms
    }

    public fun proposal_delay_ms<T0: copy + drop + store>(arg0: &Proposal<T0>) : u64 {
        arg0.delay_ms
    }

    public fun proposal_ready_at_ms<T0: copy + drop + store>(arg0: &Proposal<T0>) : u64 {
        arg0.ready_at_ms
    }

    public fun proposal_value<T0: copy + drop + store>(arg0: &Proposal<T0>) : T0 {
        arg0.value
    }

    public(friend) fun ready_at_ms_after(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert_delay(arg1);
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg2), arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = 0x1::u64::checked_add(v1, arg1);
            assert!(0x1::option::is_some<u64>(&v2), 15);
            return v1
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 15
        };
    }

    public fun schedule<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>, arg1: T1, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg1 != arg0.value || arg2 != arg0.delay_ms, 16);
        let v0 = ready_at_ms_after(arg0.delay_ms, arg2, arg3);
        cancel_replaced<T0, T1>(arg0);
        let v1 = Proposal<T1>{
            value       : arg1,
            delay_ms    : arg2,
            ready_at_ms : v0,
        };
        0x1::option::fill<Proposal<T1>>(&mut arg0.pending, v1);
        let v2 = DelayedScheduled<T0, T1>{
            parent      : arg0.parent,
            key         : arg0.key,
            value       : arg1,
            delay_ms    : arg2,
            ready_at_ms : v0,
        };
        0x2::event::emit<DelayedScheduled<T0, T1>>(v2);
        v0
    }

    public fun schedule_delay<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.value;
        schedule<T0, T1>(arg0, v0, arg1, arg2)
    }

    public fun schedule_value<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Delayed<T0, T1>, arg1: T1, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.delay_ms;
        schedule<T0, T1>(arg0, arg1, v0, arg2)
    }

    public fun value<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Delayed<T0, T1>) : T1 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

