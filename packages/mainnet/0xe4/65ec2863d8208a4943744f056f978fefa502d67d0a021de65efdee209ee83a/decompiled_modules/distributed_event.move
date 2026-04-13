module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::distributed_event {
    struct DistributedEventWrapper<T0: copy + drop> has copy, drop {
        event: T0,
        deadline_ms: u64,
        requested_at_ms: u64,
        task_id: 0x2::object::ID,
        leaders: vector<0x2::object::ID>,
    }

    public fun emit<T0: copy + drop>(arg0: T0, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>) {
        let v0 = DistributedEventWrapper<T0>{
            event           : arg0,
            deadline_ms     : arg1,
            requested_at_ms : arg2,
            task_id         : arg3,
            leaders         : arg4,
        };
        0x2::event::emit<DistributedEventWrapper<T0>>(v0);
    }

    public fun deadline_ms<T0: copy + drop>(arg0: &DistributedEventWrapper<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun inner<T0: copy + drop>(arg0: &DistributedEventWrapper<T0>) : &T0 {
        &arg0.event
    }

    public fun leaders<T0: copy + drop>(arg0: &DistributedEventWrapper<T0>) : &vector<0x2::object::ID> {
        &arg0.leaders
    }

    public fun requested_at_ms<T0: copy + drop>(arg0: &DistributedEventWrapper<T0>) : u64 {
        arg0.requested_at_ms
    }

    public fun task_id<T0: copy + drop>(arg0: &DistributedEventWrapper<T0>) : 0x2::object::ID {
        arg0.task_id
    }

    // decompiled from Move bytecode v6
}

