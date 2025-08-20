module 0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::multiplier {
    struct Multiplier has store, key {
        id: 0x2::object::UID,
        tenant_id: vector<u8>,
        multiplier_value: u64,
        duration: u64,
        deactivated: bool,
    }

    struct UserMultiplier has copy, drop, store {
        user_id: vector<u8>,
        tenant_id: vector<u8>,
        multiplier: 0x2::object::ID,
        multiplier_value: u64,
        start_date: u64,
        end_date: u64,
    }

    struct MultiplierManager has key {
        id: 0x2::object::UID,
        user_multipliers: 0x2::bag::Bag,
    }

    struct GetMultiplierValueEvent has copy, drop, store {
        tenant_id: vector<u8>,
        user: vector<u8>,
        total_multiplier: u64,
    }

    public fun claim_multiplier(arg0: &mut MultiplierManager, arg1: vector<u8>, arg2: vector<u8>, arg3: &Multiplier, arg4: u64, arg5: u64) {
        assert!(arg1 == arg3.tenant_id, 1);
        assert!(arg4 + arg3.duration == arg5, 12);
        let v0 = UserMultiplier{
            user_id          : arg2,
            tenant_id        : arg1,
            multiplier       : 0x2::object::id<Multiplier>(arg3),
            multiplier_value : arg3.multiplier_value,
            start_date       : arg4,
            end_date         : arg5,
        };
        0x2::bag::add<u64, UserMultiplier>(&mut arg0.user_multipliers, 0x2::bag::length(&arg0.user_multipliers) + 1, v0);
    }

    public fun create_multiplier(arg0: &0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::AdminKey, arg1: &0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::Executor, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::assert_admin(0x2::tx_context::sender(arg5), arg2, arg0) || 0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::assert_executor(0x2::tx_context::sender(arg5), arg1), 1);
        let v0 = Multiplier{
            id               : 0x2::object::new(arg5),
            tenant_id        : arg2,
            multiplier_value : arg3,
            duration         : arg4,
            deactivated      : false,
        };
        0x2::transfer::share_object<Multiplier>(v0);
    }

    public fun deactivate_multiplier(arg0: &0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::AdminKey, arg1: &0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::Executor, arg2: &mut Multiplier, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::assert_admin(0x2::tx_context::sender(arg3), arg2.tenant_id, arg0) || 0xa27e2099df7a1a8c000108f8f83ede604db5df4787b2cd66cfc55916637c156f::access_control::assert_executor(0x2::tx_context::sender(arg3), arg1), 1);
        arg2.deactivated = true;
    }

    public fun get_multiplier(arg0: &MultiplierManager, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        let v2 = 1;
        while (v2 <= 0x2::bag::length(&arg0.user_multipliers)) {
            let v3 = 0x2::bag::borrow<u64, UserMultiplier>(&arg0.user_multipliers, v2);
            let v4 = if (v3.user_id == arg2) {
                if (v3.tenant_id == arg1) {
                    if (v0 >= v3.start_date * 1000) {
                        v0 <= v3.end_date * 1000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v1 = v1 + v3.multiplier_value;
            };
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            v1 = 100;
        };
        let v5 = GetMultiplierValueEvent{
            tenant_id        : arg1,
            user             : arg2,
            total_multiplier : v1,
        };
        0x2::event::emit<GetMultiplierValueEvent>(v5);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultiplierManager{
            id               : 0x2::object::new(arg0),
            user_multipliers : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<MultiplierManager>(v0);
    }

    // decompiled from Move bytecode v6
}

