module 0x9f787c1da1519789f06a42fb2f6d16c7d5bfe604fd918bce963567398cc76382::defense {
    struct CounterController has key {
        id: 0x2::object::UID,
        target_controller: address,
        defender: address,
        is_active: bool,
        trapped_count: u64,
        created_at: u64,
    }

    struct CounterEvent has copy, drop {
        defender: address,
        target: address,
        action: vector<u8>,
        trapped_count: u64,
        timestamp: u64,
    }

    public fun block_target(arg0: &mut CounterController, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.defender, 401);
        arg0.is_active = false;
        let v1 = CounterEvent{
            defender      : v0,
            target        : arg0.target_controller,
            action        : b"TARGET_CONTROLLER_BLOCKED",
            trapped_count : arg0.trapped_count,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<CounterEvent>(v1);
    }

    public fun create_counter_controller(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CounterController{
            id                : 0x2::object::new(arg1),
            target_controller : arg0,
            defender          : v0,
            is_active         : true,
            trapped_count     : 0,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v2 = CounterEvent{
            defender      : v0,
            target        : arg0,
            action        : b"COUNTER_CONTROLLER_CREATED",
            trapped_count : 0,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<CounterEvent>(v2);
        0x2::transfer::share_object<CounterController>(v1);
    }

    public fun get_defender(arg0: &CounterController) : address {
        arg0.defender
    }

    public fun get_target_controller(arg0: &CounterController) : address {
        arg0.target_controller
    }

    public fun get_trapped_count(arg0: &CounterController) : u64 {
        arg0.trapped_count
    }

    public fun is_counter_active(arg0: &CounterController) : bool {
        arg0.is_active
    }

    public fun trap_drain_attempt(arg0: &mut CounterController, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.defender, 401);
        arg0.trapped_count = arg0.trapped_count + 1;
        let v1 = CounterEvent{
            defender      : v0,
            target        : arg0.target_controller,
            action        : b"DRAIN_ATTEMPT_TRAPPED",
            trapped_count : arg0.trapped_count,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<CounterEvent>(v1);
    }

    public fun unblock_target(arg0: &mut CounterController, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.defender, 401);
        arg0.is_active = true;
        let v1 = CounterEvent{
            defender      : v0,
            target        : arg0.target_controller,
            action        : b"TARGET_CONTROLLER_UNBLOCKED",
            trapped_count : arg0.trapped_count,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<CounterEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

