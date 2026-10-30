module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::golive {
    struct WentLive has copy, drop {
        halt: 0x2::object::ID,
        guard: 0x2::object::ID,
        rebate: 0x2::object::ID,
        ts_ms: u64,
    }

    public fun go_live<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg2: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg3: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg4: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rebate::RebateBudget<T0, T1>, arg5: &0x2::clock::Clock) {
        assert!(0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::pool_id(arg3) == 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rebate::pool_of<T0, T1>(arg4), 800);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::go_live(arg3, arg5);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rebate::go_live<T0, T1>(arg4);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::unhalt(arg1, arg2);
        let v0 = WentLive{
            halt   : 0x2::object::id<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt>(arg2),
            guard  : 0x2::object::id<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard>(arg3),
            rebate : 0x2::object::id<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rebate::RebateBudget<T0, T1>>(arg4),
            ts_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<WentLive>(v0);
    }

    // decompiled from Move bytecode v7
}

