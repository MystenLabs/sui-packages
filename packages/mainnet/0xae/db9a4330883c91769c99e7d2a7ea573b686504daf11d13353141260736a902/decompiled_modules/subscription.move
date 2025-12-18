module 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::subscription {
    struct SubscriptionEvent has copy, drop {
        reference: 0x1::ascii::String,
        payer: address,
        receiver: address,
        plan_id: u64,
        amount_paid: u64,
        coin_type: 0x1::ascii::String,
    }

    struct UpgradeEvent has copy, drop {
        reference: 0x1::ascii::String,
        payer: address,
        receiver: address,
        from_plan_id: u64,
        to_plan_id: u64,
        amount_paid: u64,
        coin_type: 0x1::ascii::String,
        is_next_cycle: bool,
    }

    public fun buy_more_cu<T0>(arg0: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::Config, arg1: u64, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::assert_not_paused(arg0);
        let v0 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan(arg0, arg1);
        assert!(0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::is_cu_plan(&v0), 202);
        assert!(arg3 >= 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan_price(&v0), 203);
        let v1 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_fee_receiver(arg0);
        process_payment<T0>(arg0, arg4, arg3, v1, arg5);
        let v2 = SubscriptionEvent{
            reference   : arg2,
            payer       : 0x2::tx_context::sender(arg5),
            receiver    : v1,
            plan_id     : arg1,
            amount_paid : arg3,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
        };
        0x2::event::emit<SubscriptionEvent>(v2);
    }

    fun process_payment<T0>(arg0: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::assert_payment_type_accepted<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 201);
        if (0x2::coin::value<T0>(&arg1) > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) - arg2, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
    }

    public fun subscribe_cycle_plan<T0>(arg0: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::Config, arg1: u64, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::assert_not_paused(arg0);
        let v0 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan(arg0, arg1);
        assert!(0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::is_cycle_plan(&v0), 202);
        let v1 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_paid_price(&v0);
        let v2 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_fee_receiver(arg0);
        process_payment<T0>(arg0, arg3, v1, v2, arg4);
        let v3 = SubscriptionEvent{
            reference   : arg2,
            payer       : 0x2::tx_context::sender(arg4),
            receiver    : v2,
            plan_id     : arg1,
            amount_paid : v1,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
        };
        0x2::event::emit<SubscriptionEvent>(v3);
    }

    public fun subscribe_plan_with_admin<T0>(arg0: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::admin::AdminCap, arg1: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::Config, arg2: u64, arg3: 0x1::ascii::String, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan(arg1, arg2);
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::assert_not_paused(arg1);
        let v0 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_fee_receiver(arg1);
        process_payment<T0>(arg1, arg5, arg4, v0, arg6);
        let v1 = SubscriptionEvent{
            reference   : arg3,
            payer       : 0x2::tx_context::sender(arg6),
            receiver    : v0,
            plan_id     : arg2,
            amount_paid : arg4,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
        };
        0x2::event::emit<SubscriptionEvent>(v1);
    }

    public fun upgrade_cycle_plan<T0>(arg0: &0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::Config, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::assert_not_paused(arg0);
        let v0 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan(arg0, arg2);
        let v1 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_plan(arg0, arg1);
        let v2 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_paid_price(&v0);
        assert!(arg1 != arg2, 202);
        assert!(0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::is_cycle_plan(&v0), 202);
        assert!(0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::is_cycle_plan(&v1), 202);
        let v3 = 0xaedb9a4330883c91769c99e7d2a7ea573b686504daf11d13353141260736a902::config::get_fee_receiver(arg0);
        process_payment<T0>(arg0, arg5, v2, v3, arg6);
        let v4 = UpgradeEvent{
            reference     : arg3,
            payer         : 0x2::tx_context::sender(arg6),
            receiver      : v3,
            from_plan_id  : arg1,
            to_plan_id    : arg2,
            amount_paid   : v2,
            coin_type     : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            is_next_cycle : arg4,
        };
        0x2::event::emit<UpgradeEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

