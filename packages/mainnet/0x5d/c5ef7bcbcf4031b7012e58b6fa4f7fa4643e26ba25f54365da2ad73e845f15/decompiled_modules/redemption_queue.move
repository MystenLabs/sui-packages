module 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::redemption_queue {
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

    struct RedemptionTicketInfo has copy, drop {
        ticket_id: u64,
        recipient: address,
        balance: u64,
        time_to_redeem: u64,
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
        if (arg4 == 0) {
            err_zero_batch_size();
        };
        let v0 = arg0.counter;
        let v1 = &mut arg0.inner_table;
        let v2 = if (0x1::option::is_some<u64>(&arg3)) {
            let v3 = 0x1::option::destroy_some<u64>(arg3);
            if (v3 > v0) {
                err_index_exceed_size();
            };
            v3
        } else {
            let v4 = 0x2::linked_table::front<u64, RedemptionTicket>(v1);
            if (0x1::option::is_some<u64>(v4)) {
                *0x1::option::borrow<u64>(v4)
            } else {
                return
            }
        };
        let v5 = 0;
        while (v5 < 0x1::u64::min(arg4, v0 - v2)) {
            let v6 = v2 + v5;
            if (0x2::linked_table::contains<u64, RedemptionTicket>(v1, v6) && time_to_redeem(0x2::linked_table::borrow<u64, RedemptionTicket>(v1, v6)) <= 0x2::clock::timestamp_ms(arg2)) {
                let RedemptionTicket {
                    recipient      : v7,
                    balance        : v8,
                    time_to_redeem : v9,
                } = 0x2::linked_table::remove<u64, RedemptionTicket>(v1, v6);
                let v10 = v8;
                let v11 = RedemptionQueueW{dummy_field: false};
                let v12 = 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<T0, RedemptionQueueW>(arg1, v10, v11), arg5);
                0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_redeem_event<T1>(0x1::type_name::get<T0>(), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v10), 0x2::coin::value<T0>(&v12), v6, v9, 0x2::clock::timestamp_ms(arg2));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v7);
            };
            v5 = v5 + 1;
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
        if (arg3 == 0x2::address::from_u256(0)) {
            err_invalid_address();
        };
        let RedeemRequest {
            max_amount : v0,
            balance    : v1,
        } = arg2;
        let v2 = v1;
        let v3 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v2);
        if (v3 == 0) {
            0x2::balance::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v2);
        } else {
            let v4 = 0x2::clock::timestamp_ms(arg1) + delay<T0, T1>(arg0);
            let v5 = RedemptionTicket{
                recipient      : arg3,
                balance        : v2,
                time_to_redeem : v4,
            };
            0x2::linked_table::push_back<u64, RedemptionTicket>(&mut arg0.inner_table, arg0.counter, v5);
            0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_create_queue_ticket_event<T1>(0x1::type_name::get<T0>(), v0, v3, arg0.counter, v4, arg3);
            arg0.counter = arg0.counter + 1;
        };
    }

    public fun delay<T0, T1>(arg0: &RedemptionQueue<T0, T1>) : u64 {
        arg0.delay
    }

    fun err_exceed_max_amount_to_redeem() {
        abort 1
    }

    fun err_index_exceed_size() {
        abort 3
    }

    fun err_invalid_address() {
        abort 4
    }

    fun err_invalid_redeemer() {
        abort 2
    }

    fun err_queue_is_not_active() {
        abort 0
    }

    fun err_zero_batch_size() {
        abort 3
    }

    public fun get_tickets<T0, T1>(arg0: &RedemptionQueue<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<RedemptionTicketInfo>, 0x1::option::Option<u64>) {
        let v0 = 0x1::vector::empty<RedemptionTicketInfo>();
        let v1 = &arg0.inner_table;
        if (0x1::option::is_none<u64>(&arg1)) {
            arg1 = *0x2::linked_table::front<u64, RedemptionTicket>(v1);
        };
        let v2 = 0;
        while (0x1::option::is_some<u64>(&arg1) && v2 < arg2) {
            let v3 = *0x1::option::borrow<u64>(&arg1);
            let v4 = 0x2::linked_table::borrow<u64, RedemptionTicket>(v1, v3);
            let v5 = RedemptionTicketInfo{
                ticket_id      : v3,
                recipient      : ticket_recipient(v4),
                balance        : 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(ticket_balance(v4)),
                time_to_redeem : time_to_redeem(v4),
            };
            0x1::vector::push_back<RedemptionTicketInfo>(&mut v0, v5);
            v2 = v2 + 1;
            arg1 = *0x2::linked_table::next<u64, RedemptionTicket>(v1, v3);
        };
        (v0, arg1)
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

    public fun set_redeemer<T0, T1>(arg0: &mut RedemptionQueue<T0, T1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: 0x1::option::Option<address>) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_set_redeemer<T1>(0x2::object::id<RedemptionQueue<T0, T1>>(arg0), arg2);
        arg0.redeemer = arg2;
    }

    public fun ticket_balance(arg0: &RedemptionTicket) : &0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        &arg0.balance
    }

    public fun ticket_info_balance(arg0: &RedemptionTicketInfo) : u64 {
        arg0.balance
    }

    public fun ticket_info_id(arg0: &RedemptionTicketInfo) : u64 {
        arg0.ticket_id
    }

    public fun ticket_info_recipient(arg0: &RedemptionTicketInfo) : address {
        arg0.recipient
    }

    public fun ticket_info_time_to_redeem(arg0: &RedemptionTicketInfo) : u64 {
        arg0.time_to_redeem
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

