module 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::subscription {
    struct SubscriptionEvent has copy, drop {
        user_reference: vector<u8>,
        payer: address,
        plan_id: u64,
        plan_name: vector<u8>,
        amount_paid: u64,
        period: u8,
        timestamp: u64,
    }

    struct UpgradeEvent has copy, drop {
        user_reference: vector<u8>,
        payer: address,
        from_plan_id: u64,
        from_tier: u8,
        to_plan_id: u64,
        to_plan_name: vector<u8>,
        to_tier: u8,
        amount_paid: u64,
        immediate: bool,
        timestamp: u64,
    }

    struct DowngradeRequestEvent has copy, drop {
        user_reference: vector<u8>,
        requester: address,
        current_plan_id: u64,
        current_tier: u8,
        target_plan_id: u64,
        target_plan_name: vector<u8>,
        target_tier: u8,
        timestamp: u64,
    }

    public fun downgrade_plan(arg0: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::Config, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::assert_not_paused(arg0);
        assert!(arg2 != arg3, 202);
        let v0 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg2);
        let v1 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg3);
        let v2 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v0);
        let v3 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v1);
        assert!(v3 < v2, 204);
        let v4 = DowngradeRequestEvent{
            user_reference   : arg4,
            requester        : 0x2::tx_context::sender(arg5),
            current_plan_id  : arg2,
            current_tier     : v2,
            target_plan_id   : arg3,
            target_plan_name : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_name(&v1),
            target_tier      : v3,
            timestamp        : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<DowngradeRequestEvent>(v4);
    }

    fun process_payment<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 201);
        if (0x2::coin::value<T0>(arg0) > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) - arg1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun subscribe_plan<T0>(arg0: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::Config, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::assert_not_paused(arg0);
        let v0 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg2);
        let v1 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_paid_price(&v0);
        let v2 = &mut arg4;
        process_payment<T0>(v2, v1, arg5);
        transfer_to_admin<T0>(arg4, 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_admin_wallet(arg0));
        let v3 = SubscriptionEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg5),
            plan_id        : arg2,
            plan_name      : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_name(&v0),
            amount_paid    : v1,
            period         : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_period(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SubscriptionEvent>(v3);
    }

    public fun subscribe_plan_with_admin<T0>(arg0: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::Config, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg1, arg3);
        let v1 = &mut arg6;
        process_payment<T0>(v1, arg5, arg7);
        transfer_to_admin<T0>(arg6, 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_admin_wallet(arg1));
        let v2 = SubscriptionEvent{
            user_reference : arg4,
            payer          : 0x2::tx_context::sender(arg7),
            plan_id        : arg3,
            plan_name      : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_name(&v0),
            amount_paid    : arg5,
            period         : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_period(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubscriptionEvent>(v2);
    }

    fun transfer_to_admin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun upgrade_plan<T0>(arg0: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::Config, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::assert_not_paused(arg0);
        assert!(arg2 != arg3, 202);
        let v0 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg2);
        let v1 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg3);
        let v2 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v0);
        let v3 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v1);
        assert!(v3 > v2, 203);
        let v4 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_upgrade_fee(&v1);
        let v5 = &mut arg5;
        process_payment<T0>(v5, v4, arg6);
        transfer_to_admin<T0>(arg5, 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_admin_wallet(arg0));
        let v6 = UpgradeEvent{
            user_reference : arg4,
            payer          : 0x2::tx_context::sender(arg6),
            from_plan_id   : arg2,
            from_tier      : v2,
            to_plan_id     : arg3,
            to_plan_name   : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_name(&v1),
            to_tier        : v3,
            amount_paid    : v4,
            immediate      : false,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UpgradeEvent>(v6);
    }

    public fun upgrade_plan_immediately<T0>(arg0: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::Config, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::assert_not_paused(arg0);
        assert!(arg2 != arg3, 202);
        let v0 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg2);
        let v1 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan(arg0, arg3);
        let v2 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v0);
        let v3 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_tier(&v1);
        assert!(v3 > v2, 203);
        let v4 = 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_immediate_upgrade_fee(&v1);
        let v5 = &mut arg5;
        process_payment<T0>(v5, v4, arg6);
        transfer_to_admin<T0>(arg5, 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_admin_wallet(arg0));
        let v6 = UpgradeEvent{
            user_reference : arg4,
            payer          : 0x2::tx_context::sender(arg6),
            from_plan_id   : arg2,
            from_tier      : v2,
            to_plan_id     : arg3,
            to_plan_name   : 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config::get_plan_name(&v1),
            to_tier        : v3,
            amount_paid    : v4,
            immediate      : true,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UpgradeEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

