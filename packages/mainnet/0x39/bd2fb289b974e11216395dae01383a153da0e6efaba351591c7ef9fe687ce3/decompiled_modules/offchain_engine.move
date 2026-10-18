module 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::offchain_engine {
    struct LivePosition has store {
        value: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position,
        opened: u64,
        prev: u64,
        next: u64,
    }

    struct Pending has copy, drop, store {
        prev: u64,
        next: u64,
        submitted: u64,
        value: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position,
        closing: bool,
        target: u64,
        deadline: u64,
        claims: vector<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::ClaimSlice>,
    }

    struct Governance has store {
        package_version: u64,
        due: u64,
        a: vector<u8>,
        b: vector<u8>,
        healthy_since: u64,
        halt_epoch: u64,
    }

    struct AuthorityChanged has copy, drop {
        engine: 0x2::object::ID,
        epoch: u64,
        action: u8,
        effective_at: u64,
    }

    struct State<phantom T0> has key {
        id: 0x2::object::UID,
        governance: Governance,
        exchange: 0x2::object::ID,
        cap: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::EngineCap,
        chain: vector<u8>,
        key_a: vector<u8>,
        key_b: vector<u8>,
        key_epoch: u64,
        guardian: address,
        paused: bool,
        retired: bool,
        retiring: bool,
        security_halt: bool,
        sequence: u64,
        version: u64,
        watermark: u64,
        checkpoint_prices: vector<u64>,
        last_progress: u64,
        active: 0x1::option::Option<0x2::object::ID>,
        positions: 0x2::table::Table<u64, LivePosition>,
        head: u64,
        tail: u64,
        orders: 0x2::table::Table<u64, Pending>,
        close_orders: 0x2::table::Table<u64, u64>,
        due: 0x2::table::Table<u64, u64>,
        owner_pending: 0x2::table::Table<address, u64>,
        pending_opens: u64,
        next_order: u64,
        pending_head: u64,
        pending_tail: u64,
    }

    struct Action has copy, drop, store {
        tick: u64,
        kind: u8,
        id: u64,
        price: u64,
    }

    struct Header has copy, drop, store {
        domain: vector<u8>,
        chain: vector<u8>,
        pool: 0x2::object::ID,
        engine: 0x2::object::ID,
        key_epoch: u64,
        sequence: u64,
        version: u64,
        from: u64,
        to: u64,
        end_prices: vector<u64>,
        count: u64,
        actions_hash: vector<u8>,
        observations_hash: vector<u8>,
        pause_opens: bool,
    }

    struct Frame has key {
        id: 0x2::object::UID,
        package_version: u64,
        creator: address,
        header: Header,
        actions: 0x2::table_vec::TableVec<Action>,
        rolling: vector<u8>,
        covered: 0x2::table::Table<u64, u64>,
        seen: 0x2::table::Table<u64, bool>,
        min_deadline: u64,
        committed: bool,
        cursor: u64,
        prices: 0x2::table::Table<u64, u64>,
        removed: 0x2::table::Table<u64, bool>,
    }

    struct EngineCreated has copy, drop {
        engine: 0x2::object::ID,
        pool: 0x2::object::ID,
        key_a: vector<u8>,
        key_b: vector<u8>,
        chain: vector<u8>,
    }

    struct OrderAccepted has copy, drop {
        engine: 0x2::object::ID,
        id: u64,
        position: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position,
        closing: bool,
        target: u64,
        deadline: u64,
    }

    struct OrderFinished has copy, drop {
        engine: 0x2::object::ID,
        id: u64,
        outcome: u8,
    }

    struct FrameCommitted has copy, drop {
        engine: 0x2::object::ID,
        frame: 0x2::object::ID,
        header: Header,
    }

    struct FrameAdvanced has copy, drop {
        engine: 0x2::object::ID,
        frame: 0x2::object::ID,
        cursor: u64,
        complete: bool,
        watermark: u64,
    }

    struct Retired has copy, drop {
        engine: 0x2::object::ID,
        watermark: u64,
        prices: vector<u64>,
        complete: bool,
    }

    struct ProvisionScan has key {
        id: 0x2::object::UID,
        package_version: u64,
        creator: address,
        engine: 0x2::object::ID,
        version: u64,
        watermark: u64,
        cursor: u64,
        total: u128,
        count: u64,
    }

    struct ProvisionProgress has copy, drop {
        engine: 0x2::object::ID,
        scan: 0x2::object::ID,
        watermark: u64,
        count: u64,
        total: u128,
        complete: bool,
    }

    struct CheckpointFinalized has copy, drop {
        engine: 0x2::object::ID,
        header: Header,
    }

    struct FramePruned has copy, drop {
        engine: 0x2::object::ID,
        frame: 0x2::object::ID,
        remaining_actions: u64,
        deleted: bool,
    }

    struct EmergencyExit has copy, drop, store {
        report: vector<u8>,
        binding: vector<u8>,
        prices: vector<u64>,
        time: u64,
        frame: 0x1::option::Option<0x2::object::ID>,
        cursor: u64,
        complete: bool,
    }

    struct EmergencyExitApproved has copy, drop {
        engine: 0x2::object::ID,
        report: vector<u8>,
        binding: vector<u8>,
        prices: vector<u64>,
        time: u64,
        frame: 0x1::option::Option<0x2::object::ID>,
        cursor: u64,
    }

    struct EmergencyExitAdvanced has copy, drop {
        engine: 0x2::object::ID,
        report: vector<u8>,
        orders_remaining: u64,
        positions_remaining: u64,
        complete: bool,
    }

    struct EmergencyBinding has drop {
        domain: vector<u8>,
        engine: 0x2::object::ID,
        pool: 0x2::object::ID,
        key_epoch: u64,
        halt_epoch: u64,
        sequence: u64,
        version: u64,
        active: 0x1::option::Option<0x2::object::ID>,
        cursor: u64,
        retiring: bool,
        watermark: u64,
        prices: vector<u64>,
        orders: u64,
        positions: u64,
        pending_head: u64,
        head: u64,
    }

    public fun append<T0>(arg0: &State<T0>, arg1: &mut Frame, arg2: vector<u64>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg1.package_version == 1, 900);
        let v0 = if (!arg1.committed) {
            if (0x2::tx_context::sender(arg6) == arg1.creator) {
                if (arg1.header.engine == 0x2::object::id<State<T0>>(arg0)) {
                    if (arg1.header.version == arg0.version) {
                        if (0x1::vector::length<u64>(&arg2) > 0) {
                            if (0x1::vector::length<u64>(&arg2) <= 64) {
                                if (0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u8>(&arg3)) {
                                    if (0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg4)) {
                                        0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg5)
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = Action{
                tick  : *0x1::vector::borrow<u64>(&arg2, v1),
                kind  : *0x1::vector::borrow<u8>(&arg3, v1),
                id    : *0x1::vector::borrow<u64>(&arg4, v1),
                price : *0x1::vector::borrow<u64>(&arg5, v1),
            };
            validate_price(v2.price);
            let v3 = if (v2.tick > arg1.header.from) {
                if (v2.tick <= arg1.header.to) {
                    if (v2.tick % 1000 == 0) {
                        v2.kind <= 2
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 104);
            if (!0x2::table_vec::is_empty<Action>(&arg1.actions)) {
                let v4 = 0x2::table_vec::borrow<Action>(&arg1.actions, 0x2::table_vec::length<Action>(&arg1.actions) - 1);
                assert!(v2.tick > v4.tick || v2.tick == v4.tick && (v2.kind > v4.kind || v2.kind == v4.kind && v2.id > v4.id), 104);
            };
            let v5 = if (v2.kind == 0) {
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_market(&0x2::table::borrow<u64, LivePosition>(&arg0.positions, v2.id).value)
            } else {
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_market(&0x2::table::borrow<u64, Pending>(&arg0.orders, v2.id).value)
            };
            let v6 = v2.tick * 2 + v5;
            if (0x2::table::contains<u64, u64>(&arg1.prices, v6)) {
                assert!(*0x2::table::borrow<u64, u64>(&arg1.prices, v6) == v2.price, 100);
            } else {
                0x2::table::add<u64, u64>(&mut arg1.prices, v6, v2.price);
            };
            if (v2.tick == arg1.header.to) {
                assert!(v2.price == *0x1::vector::borrow<u64>(&arg1.header.end_prices, v5), 100);
            };
            if (v2.kind == 0) {
                assert!(!0x2::table::contains<u64, bool>(&arg1.removed, v2.id), 102);
                0x2::table::add<u64, bool>(&mut arg1.removed, v2.id, true);
                let v7 = if (0x2::table::contains<u64, LivePosition>(&arg0.positions, v2.id)) {
                    if (0x2::table::borrow<u64, LivePosition>(&arg0.positions, v2.id).opened < v2.tick) {
                        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_bust(&0x2::table::borrow<u64, LivePosition>(&arg0.positions, v2.id).value, v2.price)
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v7, 102);
            } else {
                assert!(!0x2::table::contains<u64, bool>(&arg1.seen, v2.id), 102);
                0x2::table::add<u64, bool>(&mut arg1.seen, v2.id, true);
                let v8 = 0x2::table::borrow<u64, Pending>(&arg0.orders, v2.id);
                assert!(v8.target == v2.tick && v8.closing == v2.kind == 1, 102);
                if (v8.closing) {
                    let v9 = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_number(&v8.value);
                    if (!0x2::table::contains<u64, bool>(&arg1.removed, v9) && 0x2::table::contains<u64, LivePosition>(&arg0.positions, v9)) {
                        assert!(!0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_bust(&0x2::table::borrow<u64, LivePosition>(&arg0.positions, v9).value, v2.price), 102);
                        0x2::table::add<u64, bool>(&mut arg1.removed, v9, true);
                    };
                };
                if (!v8.closing && v8.deadline < arg1.min_deadline) {
                    arg1.min_deadline = v8.deadline;
                };
                let v10 = &mut arg1.covered;
                inc(v10, v2.tick);
            };
            let v11 = arg1.rolling;
            0x1::vector::append<u8>(&mut v11, 0x1::bcs::to_bytes<Action>(&v2));
            arg1.rolling = 0x2::hash::blake2b256(&v11);
            0x2::table_vec::push_back<Action>(&mut arg1.actions, v2);
            assert!(0x2::table_vec::length<Action>(&arg1.actions) <= arg1.header.count, 100);
            v1 = v1 + 1;
        };
    }

    public fun acknowledge_security<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (arg1.security_halt) {
            if (0x1::option::is_none<0x2::object::ID>(&arg1.active)) {
                arg1.key_epoch > arg1.governance.halt_epoch
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        arg1.security_halt = false;
        arg1.paused = true;
        arg1.governance.healthy_since = 0;
        let v1 = AuthorityChanged{
            engine       : 0x2::object::id<State<T0>>(arg1),
            epoch        : arg1.key_epoch,
            action       : 5,
            effective_at : 0,
        };
        0x2::event::emit<AuthorityChanged>(v1);
    }

    public fun activate_keys<T0>(arg0: &mut State<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        let v0 = if (arg0.governance.due > 0) {
            if (0x2::clock::timestamp_ms(arg1) >= arg0.governance.due) {
                if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                    if (!arg0.retiring) {
                        !arg0.retired
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        arg0.key_a = arg0.governance.a;
        arg0.key_b = arg0.governance.b;
        arg0.key_epoch = arg0.key_epoch + 1;
        arg0.governance.due = 0;
        arg0.governance.healthy_since = 0;
        arg0.paused = true;
        let v1 = AuthorityChanged{
            engine       : 0x2::object::id<State<T0>>(arg0),
            epoch        : arg0.key_epoch,
            action       : 4,
            effective_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AuthorityChanged>(v1);
    }

    fun add_order<T0>(arg0: &mut State<T0>, arg1: u64, arg2: Pending) {
        if (arg0.pending_tail > 0) {
            0x2::table::borrow_mut<u64, Pending>(&mut arg0.orders, arg0.pending_tail).next = arg1;
        } else {
            arg0.pending_head = arg1;
        };
        0x2::table::add<u64, Pending>(&mut arg0.orders, arg1, arg2);
        arg0.pending_tail = arg1;
    }

    public fun apply<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: &mut Frame, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg2.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = if (!arg0.security_halt) {
            if (arg2.committed) {
                if (0x1::option::is_some<0x2::object::ID>(&arg0.active)) {
                    if (*0x1::option::borrow<0x2::object::ID>(&arg0.active) == 0x2::object::id<Frame>(arg2)) {
                        if (arg3 > 0) {
                            arg3 <= 64
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0;
        while (arg2.cursor < 0x2::table_vec::length<Action>(&arg2.actions) && v1 < arg3) {
            let v2 = *0x2::table_vec::borrow<Action>(&arg2.actions, arg2.cursor);
            if (v2.kind == 0) {
                let v3 = remove_position<T0>(arg0, v2.id);
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_settle<T0>(&arg0.cap, arg1, v3, v2.price, v2.tick, true, arg2.header.sequence, 0x2::tx_context::sender(arg5));
            } else {
                let v4 = remove_order<T0>(arg0, v2.id);
                let v5 = v4.value;
                let v6 = v4.closing;
                let v7 = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_number(&v5);
                if (v6) {
                    if (0x2::table::contains<u64, LivePosition>(&arg0.positions, v7)) {
                        let v8 = remove_position<T0>(arg0, v7);
                        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_settle<T0>(&arg0.cap, arg1, v8, v2.price, v2.tick, false, arg2.header.sequence, 0x2::tx_context::sender(arg5));
                    };
                } else {
                    let v9 = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_fill<T0>(&arg0.cap, arg1, v5, v4.claims, v2.price, v2.tick);
                    insert_position<T0>(arg0, v9, v2.tick);
                };
                let v10 = if (v6) {
                    1
                } else {
                    0
                };
                resolved<T0>(arg0, arg1, v2.id, v4, v10);
                let v11 = OrderFinished{
                    engine  : 0x2::object::id<State<T0>>(arg0),
                    id      : v2.id,
                    outcome : 1,
                };
                0x2::event::emit<OrderFinished>(v11);
            };
            arg2.cursor = arg2.cursor + 1;
            v1 = v1 + 1;
        };
        let v12 = arg2.cursor == 0x2::table_vec::length<Action>(&arg2.actions);
        if (v12) {
            arg0.sequence = arg2.header.sequence;
            arg0.version = arg0.version + 1;
            arg0.watermark = arg2.header.to;
            arg0.checkpoint_prices = arg2.header.end_prices;
            if (0x2::clock::timestamp_ms(arg4) > arg0.last_progress + 15000) {
                arg0.governance.healthy_since = 0;
            };
            arg0.last_progress = 0x2::clock::timestamp_ms(arg4);
            if (arg2.header.pause_opens) {
                arg0.paused = true;
                arg0.governance.healthy_since = 0;
            } else if (arg0.governance.healthy_since == 0) {
                arg0.governance.healthy_since = 0x2::clock::timestamp_ms(arg4);
            };
            arg0.active = 0x1::option::none<0x2::object::ID>();
            0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_finish<T0>(&arg0.cap, arg1, arg0.sequence);
        };
        let v13 = FrameAdvanced{
            engine    : 0x2::object::id<State<T0>>(arg0),
            frame     : 0x2::object::id<Frame>(arg2),
            cursor    : arg2.cursor,
            complete  : v12,
            watermark : arg0.watermark,
        };
        0x2::event::emit<FrameAdvanced>(v13);
    }

    fun approve_emergency<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (arg1.security_halt) {
            if (arg1.paused) {
                if (!arg1.retired) {
                    arg1.retiring || 0x1::option::is_some<0x2::object::ID>(&arg1.active)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = if (arg4 == emergency_binding<T0>(arg1, arg3)) {
            if (0x1::vector::length<u8>(&arg5) == 32) {
                if (0x1::vector::length<u64>(&arg6) == 2) {
                    if (arg7 > 0) {
                        arg7 <= 0x2::clock::timestamp_ms(arg8)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        validate_price(*0x1::vector::borrow<u64>(&arg6, 0));
        validate_price(*0x1::vector::borrow<u64>(&arg6, 1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"emergency_exit_v1"), 100);
        let v2 = EmergencyExit{
            report   : arg5,
            binding  : arg4,
            prices   : arg6,
            time     : arg7,
            frame    : arg1.active,
            cursor   : arg3,
            complete : false,
        };
        0x2::dynamic_field::add<vector<u8>, EmergencyExit>(&mut arg1.id, b"emergency_exit_v1", v2);
        let v3 = EmergencyExitApproved{
            engine  : 0x2::object::id<State<T0>>(arg1),
            report  : arg5,
            binding : arg4,
            prices  : arg6,
            time    : arg7,
            frame   : arg1.active,
            cursor  : arg3,
        };
        0x2::event::emit<EmergencyExitApproved>(v3);
    }

    public fun approve_emergency_frame<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: &Frame, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = if (arg3.committed) {
            if (0x1::option::is_some<0x2::object::ID>(&arg1.active)) {
                if (*0x1::option::borrow<0x2::object::ID>(&arg1.active) == 0x2::object::id<Frame>(arg3)) {
                    if (arg3.header.engine == 0x2::object::id<State<T0>>(arg1)) {
                        arg3.header.sequence == arg1.sequence + 1
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        approve_emergency<T0>(arg0, arg1, arg2, arg3.cursor, arg4, arg5, arg6, arg7, arg8);
    }

    public fun approve_emergency_retirement<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg1.retiring && 0x1::option::is_none<0x2::object::ID>(&arg1.active), 100);
        let v0 = arg1.checkpoint_prices;
        let v1 = arg1.watermark;
        approve_emergency<T0>(arg0, arg1, arg2, 0, arg3, arg4, v0, v1, arg5);
    }

    public fun begin_provision<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (0x1::option::is_none<0x2::object::ID>(&arg1.active)) {
            if (!arg1.retiring) {
                if (!arg1.security_halt) {
                    arg1.watermark > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = ProvisionScan{
            id              : 0x2::object::new(arg3),
            package_version : 1,
            creator         : 0x2::tx_context::sender(arg3),
            engine          : 0x2::object::id<State<T0>>(arg1),
            version         : arg1.version,
            watermark       : arg1.watermark,
            cursor          : arg1.head,
            total           : 0,
            count           : 0,
        };
        0x2::transfer::share_object<ProvisionScan>(v1);
    }

    public fun begin_retirement<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = if (!arg0.security_halt) {
            if (!arg0.retired) {
                if (!arg0.retiring) {
                    if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                        if (arg0.watermark > 0) {
                            0x2::clock::timestamp_ms(arg2) >= arg0.last_progress + 1800000
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        arg0.paused = true;
        arg0.retiring = true;
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_begin<T0>(&arg0.cap, arg1, arg0.sequence + 1);
        let v1 = Retired{
            engine    : 0x2::object::id<State<T0>>(arg0),
            watermark : arg0.watermark,
            prices    : arg0.checkpoint_prices,
            complete  : false,
        };
        0x2::event::emit<Retired>(v1);
    }

    public fun checkpoint<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u8>, arg5: bool, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
            if (!arg0.retired) {
                if (!arg0.retiring) {
                    !arg0.security_halt
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = if (arg2 % 1000 == 0) {
            if (arg2 > arg0.watermark) {
                if (arg2 + 1000 <= v1) {
                    arg0.watermark == 0 || arg2 - arg0.watermark <= 60000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 103);
        assert!(0x1::vector::length<u64>(&arg3) == 2 && 0x1::vector::length<u8>(&arg4) == 32, 100);
        validate_price(*0x1::vector::borrow<u64>(&arg3, 0));
        validate_price(*0x1::vector::borrow<u64>(&arg3, 1));
        let v3 = if (arg0.watermark == 0) {
            arg2
        } else {
            arg0.watermark + 1000
        };
        let v4 = v3;
        while (v4 <= arg2) {
            assert!(count(&arg0.due, v4) == 0, 106);
            v4 = v4 + 1000;
        };
        let v5 = b"REKT_ACTIONS_V1";
        let v6 = Header{
            domain            : b"REKT_OFFCHAIN_V1_FRAME",
            chain             : arg0.chain,
            pool              : arg0.exchange,
            engine            : 0x2::object::id<State<T0>>(arg0),
            key_epoch         : arg0.key_epoch,
            sequence          : arg0.sequence + 1,
            version           : arg0.version,
            from              : arg0.watermark,
            to                : arg2,
            end_prices        : arg3,
            count             : 0,
            actions_hash      : 0x2::hash::blake2b256(&v5),
            observations_hash : arg4,
            pause_opens       : arg5,
        };
        let v7 = 0x1::bcs::to_bytes<Header>(&v6);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.key_a, &v7) && 0x2::ed25519::ed25519_verify(&arg7, &arg0.key_b, &v7), 101);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_begin<T0>(&arg0.cap, arg1, v6.sequence);
        arg0.sequence = v6.sequence;
        arg0.version = arg0.version + 1;
        arg0.watermark = arg2;
        arg0.checkpoint_prices = arg3;
        if (v1 > arg0.last_progress + 15000) {
            arg0.governance.healthy_since = 0;
        };
        arg0.last_progress = v1;
        if (arg5) {
            arg0.paused = true;
            arg0.governance.healthy_since = 0;
        } else if (arg0.governance.healthy_since == 0) {
            arg0.governance.healthy_since = v1;
        };
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_finish<T0>(&arg0.cap, arg1, arg0.sequence);
        let v8 = CheckpointFinalized{
            engine : 0x2::object::id<State<T0>>(arg0),
            header : v6,
        };
        0x2::event::emit<CheckpointFinalized>(v8);
    }

    public fun commit<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: &mut Frame, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg2.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = if (!arg0.security_halt) {
            if (!arg0.retired) {
                if (!arg0.retiring) {
                    if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                        !arg2.committed
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = &arg2.header;
        let v2 = if (v1.engine == 0x2::object::id<State<T0>>(arg0)) {
            if (v1.pool == arg0.exchange) {
                if (v1.chain == arg0.chain) {
                    if (v1.key_epoch == arg0.key_epoch) {
                        if (v1.sequence == arg0.sequence + 1) {
                            if (v1.version == arg0.version) {
                                v1.from == arg0.watermark
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = if (0x2::table_vec::length<Action>(&arg2.actions) == v1.count) {
            if (arg2.rolling == v1.actions_hash) {
                0x2::clock::timestamp_ms(arg5) <= arg2.min_deadline
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 106);
        let v4 = if (arg0.watermark == 0) {
            v1.to
        } else {
            arg0.watermark + 1000
        };
        let v5 = v4;
        while (v5 <= v1.to) {
            assert!(count(&arg0.due, v5) == count(&arg2.covered, v5), 106);
            v5 = v5 + 1000;
        };
        let v6 = signing_bytes(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.key_a, &v6) && 0x2::ed25519::ed25519_verify(&arg4, &arg0.key_b, &v6), 101);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_begin<T0>(&arg0.cap, arg1, v1.sequence);
        arg0.active = 0x1::option::some<0x2::object::ID>(0x2::object::id<Frame>(arg2));
        arg2.committed = true;
        let v7 = FrameCommitted{
            engine : 0x2::object::id<State<T0>>(arg0),
            frame  : 0x2::object::id<Frame>(arg2),
            header : arg2.header,
        };
        0x2::event::emit<FrameCommitted>(v7);
    }

    fun count(arg0: &0x2::table::Table<u64, u64>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow<u64, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun create<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::length<u8>(&arg2) > 0) {
            if (0x1::vector::length<u8>(&arg3) == 32) {
                if (0x1::vector::length<u8>(&arg4) == 32) {
                    if (arg3 != arg4) {
                        arg5 != @0x0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        share_state<T0>(0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_enable<T0>(arg0, arg1), 0x2::object::id<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>>(arg1), arg2, arg3, arg4, arg5, 0, arg6);
    }

    fun dec(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64) {
        let v0 = *0x2::table::borrow<u64, u64>(arg0, arg1);
        if (v0 == 1) {
            0x2::table::remove<u64, u64>(arg0, arg1);
        } else {
            *0x2::table::borrow_mut<u64, u64>(arg0, arg1) = v0 - 1;
        };
    }

    public fun destroy_frame<T0>(arg0: &mut State<T0>, arg1: Frame) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg1.package_version == 1, 900);
        obsolete<T0>(arg0, &arg1);
        let Frame {
            id              : v0,
            package_version : _,
            creator         : _,
            header          : _,
            actions         : v4,
            rolling         : _,
            covered         : v6,
            seen            : v7,
            min_deadline    : _,
            committed       : _,
            cursor          : _,
            prices          : v11,
            removed         : v12,
        } = arg1;
        0x2::table_vec::destroy_empty<Action>(v4);
        0x2::table::destroy_empty<u64, u64>(v6);
        0x2::table::destroy_empty<u64, bool>(v7);
        0x2::table::destroy_empty<u64, u64>(v11);
        0x2::table::destroy_empty<u64, bool>(v12);
        0x2::object::delete(v0);
        let v13 = FramePruned{
            engine            : 0x2::object::id<State<T0>>(arg0),
            frame             : 0x2::object::id<Frame>(&arg1),
            remaining_actions : 0,
            deleted           : true,
        };
        0x2::event::emit<FramePruned>(v13);
    }

    public fun discard_provision(arg0: ProvisionScan, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 100);
        let ProvisionScan {
            id              : v0,
            package_version : _,
            creator         : _,
            engine          : _,
            version         : _,
            watermark       : _,
            cursor          : _,
            total           : _,
            count           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emergency_binding<T0>(arg0: &State<T0>, arg1: u64) : vector<u8> {
        let v0 = EmergencyBinding{
            domain       : b"REKT_EMERGENCY_EXIT_V1",
            engine       : 0x2::object::id<State<T0>>(arg0),
            pool         : arg0.exchange,
            key_epoch    : arg0.key_epoch,
            halt_epoch   : arg0.governance.halt_epoch,
            sequence     : arg0.sequence,
            version      : arg0.version,
            active       : arg0.active,
            cursor       : arg1,
            retiring     : arg0.retiring,
            watermark    : arg0.watermark,
            prices       : arg0.checkpoint_prices,
            orders       : 0x2::table::length<u64, Pending>(&arg0.orders),
            positions    : 0x2::table::length<u64, LivePosition>(&arg0.positions),
            pending_head : arg0.pending_head,
            head         : arg0.head,
        };
        let v1 = 0x1::bcs::to_bytes<EmergencyBinding>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun emergency_exit_step<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (arg1.security_halt) {
            if (arg1.paused) {
                if (!arg1.retired) {
                    if (arg4 > 0) {
                        arg4 <= 64
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = *0x2::dynamic_field::borrow<vector<u8>, EmergencyExit>(&arg1.id, b"emergency_exit_v1");
        let v2 = if (!v1.complete) {
            if (v1.report == arg3) {
                v1.frame == arg1.active
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = 0;
        while (arg1.pending_head > 0 && v3 < arg4) {
            let v4 = arg1.pending_head;
            let v5 = remove_order<T0>(arg1, v4);
            if (!v5.closing) {
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_emergency_refund<T0>(&arg1.cap, arg2, v5.value, v5.claims, arg1.sequence + 1);
            };
            resolved<T0>(arg1, arg2, v4, v5, 2);
            let v6 = OrderFinished{
                engine  : 0x2::object::id<State<T0>>(arg1),
                id      : v4,
                outcome : 3,
            };
            0x2::event::emit<OrderFinished>(v6);
            v3 = v3 + 1;
        };
        loop {
            let v7 = if (arg1.pending_head == 0) {
                if (arg1.head > 0) {
                    v3 < arg4
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                let v8 = arg1.head;
                let v9 = remove_position<T0>(arg1, v8);
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_settle<T0>(&arg1.cap, arg2, v9, *0x1::vector::borrow<u64>(&v1.prices, 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_market(&v9)), v1.time, false, arg1.sequence + 1, 0x2::tx_context::sender(arg5));
                v3 = v3 + 1;
            } else {
                break
            };
        };
        let v10 = arg1.pending_head == 0 && arg1.head == 0;
        if (v10) {
            let v11 = if (0x2::table::is_empty<u64, Pending>(&arg1.orders)) {
                if (0x2::table::is_empty<u64, LivePosition>(&arg1.positions)) {
                    if (0x2::table::is_empty<u64, u64>(&arg1.close_orders)) {
                        if (0x2::table::is_empty<u64, u64>(&arg1.due)) {
                            arg1.pending_opens == 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v11, 106);
            arg1.active = 0x1::option::none<0x2::object::ID>();
            arg1.retiring = false;
            arg1.retired = true;
            arg1.sequence = arg1.sequence + 1;
            arg1.version = arg1.version + 1;
            arg1.watermark = v1.time;
            arg1.checkpoint_prices = v1.prices;
            0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_emergency_finish<T0>(&arg1.cap, arg2, arg1.sequence);
            0x2::dynamic_field::borrow_mut<vector<u8>, EmergencyExit>(&mut arg1.id, b"emergency_exit_v1").complete = true;
            let v12 = Retired{
                engine    : 0x2::object::id<State<T0>>(arg1),
                watermark : v1.time,
                prices    : v1.prices,
                complete  : true,
            };
            0x2::event::emit<Retired>(v12);
        };
        let v13 = EmergencyExitAdvanced{
            engine              : 0x2::object::id<State<T0>>(arg1),
            report              : arg3,
            orders_remaining    : 0x2::table::length<u64, Pending>(&arg1.orders),
            positions_remaining : 0x2::table::length<u64, LivePosition>(&arg1.positions),
            complete            : v10,
        };
        0x2::event::emit<EmergencyExitAdvanced>(v13);
    }

    public fun expire<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active) && !arg0.retiring, 100);
        let v0 = 0x2::table::borrow<u64, Pending>(&arg0.orders, arg2);
        assert!(!v0.closing && 0x2::clock::timestamp_ms(arg3) > v0.deadline, 103);
        let v1 = remove_order<T0>(arg0, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_refund<T0>(&arg0.cap, arg1, v1.value, v1.claims);
        resolved<T0>(arg0, arg1, arg2, v1, 2);
        arg0.version = arg0.version + 1;
        let v2 = OrderFinished{
            engine  : 0x2::object::id<State<T0>>(arg0),
            id      : arg2,
            outcome : 2,
        };
        0x2::event::emit<OrderFinished>(v2);
    }

    fun inc(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64) {
        if (!0x2::table::contains<u64, u64>(arg0, arg1)) {
            0x2::table::add<u64, u64>(arg0, arg1, 0);
        };
        *0x2::table::borrow_mut<u64, u64>(arg0, arg1) = *0x2::table::borrow<u64, u64>(arg0, arg1) + 1;
    }

    fun insert_position<T0>(arg0: &mut State<T0>, arg1: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position, arg2: u64) {
        let v0 = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_number(&arg1);
        let v1 = arg0.tail;
        if (v1 > 0) {
            assert!(v0 > v1, 104);
            0x2::table::borrow_mut<u64, LivePosition>(&mut arg0.positions, v1).next = v0;
        } else {
            arg0.head = v0;
        };
        let v2 = LivePosition{
            value  : arg1,
            opened : arg2,
            prev   : v1,
            next   : 0,
        };
        0x2::table::add<u64, LivePosition>(&mut arg0.positions, v0, v2);
        arg0.tail = v0;
    }

    public fun migrate_frame<T0>(arg0: &State<T0>, arg1: &mut Frame) {
        assert!(arg0.governance.package_version == 1 && arg1.package_version < 1, 900);
        obsolete<T0>(arg0, arg1);
        arg1.package_version = 1;
    }

    public fun migrate_package<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>) {
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (arg1.exchange == 0x2::object::id<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>>(arg2)) {
            if (arg1.governance.package_version < 1) {
                if (0x1::option::is_none<0x2::object::ID>(&arg1.active)) {
                    !arg1.retiring
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 900);
        arg1.governance.package_version = 1;
        arg1.version = arg1.version + 1;
    }

    public fun migrate_scan<T0>(arg0: &State<T0>, arg1: &mut ProvisionScan) {
        let v0 = if (arg0.governance.package_version == 1) {
            if (arg1.engine == 0x2::object::id<State<T0>>(arg0)) {
                arg1.package_version < 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 900);
        arg1.package_version = 1;
    }

    public fun next_generation<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &State<T0>, arg2: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        let v0 = if (arg1.retired) {
            if (!arg1.retiring) {
                if (0x1::option::is_none<0x2::object::ID>(&arg1.active)) {
                    if (0x2::table::is_empty<u64, LivePosition>(&arg1.positions)) {
                        0x2::table::is_empty<u64, Pending>(&arg1.orders)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                if (arg3 != arg4) {
                    arg5 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        share_state<T0>(0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_handoff<T0>(arg0, &arg1.cap, arg2), arg1.exchange, arg1.chain, arg3, arg4, arg5, arg1.sequence, arg6);
    }

    fun notice<T0>(arg0: &State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: u8) {
        resolved<T0>(arg0, arg1, arg2, *0x2::table::borrow<u64, Pending>(&arg0.orders, arg2), arg3);
    }

    fun obsolete<T0>(arg0: &State<T0>, arg1: &Frame) {
        assert!(arg1.header.engine == 0x2::object::id<State<T0>>(arg0), 100);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active) || *0x1::option::borrow<0x2::object::ID>(&arg0.active) != 0x2::object::id<Frame>(arg1), 100);
        let v0 = if (arg1.committed) {
            arg0.sequence >= arg1.header.sequence
        } else if (arg0.version != arg1.header.version) {
            true
        } else if (arg0.key_epoch != arg1.header.key_epoch) {
            true
        } else {
            arg0.retired
        };
        assert!(v0, 100);
    }

    fun pair<T0>(arg0: &State<T0>, arg1: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>) {
        assert!(arg0.exchange == 0x2::object::id<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>>(arg1), 100);
    }

    public fun pause<T0>(arg0: &mut State<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg2) == arg0.guardian, 100);
        arg0.paused = true;
        arg0.governance.healthy_since = 0;
        if (arg1) {
            arg0.security_halt = true;
            arg0.governance.halt_epoch = arg0.key_epoch;
        };
        let v0 = if (arg1) {
            2
        } else {
            1
        };
        let v1 = AuthorityChanged{
            engine       : 0x2::object::id<State<T0>>(arg0),
            epoch        : arg0.key_epoch,
            action       : v0,
            effective_at : 0,
        };
        0x2::event::emit<AuthorityChanged>(v1);
    }

    public fun position_count<T0>(arg0: &State<T0>) : u64 {
        assert!(arg0.governance.package_version == 1, 900);
        0x2::table::length<u64, LivePosition>(&arg0.positions)
    }

    public fun positions_page<T0>(arg0: &State<T0>, arg1: u64, arg2: u64) : vector<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position> {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg2 > 0 && arg2 <= 100, 100);
        let v0 = if (arg1 == 0) {
            arg0.head
        } else {
            0x2::table::borrow<u64, LivePosition>(&arg0.positions, arg1).next
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position>();
        while (v1 > 0 && 0x1::vector::length<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position>(&v2) < arg2) {
            let v3 = 0x2::table::borrow<u64, LivePosition>(&arg0.positions, v1);
            0x1::vector::push_back<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position>(&mut v2, v3.value);
            v1 = v3.next;
        };
        v2
    }

    public fun prepare<T0>(arg0: &State<T0>, arg1: u64, arg2: vector<u64>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        let v0 = if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
            if (!arg0.retired) {
                if (!arg0.retiring) {
                    !arg0.security_halt
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = if (arg1 % 1000 == 0) {
            if (arg1 > arg0.watermark) {
                if (arg1 + 1000 <= 0x2::clock::timestamp_ms(arg7)) {
                    arg0.watermark == 0 || arg1 - arg0.watermark <= 60000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 103);
        let v2 = if (0x1::vector::length<u64>(&arg2) == 2) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                if (0x1::vector::length<u8>(&arg5) == 32) {
                    arg3 <= 30000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        validate_price(*0x1::vector::borrow<u64>(&arg2, 0));
        validate_price(*0x1::vector::borrow<u64>(&arg2, 1));
        let v3 = Header{
            domain            : b"REKT_OFFCHAIN_V1_FRAME",
            chain             : arg0.chain,
            pool              : arg0.exchange,
            engine            : 0x2::object::id<State<T0>>(arg0),
            key_epoch         : arg0.key_epoch,
            sequence          : arg0.sequence + 1,
            version           : arg0.version,
            from              : arg0.watermark,
            to                : arg1,
            end_prices        : arg2,
            count             : arg3,
            actions_hash      : arg4,
            observations_hash : arg5,
            pause_opens       : arg6,
        };
        let v4 = b"REKT_ACTIONS_V1";
        let v5 = Frame{
            id              : 0x2::object::new(arg8),
            package_version : 1,
            creator         : 0x2::tx_context::sender(arg8),
            header          : v3,
            actions         : 0x2::table_vec::empty<Action>(arg8),
            rolling         : 0x2::hash::blake2b256(&v4),
            covered         : 0x2::table::new<u64, u64>(arg8),
            seen            : 0x2::table::new<u64, bool>(arg8),
            min_deadline    : 18446744073709551615,
            committed       : false,
            cursor          : 0,
            prices          : 0x2::table::new<u64, u64>(arg8),
            removed         : 0x2::table::new<u64, bool>(arg8),
        };
        0x2::transfer::share_object<Frame>(v5);
    }

    public fun propose_keys<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                arg3 != arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        arg1.governance.a = arg3;
        arg1.governance.b = arg4;
        arg1.governance.due = 0x2::clock::timestamp_ms(arg5) + 86400000;
        let v1 = AuthorityChanged{
            engine       : 0x2::object::id<State<T0>>(arg1),
            epoch        : arg1.key_epoch,
            action       : 3,
            effective_at : arg1.governance.due,
        };
        0x2::event::emit<AuthorityChanged>(v1);
    }

    public fun prune_frame<T0>(arg0: &mut State<T0>, arg1: &mut Frame, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg1.package_version == 1, 900);
        obsolete<T0>(arg0, arg1);
        assert!(arg2 + 0x1::vector::length<u64>(&arg3) + 0x1::vector::length<u64>(&arg4) + 0x1::vector::length<u64>(&arg5) + 0x1::vector::length<u64>(&arg6) > 0 && arg2 + 0x1::vector::length<u64>(&arg3) + 0x1::vector::length<u64>(&arg4) + 0x1::vector::length<u64>(&arg5) + 0x1::vector::length<u64>(&arg6) <= 64, 100);
        let v0 = 0;
        while (v0 < arg2 && !0x2::table_vec::is_empty<Action>(&arg1.actions)) {
            0x2::table_vec::pop_back<Action>(&mut arg1.actions);
            v0 = v0 + 1;
        };
        0x1::vector::reverse<u64>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            if (0x2::table::contains<u64, u64>(&arg1.covered, v2)) {
                0x2::table::remove<u64, u64>(&mut arg1.covered, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::reverse<u64>(&mut arg4);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg4)) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg4);
            if (0x2::table::contains<u64, bool>(&arg1.seen, v4)) {
                0x2::table::remove<u64, bool>(&mut arg1.seen, v4);
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg4);
        0x1::vector::reverse<u64>(&mut arg5);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg5)) {
            let v6 = 0x1::vector::pop_back<u64>(&mut arg5);
            if (0x2::table::contains<u64, u64>(&arg1.prices, v6)) {
                0x2::table::remove<u64, u64>(&mut arg1.prices, v6);
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg5);
        0x1::vector::reverse<u64>(&mut arg6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg6)) {
            let v8 = 0x1::vector::pop_back<u64>(&mut arg6);
            if (0x2::table::contains<u64, bool>(&arg1.removed, v8)) {
                0x2::table::remove<u64, bool>(&mut arg1.removed, v8);
            };
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg6);
        let v9 = FramePruned{
            engine            : 0x2::object::id<State<T0>>(arg0),
            frame             : 0x2::object::id<Frame>(arg1),
            remaining_actions : 0x2::table_vec::length<Action>(&arg1.actions),
            deleted           : false,
        };
        0x2::event::emit<FramePruned>(v9);
    }

    fun remove_order<T0>(arg0: &mut State<T0>, arg1: u64) : Pending {
        let v0 = 0x2::table::remove<u64, Pending>(&mut arg0.orders, arg1);
        let v1 = &mut arg0.due;
        dec(v1, v0.target);
        if (v0.prev > 0) {
            0x2::table::borrow_mut<u64, Pending>(&mut arg0.orders, v0.prev).next = v0.next;
        } else {
            arg0.pending_head = v0.next;
        };
        if (v0.next > 0) {
            0x2::table::borrow_mut<u64, Pending>(&mut arg0.orders, v0.next).prev = v0.prev;
        } else {
            arg0.pending_tail = v0.prev;
        };
        if (v0.closing) {
            0x2::table::remove<u64, u64>(&mut arg0.close_orders, 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_number(&v0.value));
        } else {
            let v2 = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_owner(&v0.value);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.owner_pending, v2) = *0x2::table::borrow<address, u64>(&arg0.owner_pending, v2) - 1;
            arg0.pending_opens = arg0.pending_opens - 1;
        };
        v0
    }

    fun remove_position<T0>(arg0: &mut State<T0>, arg1: u64) : 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Position {
        let LivePosition {
            value  : v0,
            opened : _,
            prev   : v2,
            next   : v3,
        } = 0x2::table::remove<u64, LivePosition>(&mut arg0.positions, arg1);
        if (v2 > 0) {
            0x2::table::borrow_mut<u64, LivePosition>(&mut arg0.positions, v2).next = v3;
        } else {
            arg0.head = v3;
        };
        if (v3 > 0) {
            0x2::table::borrow_mut<u64, LivePosition>(&mut arg0.positions, v3).prev = v2;
        } else {
            arg0.tail = v2;
        };
        v0
    }

    public fun request_close<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        let v0 = if (!arg0.retired) {
            if (!arg0.retiring) {
                if (!arg0.security_halt) {
                    if (0x2::table::contains<u64, LivePosition>(&arg0.positions, arg2)) {
                        !0x2::table::contains<u64, u64>(&arg0.close_orders, arg2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 102);
        pair<T0>(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, LivePosition>(&arg0.positions, arg2).value;
        assert!(0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_owner(&v1) == 0x2::tx_context::sender(arg4), 102);
        let v2 = arg0.next_order;
        arg0.next_order = v2 + 1;
        let v3 = target(0x2::clock::timestamp_ms(arg3));
        0x2::table::add<u64, u64>(&mut arg0.close_orders, arg2, v2);
        let v4 = Pending{
            prev      : arg0.pending_tail,
            next      : 0,
            submitted : 0x2::clock::timestamp_ms(arg3),
            value     : v1,
            closing   : true,
            target    : v3,
            deadline  : 0,
            claims    : 0x1::vector::empty<0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::ClaimSlice>(),
        };
        add_order<T0>(arg0, v2, v4);
        let v5 = &mut arg0.due;
        inc(v5, v3);
        let v6 = OrderAccepted{
            engine   : 0x2::object::id<State<T0>>(arg0),
            id       : v2,
            position : v1,
            closing  : true,
            target   : v3,
            deadline : 0,
        };
        0x2::event::emit<OrderAccepted>(v6);
        arg0.version = arg0.version + 1;
        notice<T0>(arg0, arg1, v2, 255);
    }

    public fun request_open<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = if (!arg0.paused) {
            if (!arg0.retired) {
                if (!arg0.retiring) {
                    if (!arg0.security_halt) {
                        if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                            if (arg0.watermark > 0) {
                                if (v0 >= arg0.watermark) {
                                    v0 - arg0.watermark <= 15000
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        assert!(0x2::table::length<u64, LivePosition>(&arg0.positions) + arg0.pending_opens < 10000, 105);
        let v2 = 0x2::tx_context::sender(arg8);
        if (!0x2::table::contains<address, u64>(&arg0.owner_pending, v2)) {
            0x2::table::add<address, u64>(&mut arg0.owner_pending, v2, 0);
        };
        assert!(*0x2::table::borrow<address, u64>(&arg0.owner_pending, v2) < 3, 105);
        let (v3, v4) = 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_lock<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v5 = arg0.next_order;
        arg0.next_order = v5 + 1;
        let v6 = target(v0);
        let v7 = v6 + 30000;
        let v8 = OrderAccepted{
            engine   : 0x2::object::id<State<T0>>(arg0),
            id       : v5,
            position : v3,
            closing  : false,
            target   : v6,
            deadline : v7,
        };
        0x2::event::emit<OrderAccepted>(v8);
        let v9 = Pending{
            prev      : arg0.pending_tail,
            next      : 0,
            submitted : v0,
            value     : v3,
            closing   : false,
            target    : v6,
            deadline  : v7,
            claims    : v4,
        };
        add_order<T0>(arg0, v5, v9);
        let v10 = &mut arg0.due;
        inc(v10, v6);
        arg0.pending_opens = arg0.pending_opens + 1;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.owner_pending, v2) = *0x2::table::borrow<address, u64>(&arg0.owner_pending, v2) + 1;
        arg0.version = arg0.version + 1;
        notice<T0>(arg0, arg1, v5, 255);
    }

    fun resolved<T0>(arg0: &State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: Pending, arg4: u8) {
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_order_event<T0>(&arg0.cap, arg1, arg2, arg3.value, arg3.closing, arg3.submitted, arg3.target, arg3.deadline, arg3.claims, arg4);
    }

    public fun resume<T0>(arg0: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::AdminCap<T0>, arg1: &mut State<T0>, arg2: &0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg1.governance.package_version == 1, 900);
        pair<T0>(arg1, arg2);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_admin<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg1.paused) {
            if (!arg1.security_halt) {
                if (!arg1.retired) {
                    if (!arg1.retiring) {
                        if (0x1::option::is_none<0x2::object::ID>(&arg1.active)) {
                            if (arg1.governance.healthy_since > 0) {
                                if (v0 >= arg1.governance.healthy_since + 60000) {
                                    if (v0 >= arg1.watermark) {
                                        v0 - arg1.watermark <= 15000
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        arg1.paused = false;
        let v2 = AuthorityChanged{
            engine       : 0x2::object::id<State<T0>>(arg1),
            epoch        : arg1.key_epoch,
            action       : 6,
            effective_at : v0,
        };
        0x2::event::emit<AuthorityChanged>(v2);
    }

    public fun retire_step<T0>(arg0: &mut State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.governance.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = if (arg0.retiring) {
            if (!arg0.security_halt) {
                if (arg2 > 0) {
                    arg2 <= 64
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0;
        while (arg0.pending_head > 0 && v1 < arg2) {
            let v2 = arg0.pending_head;
            v1 = v1 + 1;
            let v3 = remove_order<T0>(arg0, v2);
            if (!v3.closing) {
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_refund<T0>(&arg0.cap, arg1, v3.value, v3.claims);
            };
            resolved<T0>(arg0, arg1, v2, v3, 2);
            let v4 = OrderFinished{
                engine  : 0x2::object::id<State<T0>>(arg0),
                id      : v2,
                outcome : 3,
            };
            0x2::event::emit<OrderFinished>(v4);
        };
        loop {
            let v5 = if (arg0.pending_head == 0) {
                if (arg0.head > 0) {
                    v1 < arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                let v6 = arg0.head;
                let v7 = remove_position<T0>(arg0, v6);
                let v8 = *0x1::vector::borrow<u64>(&arg0.checkpoint_prices, 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_market(&v7));
                assert!(!0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_bust(&v7, v8), 106);
                0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_settle<T0>(&arg0.cap, arg1, v7, v8, arg0.watermark, false, arg0.sequence + 1, 0x2::tx_context::sender(arg3));
                v1 = v1 + 1;
            } else {
                break
            };
        };
        if (arg0.pending_head == 0 && arg0.head == 0) {
            arg0.retiring = false;
            arg0.retired = true;
            arg0.sequence = arg0.sequence + 1;
            arg0.version = arg0.version + 1;
            0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_finish<T0>(&arg0.cap, arg1, arg0.sequence);
            let v9 = Retired{
                engine    : 0x2::object::id<State<T0>>(arg0),
                watermark : arg0.watermark,
                prices    : arg0.checkpoint_prices,
                complete  : true,
            };
            0x2::event::emit<Retired>(v9);
        };
    }

    public fun scan_provision<T0>(arg0: &State<T0>, arg1: &mut ProvisionScan, arg2: u64) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg1.package_version == 1, 900);
        let v0 = if (arg1.engine == 0x2::object::id<State<T0>>(arg0)) {
            if (arg1.version == arg0.version) {
                if (arg1.watermark == arg0.watermark) {
                    if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                        if (!arg0.retiring) {
                            if (!arg0.security_halt) {
                                if (arg2 > 0) {
                                    arg2 <= 64
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0;
        while (arg1.cursor > 0 && v1 < arg2) {
            let v2 = 0x2::table::borrow<u64, LivePosition>(&arg0.positions, arg1.cursor);
            arg1.total = arg1.total + 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_provision(&v2.value, *0x1::vector::borrow<u64>(&arg0.checkpoint_prices, 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::position_market(&v2.value)));
            arg1.cursor = v2.next;
            arg1.count = arg1.count + 1;
            v1 = v1 + 1;
        };
        let v3 = ProvisionProgress{
            engine    : 0x2::object::id<State<T0>>(arg0),
            scan      : 0x2::object::id<ProvisionScan>(arg1),
            watermark : arg1.watermark,
            count     : arg1.count,
            total     : arg1.total,
            complete  : arg1.cursor == 0,
        };
        0x2::event::emit<ProvisionProgress>(v3);
    }

    fun share_state<T0>(arg0: 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::EngineCap, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Governance{
            package_version : 1,
            due             : 0,
            a               : b"",
            b               : b"",
            healthy_since   : 0,
            halt_epoch      : 0,
        };
        let v1 = State<T0>{
            id                : 0x2::object::new(arg7),
            governance        : v0,
            exchange          : arg1,
            cap               : arg0,
            chain             : arg2,
            key_a             : arg3,
            key_b             : arg4,
            key_epoch         : 1,
            guardian          : arg5,
            paused            : false,
            retired           : false,
            retiring          : false,
            security_halt     : false,
            sequence          : arg6,
            version           : 0,
            watermark         : 0,
            checkpoint_prices : vector[0, 0],
            last_progress     : 0,
            active            : 0x1::option::none<0x2::object::ID>(),
            positions         : 0x2::table::new<u64, LivePosition>(arg7),
            head              : 0,
            tail              : 0,
            orders            : 0x2::table::new<u64, Pending>(arg7),
            close_orders      : 0x2::table::new<u64, u64>(arg7),
            due               : 0x2::table::new<u64, u64>(arg7),
            owner_pending     : 0x2::table::new<address, u64>(arg7),
            pending_opens     : 0,
            next_order        : 1,
            pending_head      : 0,
            pending_tail      : 0,
        };
        let v2 = EngineCreated{
            engine : 0x2::object::id<State<T0>>(&v1),
            pool   : v1.exchange,
            key_a  : v1.key_a,
            key_b  : v1.key_b,
            chain  : v1.chain,
        };
        0x2::event::emit<EngineCreated>(v2);
        0x2::transfer::share_object<State<T0>>(v1);
    }

    public fun signing_bytes(arg0: &Frame) : vector<u8> {
        assert!(arg0.package_version == 1, 900);
        0x1::bcs::to_bytes<Header>(&arg0.header)
    }

    public fun start_dividend<T0>(arg0: &State<T0>, arg1: &mut 0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::Exchange<T0>, arg2: &ProvisionScan, arg3: &0x2::clock::Clock) {
        assert!(arg0.governance.package_version == 1, 900);
        assert!(arg2.package_version == 1, 900);
        pair<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg2.engine == 0x2::object::id<State<T0>>(arg0)) {
            if (arg2.version == arg0.version) {
                if (arg2.watermark == arg0.watermark) {
                    if (arg2.cursor == 0) {
                        if (arg2.count == 0x2::table::length<u64, LivePosition>(&arg0.positions)) {
                            if (0x1::option::is_none<0x2::object::ID>(&arg0.active)) {
                                if (!arg0.retiring) {
                                    !arg0.security_halt
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        assert!(arg0.retired || v0 >= arg0.watermark && v0 - arg0.watermark <= 15000, 103);
        0x39bd2fb289b974e11216395dae01383a153da0e6efaba351591c7ef9fe687ce3::exchange::engine_epoch<T0>(&arg0.cap, arg1, arg2.total, arg2.watermark);
    }

    fun target(arg0: u64) : u64 {
        (arg0 + 1999) / 1000 * 1000
    }

    fun validate_price(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 1000000000000000, 100);
    }

    // decompiled from Move bytecode v7
}

