module 0x1dea3d7b68667f34e506e3792b903247ff118a24dd0cc4537a2ecc59972daa65::strategy {
    struct Strategy has store, key {
        id: 0x2::object::UID,
        config: vector<u8>,
        confirmed_steps: vector<u8>,
        current_index: u8,
        current_loop: u8,
        completed: bool,
        create_timestamp_ms: u64,
        last_update_timestamp_ms: u64,
    }

    struct StrategyOpenedEvent has copy, drop {
        sender: address,
        strategy_id: 0x2::object::ID,
    }

    struct StrategyUpdatedEvent has copy, drop {
        sender: address,
        strategy_id: 0x2::object::ID,
        current_index: u8,
        current_loop: u8,
        completed: bool,
    }

    struct StrategyClosedEvent has copy, drop {
        sender: address,
        strategy_id: 0x2::object::ID,
    }

    public fun delete(arg0: Strategy, arg1: &mut 0x2::tx_context::TxContext) {
        let Strategy {
            id                       : v0,
            config                   : _,
            confirmed_steps          : _,
            current_index            : _,
            current_loop             : _,
            completed                : _,
            create_timestamp_ms      : _,
            last_update_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v8 = StrategyClosedEvent{
            sender      : 0x2::tx_context::sender(arg1),
            strategy_id : 0x2::object::id<Strategy>(&arg0),
        };
        0x2::event::emit<StrategyClosedEvent>(v8);
    }

    public fun new(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Strategy {
        let v0 = Strategy{
            id                       : 0x2::object::new(arg2),
            config                   : arg0,
            confirmed_steps          : 0x1::vector::empty<u8>(),
            current_index            : 0,
            current_loop             : 0,
            completed                : false,
            create_timestamp_ms      : 0x2::clock::timestamp_ms(arg1),
            last_update_timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = StrategyOpenedEvent{
            sender      : 0x2::tx_context::sender(arg2),
            strategy_id : 0x2::object::id<Strategy>(&v0),
        };
        0x2::event::emit<StrategyOpenedEvent>(v1);
        v0
    }

    public fun get_completed(arg0: &Strategy) : bool {
        arg0.completed
    }

    public fun get_config(arg0: &Strategy) : vector<u8> {
        arg0.config
    }

    public fun get_confirmed_steps(arg0: &Strategy) : vector<u8> {
        arg0.confirmed_steps
    }

    public fun get_create_timestamp_ms(arg0: &Strategy) : u64 {
        arg0.create_timestamp_ms
    }

    public fun get_current_index(arg0: &Strategy) : u8 {
        arg0.current_index
    }

    public fun get_current_loop(arg0: &Strategy) : u8 {
        arg0.current_loop
    }

    public fun get_last_update_timestamp_ms(arg0: &Strategy) : u64 {
        arg0.last_update_timestamp_ms
    }

    public fun update(arg0: &mut Strategy, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.confirmed_steps = arg1;
        arg0.current_index = arg2;
        arg0.current_loop = arg3;
        arg0.completed = arg4;
        arg0.last_update_timestamp_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = StrategyUpdatedEvent{
            sender        : 0x2::tx_context::sender(arg6),
            strategy_id   : 0x2::object::id<Strategy>(arg0),
            current_index : arg0.current_index,
            current_loop  : arg0.current_loop,
            completed     : arg0.completed,
        };
        0x2::event::emit<StrategyUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

