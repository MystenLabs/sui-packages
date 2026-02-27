module 0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::mm_state {
    struct MMState has key {
        id: 0x2::object::UID,
        owner: address,
        registry_id: 0x2::object::ID,
        current_price: u64,
        current_spread: u64,
        price_sequence: u64,
        execution_count: u64,
        last_order_time: u64,
        is_paused: bool,
        pause_until: u64,
        last_arb_timestamp: u64,
    }

    public fun registry_id(arg0: &MMState) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun admin_pause(arg0: &mut MMState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        pause(arg0, v0 + arg1, v0);
    }

    public fun admin_unpause(arg0: &mut MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        unpause(arg0);
    }

    public(friend) fun advance_sequence(arg0: &mut MMState, arg1: u64) {
        if (arg1 > arg0.price_sequence) {
            arg0.price_sequence = arg1;
        };
    }

    public fun can_execute(arg0: &MMState, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (!is_trading_blocked(arg0, arg1)) {
            if (arg1 < arg2) {
                !is_within_cooldown(arg0, arg1, arg3)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun create(arg0: &0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::mm_registry::MMRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : MMState {
        let v0 = MMState{
            id                 : 0x2::object::new(arg2),
            owner              : 0x2::tx_context::sender(arg2),
            registry_id        : 0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::mm_registry::registry_id(arg0),
            current_price      : 0,
            current_spread     : 0,
            price_sequence     : 0,
            execution_count    : 0,
            last_order_time    : 0,
            is_paused          : false,
            pause_until        : 0,
            last_arb_timestamp : 0,
        };
        0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::events::emit_state_created(0x2::object::id<MMState>(&v0), 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
        v0
    }

    public fun current_price(arg0: &MMState) : u64 {
        arg0.current_price
    }

    public fun current_spread(arg0: &MMState) : u64 {
        arg0.current_spread
    }

    public fun execution_count(arg0: &MMState) : u64 {
        arg0.execution_count
    }

    public fun is_paused(arg0: &MMState) : bool {
        arg0.is_paused
    }

    public fun is_trading_blocked(arg0: &MMState, arg1: u64) : bool {
        arg0.is_paused && arg1 < arg0.pause_until
    }

    public fun is_within_cooldown(arg0: &MMState, arg1: u64, arg2: u64) : bool {
        arg1 < arg0.last_order_time + arg2
    }

    public fun last_arb_timestamp(arg0: &MMState) : u64 {
        arg0.last_arb_timestamp
    }

    public fun last_order_time(arg0: &MMState) : u64 {
        arg0.last_order_time
    }

    public fun owner(arg0: &MMState) : address {
        arg0.owner
    }

    public(friend) fun pause(arg0: &mut MMState, arg1: u64, arg2: u64) {
        arg0.is_paused = true;
        arg0.pause_until = arg1;
        0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::events::emit_trading_paused(0x2::object::id<MMState>(arg0), arg1, arg2);
    }

    public fun pause_until(arg0: &MMState) : u64 {
        arg0.pause_until
    }

    public fun price_sequence(arg0: &MMState) : u64 {
        arg0.price_sequence
    }

    public(friend) fun record_arb_time(arg0: &mut MMState, arg1: u64) {
        arg0.last_arb_timestamp = arg1;
    }

    public(friend) fun record_execution(arg0: &mut MMState) {
        arg0.execution_count = arg0.execution_count + 1;
    }

    public(friend) fun record_order_time(arg0: &mut MMState, arg1: u64) {
        arg0.last_order_time = arg1;
    }

    public fun share(arg0: MMState) {
        0x2::transfer::share_object<MMState>(arg0);
    }

    public(friend) fun state_id(arg0: &MMState) : 0x2::object::ID {
        0x2::object::id<MMState>(arg0)
    }

    public(friend) fun unpause(arg0: &mut MMState) {
        arg0.is_paused = false;
        arg0.pause_until = 0;
    }

    public(friend) fun update_price(arg0: &mut MMState, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (arg3 <= arg0.price_sequence) {
            return false
        };
        arg0.current_price = arg1;
        arg0.current_spread = arg2;
        arg0.price_sequence = arg3;
        true
    }

    // decompiled from Move bytecode v6
}

