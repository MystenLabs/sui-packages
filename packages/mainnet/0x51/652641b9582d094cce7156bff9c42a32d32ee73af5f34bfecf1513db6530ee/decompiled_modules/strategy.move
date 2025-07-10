module 0x51652641b9582d094cce7156bff9c42a32d32ee73af5f34bfecf1513db6530ee::strategy {
    struct Strategy has store, key {
        id: 0x2::object::UID,
        config: vector<u8>,
        confirmed_steps: vector<u8>,
        current_index: u8,
        current_loop: u8,
        current_admin: address,
        completed: bool,
        create_timestamp_ms: u64,
        last_update_timestamp_ms: u64,
        admin_caps: 0x2::vec_map::VecMap<address, 0x2::object::ID>,
    }

    struct StrategyAdminCap has store, key {
        id: 0x2::object::UID,
        strategy_id: 0x2::object::ID,
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
        current_admin: address,
        completed: bool,
    }

    struct StrategyAdminCapDroppedEvent has copy, drop {
        sender: address,
        admin_cap_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: address, arg5: bool, arg6: &vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<address>(arg6)) {
            if (*0x1::vector::borrow<address>(arg6, v0) == arg4) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 4 */
                assert!(v1 != 0x1::option::none<u64>(), 400);
                let v2 = Strategy{
                    id                       : 0x2::object::new(arg8),
                    config                   : arg0,
                    confirmed_steps          : arg1,
                    current_index            : arg2,
                    current_loop             : arg3,
                    current_admin            : arg4,
                    completed                : arg5,
                    create_timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
                    last_update_timestamp_ms : 0x2::clock::timestamp_ms(arg7),
                    admin_caps               : 0x2::vec_map::empty<address, 0x2::object::ID>(),
                };
                let v3 = 0x2::object::id<Strategy>(&v2);
                let v4 = 0;
                while (v4 < 0x1::vector::length<address>(arg6)) {
                    let v5 = 0x1::vector::borrow<address>(arg6, v4);
                    let v6 = StrategyAdminCap{
                        id          : 0x2::object::new(arg8),
                        strategy_id : v3,
                    };
                    0x2::vec_map::insert<address, 0x2::object::ID>(&mut v2.admin_caps, *v5, 0x2::object::id<StrategyAdminCap>(&v6));
                    0x2::transfer::public_transfer<StrategyAdminCap>(v6, *v5);
                    v4 = v4 + 1;
                };
                0x2::transfer::share_object<Strategy>(v2);
                let v7 = StrategyOpenedEvent{
                    sender      : 0x2::tx_context::sender(arg8),
                    strategy_id : v3,
                };
                0x2::event::emit<StrategyOpenedEvent>(v7);
                return
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public fun drop_admin_cap(arg0: StrategyAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let StrategyAdminCap {
            id          : v0,
            strategy_id : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = StrategyAdminCapDroppedEvent{
            sender       : 0x2::tx_context::sender(arg1),
            admin_cap_id : 0x2::object::id<StrategyAdminCap>(&arg0),
            strategy_id  : v1,
        };
        0x2::event::emit<StrategyAdminCapDroppedEvent>(v2);
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

    public fun update(arg0: &mut Strategy, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: address, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 404);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg0.current_admin, 403);
        let v1 = 0x2::vec_map::try_get<address, 0x2::object::ID>(&arg0.admin_caps, &arg4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 400);
        arg0.confirmed_steps = arg1;
        arg0.current_index = arg2;
        arg0.current_loop = arg3;
        arg0.current_admin = arg4;
        arg0.completed = arg5;
        arg0.last_update_timestamp_ms = 0x2::clock::timestamp_ms(arg6);
        let v2 = StrategyUpdatedEvent{
            sender        : v0,
            strategy_id   : 0x2::object::id<Strategy>(arg0),
            current_index : arg0.current_index,
            current_loop  : arg0.current_loop,
            current_admin : arg0.current_admin,
            completed     : arg0.completed,
        };
        0x2::event::emit<StrategyUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

