module 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::redemption_queue {
    struct RedemptionQueueW has drop {
        dummy_field: bool,
    }

    struct RedemptionTicket has store {
        recipient: address,
        balance: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
        time_to_redeem: u64,
    }

    struct RedemptionQueue<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        delay: u64,
        counter: u64,
        inner_table: 0x2::linked_table::LinkedTable<u64, RedemptionTicket>,
        redeemer: 0x1::option::Option<address>,
        is_active: bool,
    }

    struct RedeemRequest<phantom T0, phantom T1> {
        max_amount: u64,
        balance: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
    }

    public fun add_balance<T0, T1>(arg0: &mut RedeemRequest<T0, T1>, arg1: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        if (0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.balance, arg1) > arg0.max_amount) {
            err_exceed_max_amount_to_redeem();
        };
    }

    public fun assert_is_active<T0, T1>(arg0: &RedemptionQueue<T0, T1>) {
        if (!is_active<T0, T1>(arg0)) {
            err_queue_is_not_active();
        };
    }

    public fun assert_is_redeemer<T0, T1>(arg0: &RedemptionQueue<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = &arg0.redeemer;
        let v1 = if (0x1::option::is_some<address>(v0)) {
            let v2 = 0x2::tx_context::sender(arg1);
            &v2 != 0x1::option::borrow<address>(v0)
        } else {
            false
        };
        if (v1) {
            err_invalid_redeemer();
        };
    }

    public fun batch_redeem<T0, T1>(arg0: &mut RedemptionQueue<T0, T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_redeemer<T0, T1>(arg0, arg5);
        let v0 = &mut arg0.inner_table;
        let v1 = if (0x1::option::is_some<u64>(&arg3)) {
            0x1::option::destroy_some<u64>(arg3)
        } else {
            let v2 = 0x2::linked_table::front<u64, RedemptionTicket>(v0);
            if (0x1::option::is_some<u64>(v2)) {
                *0x1::option::borrow<u64>(v2)
            } else {
                return
            }
        };
        let v3 = 0;
        while (v3 < 0x1::u64::min(arg4, arg0.counter - v1)) {
            let v4 = v1 + v3;
            if (0x2::linked_table::contains<u64, RedemptionTicket>(v0, v4) && time_to_redeem(0x2::linked_table::borrow<u64, RedemptionTicket>(v0, v4)) <= 0x2::clock::timestamp_ms(arg2)) {
                let RedemptionTicket {
                    recipient      : v5,
                    balance        : v6,
                    time_to_redeem : v7,
                } = 0x2::linked_table::remove<u64, RedemptionTicket>(v0, v4);
                let v8 = v6;
                let v9 = RedemptionQueueW{dummy_field: false};
                let v10 = 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<T0, RedemptionQueueW>(arg1, v8, v9), arg5);
                0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_redeem_event<T1>(0x1::type_name::get<T0>(), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8), 0x2::coin::value<T0>(&v10), v4, v7, 0x2::clock::timestamp_ms(arg2));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v5);
            };
            v3 = v3 + 1;
        };
    }

    public fun create<T0, T1>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RedemptionQueue<T0, T1>{
            id          : 0x2::object::new(arg3),
            delay       : arg1,
            counter     : 0,
            inner_table : 0x2::linked_table::new<u64, RedemptionTicket>(arg3),
            redeemer    : arg2,
            is_active   : true,
        };
        0x2::transfer::share_object<RedemptionQueue<T0, T1>>(v0);
    }

    public fun create_ticket<T0, T1>(arg0: &mut RedemptionQueue<T0, T1>, arg1: &0x2::clock::Clock, arg2: RedeemRequest<T0, T1>, arg3: address) {
        assert_is_active<T0, T1>(arg0);
        let RedeemRequest {
            max_amount : v0,
            balance    : v1,
        } = arg2;
        let v2 = v1;
        let v3 = 0x2::clock::timestamp_ms(arg1) + delay<T0, T1>(arg0);
        let v4 = RedemptionTicket{
            recipient      : arg3,
            balance        : v2,
            time_to_redeem : v3,
        };
        0x2::linked_table::push_back<u64, RedemptionTicket>(&mut arg0.inner_table, arg0.counter, v4);
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_create_queue_ticket_event<T1>(0x1::type_name::get<T1>(), v0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v2), arg0.counter, v3);
        arg0.counter = arg0.counter + 1;
    }

    public fun delay<T0, T1>(arg0: &RedemptionQueue<T0, T1>) : u64 {
        arg0.delay
    }

    fun err_exceed_max_amount_to_redeem() {
        abort 1
    }

    fun err_invalid_redeemer() {
        abort 2
    }

    fun err_queue_is_not_active() {
        abort 0
    }

    public fun inner_table<T0, T1>(arg0: &RedemptionQueue<T0, T1>) : &0x2::linked_table::LinkedTable<u64, RedemptionTicket> {
        &arg0.inner_table
    }

    public fun is_active<T0, T1>(arg0: &RedemptionQueue<T0, T1>) : bool {
        arg0.is_active
    }

    public fun redeem_request_max_amount<T0, T1>(arg0: &RedeemRequest<T0, T1>) : u64 {
        arg0.max_amount
    }

    public fun request<T0, T1: drop>(arg0: T1, arg1: u64) : RedeemRequest<T0, T1> {
        RedeemRequest<T0, T1>{
            max_amount : arg1,
            balance    : 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
        }
    }

    public fun set_delay<T0, T1>(arg0: &mut RedemptionQueue<T0, T1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: u64) {
        arg0.delay = arg2;
    }

    public fun ticket_balance(arg0: &RedemptionTicket) : &0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        &arg0.balance
    }

    public fun ticket_recipient(arg0: &RedemptionTicket) : address {
        arg0.recipient
    }

    public fun time_to_redeem(arg0: &RedemptionTicket) : u64 {
        arg0.time_to_redeem
    }

    public fun toggle_active<T0, T1>(arg0: &mut RedemptionQueue<T0, T1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap) {
        arg0.is_active = !arg0.is_active;
    }

    // decompiled from Move bytecode v6
}

