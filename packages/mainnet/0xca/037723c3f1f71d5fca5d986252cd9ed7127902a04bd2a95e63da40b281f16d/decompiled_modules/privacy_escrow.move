module 0xca037723c3f1f71d5fca5d986252cd9ed7127902a04bd2a95e63da40b281f16d::privacy_escrow {
    struct RelayerCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
    }

    struct PrivacyOrder<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        balance: 0x2::balance::Balance<T0>,
        current_hop: u8,
        total_hops: u8,
        last_action_ms: u64,
        next_delay_ms: u64,
        in_output_phase: bool,
        outputs_sent: u8,
        total_outputs: u8,
        completed: bool,
    }

    struct OrderCreated has copy, drop {
        order_id: address,
    }

    struct HopExecuted has copy, drop {
        order_id: address,
        hop: u8,
    }

    struct OutputPhaseStarted has copy, drop {
        order_id: address,
    }

    struct OutputSent has copy, drop {
        order_id: address,
        output_num: u8,
    }

    struct OrderCompleted has copy, drop {
        order_id: address,
    }

    public fun begin_output_phase<T0>(arg0: &RelayerCap, arg1: &mut PrivacyOrder<T0>, arg2: &TreasuryConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.completed, 2);
        assert!(!arg1.in_output_phase, 6);
        assert!(arg1.current_hop >= arg1.total_hops, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg1.last_action_ms >= arg1.next_delay_ms, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance) * 200 / 10000, arg4), arg2.treasury);
        arg1.in_output_phase = true;
        arg1.last_action_ms = v0;
        arg1.next_delay_ms = 5000 + pseudo_random(v0, 100) % (30000 - 5000);
        let v1 = OutputPhaseStarted{order_id: 0x2::object::uid_to_address(&arg1.id)};
        0x2::event::emit<OutputPhaseStarted>(v1);
    }

    public entry fun create_privacy_order<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 3);
        assert!(arg2 >= 2 && arg2 <= 5, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = PrivacyOrder<T0>{
            id              : 0x2::object::new(arg4),
            recipient       : arg1,
            balance         : 0x2::coin::into_balance<T0>(arg0),
            current_hop     : 0,
            total_hops      : arg2,
            last_action_ms  : v0,
            next_delay_ms   : 8000 + pseudo_random(v0, 1) % (45000 - 8000),
            in_output_phase : false,
            outputs_sent    : 0,
            total_outputs   : 3 + ((pseudo_random(v0, 2) % ((6 - 3 + 1) as u64)) as u8),
            completed       : false,
        };
        let v2 = OrderCreated{order_id: 0x2::object::uid_to_address(&v1.id)};
        0x2::event::emit<OrderCreated>(v2);
        0x2::transfer::share_object<PrivacyOrder<T0>>(v1);
    }

    public fun deposit_swap_result<T0>(arg0: &RelayerCap, arg1: &mut PrivacyOrder<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(!arg1.completed, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun execute_hop<T0>(arg0: &RelayerCap, arg1: &mut PrivacyOrder<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg1.completed, 2);
        assert!(!arg1.in_output_phase, 6);
        assert!(arg1.current_hop < arg1.total_hops, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg1.last_action_ms >= arg1.next_delay_ms, 1);
        arg1.current_hop = arg1.current_hop + 1;
        arg1.last_action_ms = v0;
        arg1.next_delay_ms = 8000 + pseudo_random(v0, (arg1.current_hop as u64)) % (45000 - 8000);
        let v1 = HopExecuted{
            order_id : 0x2::object::uid_to_address(&arg1.id),
            hop      : arg1.current_hop,
        };
        0x2::event::emit<HopExecuted>(v1);
        0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg3)
    }

    public fun get_balance<T0>(arg0: &PrivacyOrder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_status<T0>(arg0: &PrivacyOrder<T0>) : (u8, u8, bool, u8, u8, bool) {
        (arg0.current_hop, arg0.total_hops, arg0.in_output_phase, arg0.outputs_sent, arg0.total_outputs, arg0.completed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RelayerCap{id: 0x2::object::new(arg0)};
        let v1 = TreasuryConfig{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<RelayerCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TreasuryConfig>(v1);
    }

    fun pseudo_random(arg0: u64, arg1: u64) : u64 {
        ((arg0 ^ arg1 * 2654435761) * 1103515245 + 12345) / 65536 % 32768
    }

    public fun send_output<T0>(arg0: &RelayerCap, arg1: &mut PrivacyOrder<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.completed, 2);
        assert!(arg1.in_output_phase, 5);
        assert!(arg1.outputs_sent < arg1.total_outputs, 7);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg1.last_action_ms >= arg1.next_delay_ms, 1);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        let v2 = arg1.total_outputs - arg1.outputs_sent;
        let v3 = if (v2 == 1) {
            v1
        } else {
            let v4 = v1 / (v2 as u64);
            let v5 = v4 / 2;
            let v6 = v1 - v4 / 2 * ((v2 - 1) as u64);
            if (arg2 < v5) {
                v5
            } else if (arg2 > v6) {
                v6
            } else {
                arg2
            }
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v3, arg4), arg1.recipient);
        arg1.outputs_sent = arg1.outputs_sent + 1;
        arg1.last_action_ms = v0;
        arg1.next_delay_ms = 5000 + pseudo_random(v0, ((200 + arg1.outputs_sent) as u64)) % (30000 - 5000);
        let v7 = 0x2::object::uid_to_address(&arg1.id);
        let v8 = OutputSent{
            order_id   : v7,
            output_num : arg1.outputs_sent,
        };
        0x2::event::emit<OutputSent>(v8);
        if (arg1.outputs_sent >= arg1.total_outputs) {
            arg1.completed = true;
            let v9 = OrderCompleted{order_id: v7};
            0x2::event::emit<OrderCompleted>(v9);
        };
    }

    public fun time_until_ready<T0>(arg0: &PrivacyOrder<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.last_action_ms;
        if (v0 >= arg0.next_delay_ms) {
            0
        } else {
            arg0.next_delay_ms - v0
        }
    }

    public fun update_treasury(arg0: &RelayerCap, arg1: &mut TreasuryConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

