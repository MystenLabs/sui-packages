module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state {
    struct EmergencyState has store {
        announced: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct EmergencyAnnounced has copy, drop {
        token: 0x1::type_name::TypeName,
        executable_at_ms: u64,
        announced_at_ms: u64,
    }

    struct EmergencyCancelled has copy, drop {
        token: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct EmergencyExecuted has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : EmergencyState {
        EmergencyState{announced: 0x2::table::new<0x1::type_name::TypeName, u64>(arg0)}
    }

    public(friend) fun announce(arg0: &mut EmergencyState, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1), 1000);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 + arg2;
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.announced, arg1, v1);
        let v2 = EmergencyAnnounced{
            token            : arg1,
            executable_at_ms : v1,
            announced_at_ms  : v0,
        };
        0x2::event::emit<EmergencyAnnounced>(v2);
    }

    public(friend) fun announced_count(arg0: &EmergencyState) : u64 {
        0x2::table::length<0x1::type_name::TypeName, u64>(&arg0.announced)
    }

    public(friend) fun cancel(arg0: &mut EmergencyState, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1), 1001);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.announced, arg1);
        let v0 = EmergencyCancelled{
            token        : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyCancelled>(v0);
    }

    public(friend) fun consume(arg0: &mut EmergencyState, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1), 1001);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.announced, arg1), 1002);
    }

    public(friend) fun emit_executed(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = EmergencyExecuted{
            token        : arg0,
            amount       : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyExecuted>(v0);
    }

    public(friend) fun executable_at(arg0: &EmergencyState, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1), 1001);
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.announced, arg1)
    }

    public(friend) fun is_announced(arg0: &EmergencyState, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1)
    }

    // decompiled from Move bytecode v7
}

