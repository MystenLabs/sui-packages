module 0xeba2a1aaf49282c55c191ea8a44500692c82030352bec60223447b0cf9f113f4::kage_payments {
    struct KagePayments has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_fees_collected: u64,
        total_queries: u64,
        total_cross_queries: u64,
        admin: address,
        kage_protocol_id: 0x2::object::ID,
    }

    struct KagePaymentsAdminCap has store, key {
        id: 0x2::object::UID,
        payments_id: 0x2::object::ID,
    }

    struct QueryPaid has copy, drop {
        payer: address,
        memory_id: u64,
        is_cross_namespace: bool,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct InheritancePaid has copy, drop {
        payer: address,
        parent_memory_id: u64,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct CrossSharePaid has copy, drop {
        payer: address,
        memory_id: u64,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        timestamp_ms: u64,
    }

    public fun get_fee_cross() : u64 {
        10000000
    }

    public fun get_fee_own() : u64 {
        1000000
    }

    public fun get_total_cross_queries(arg0: &KagePayments) : u64 {
        arg0.total_cross_queries
    }

    public fun get_total_fees(arg0: &KagePayments) : u64 {
        arg0.total_fees_collected
    }

    public fun get_total_queries(arg0: &KagePayments) : u64 {
        arg0.total_queries
    }

    public fun get_treasury_balance(arg0: &KagePayments) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = KagePayments{
            id                   : v1,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_fees_collected : 0,
            total_queries        : 0,
            total_cross_queries  : 0,
            admin                : v0,
            kage_protocol_id     : 0x2::object::id_from_address(@0x0),
        };
        let v3 = KagePaymentsAdminCap{
            id          : 0x2::object::new(arg0),
            payments_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::share_object<KagePayments>(v2);
        0x2::transfer::transfer<KagePaymentsAdminCap>(v3, v0);
    }

    public entry fun pay_cross_share(arg0: &mut KagePayments, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 10000000));
        arg0.total_fees_collected = arg0.total_fees_collected + 10000000;
        arg0.total_queries = arg0.total_queries + 1;
        arg0.total_cross_queries = arg0.total_cross_queries + 1;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = CrossSharePaid{
            payer        : v0,
            memory_id    : arg1,
            fee_paid     : 10000000,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<CrossSharePaid>(v2);
    }

    public entry fun pay_inheritance(arg0: &mut KagePayments, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 1000000));
        arg0.total_fees_collected = arg0.total_fees_collected + 1000000;
        arg0.total_queries = arg0.total_queries + 1;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = InheritancePaid{
            payer            : v0,
            parent_memory_id : arg1,
            fee_paid         : 1000000,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<InheritancePaid>(v2);
    }

    public entry fun pay_query_cross(arg0: &mut KagePayments, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 10000000));
        arg0.total_fees_collected = arg0.total_fees_collected + 10000000;
        arg0.total_queries = arg0.total_queries + 1;
        arg0.total_cross_queries = arg0.total_cross_queries + 1;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = QueryPaid{
            payer              : v0,
            memory_id          : arg1,
            is_cross_namespace : true,
            fee_paid           : 10000000,
            timestamp_ms       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<QueryPaid>(v2);
    }

    public entry fun pay_query_own(arg0: &mut KagePayments, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 1000000));
        arg0.total_fees_collected = arg0.total_fees_collected + 1000000;
        arg0.total_queries = arg0.total_queries + 1;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = QueryPaid{
            payer              : v0,
            memory_id          : arg1,
            is_cross_namespace : false,
            fee_paid           : 1000000,
            timestamp_ms       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<QueryPaid>(v2);
    }

    public entry fun set_protocol_id(arg0: &mut KagePayments, arg1: &KagePaymentsAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.payments_id, 1);
        arg0.kage_protocol_id = 0x2::object::id_from_address(arg2);
    }

    public entry fun withdraw_fees(arg0: &mut KagePayments, arg1: &KagePaymentsAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.payments_id, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg4), arg3);
        let v0 = FeesWithdrawn{
            amount       : arg2,
            recipient    : arg3,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

