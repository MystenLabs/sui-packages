module 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::emergency_cap {
    struct EMERGENCY_CAP has drop {
        dummy_field: bool,
    }

    struct EmergencyCap has store, key {
        id: 0x2::object::UID,
        created_at: u64,
        armed_at: 0x1::option::Option<u64>,
    }

    public fun id(arg0: &EmergencyCap) : 0x2::object::ID {
        0x2::object::id<EmergencyCap>(arg0)
    }

    public entry fun activate(arg0: &mut EmergencyCap, arg1: &0x2::clock::Clock) {
        assert!(arg0.created_at == 0, 4);
        arg0.created_at = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun arm(arg0: &mut EmergencyCap, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<u64>(&arg0.armed_at), 3);
        arg0.armed_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
    }

    public fun assert_ready(arg0: &EmergencyCap, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<u64>(&arg0.armed_at), 1);
        let v0 = *0x1::option::borrow<u64>(&arg0.armed_at);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = if (arg0.created_at > 0 && v1 - arg0.created_at < 60 * 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_day_ms()) {
            0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_day_ms()
        } else {
            0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_week_ms()
        };
        assert!(v1 >= v0 && v1 - v0 >= v2, 2);
    }

    public entry fun burn(arg0: EmergencyCap) {
        let EmergencyCap {
            id         : v0,
            created_at : _,
            armed_at   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun disarm(arg0: &mut EmergencyCap) {
        arg0.armed_at = 0x1::option::none<u64>();
    }

    fun init(arg0: EMERGENCY_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<EMERGENCY_CAP>(&arg0), 0);
        let v0 = EmergencyCap{
            id         : 0x2::object::new(arg1),
            created_at : 0,
            armed_at   : 0x1::option::none<u64>(),
        };
        0x2::transfer::transfer<EmergencyCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_armed(arg0: &EmergencyCap) : bool {
        0x1::option::is_some<u64>(&arg0.armed_at)
    }

    // decompiled from Move bytecode v6
}

