module 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::subscription {
    struct SubscriptionEvent has copy, drop {
        user_reference: 0x1::ascii::String,
        payer: address,
        receiver: address,
        plan_id: u64,
        amount_paid: u64,
        coin_type: 0x1::ascii::String,
    }

    struct UpgradeEvent has copy, drop {
        user_reference: 0x1::ascii::String,
        payer: address,
        receiver: address,
        from_plan_id: u64,
        to_plan_id: u64,
        amount_paid: u64,
        coin_type: 0x1::ascii::String,
        immediate: bool,
    }

    fun process_payment<T0>(arg0: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::Config, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::assert_payment_type_accepted<T0>(arg0);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 201);
        if (0x2::coin::value<T0>(arg1) > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, 0x2::coin::value<T0>(arg1) - arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public fun subscribe_plan<T0>(arg0: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::Config, arg1: u64, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::assert_not_paused(arg0);
        let v0 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan(arg0, arg1);
        let v1 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan_price(&v0);
        let v2 = &mut arg3;
        process_payment<T0>(arg0, v2, v1, arg4);
        let v3 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_fee_receiver(arg0);
        transfer_to_fee_receiver<T0>(arg3, v3);
        let v4 = SubscriptionEvent{
            user_reference : arg2,
            payer          : 0x2::tx_context::sender(arg4),
            receiver       : v3,
            plan_id        : arg1,
            amount_paid    : v1,
            coin_type      : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
        };
        0x2::event::emit<SubscriptionEvent>(v4);
    }

    public fun subscribe_plan_with_admin<T0>(arg0: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::admin::AdminCap, arg1: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::Config, arg2: u64, arg3: 0x1::ascii::String, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan(arg1, arg2);
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::assert_not_paused(arg1);
        let v0 = &mut arg5;
        process_payment<T0>(arg1, v0, arg4, arg6);
        let v1 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_fee_receiver(arg1);
        transfer_to_fee_receiver<T0>(arg5, v1);
        let v2 = SubscriptionEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg6),
            receiver       : v1,
            plan_id        : arg2,
            amount_paid    : arg4,
            coin_type      : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
        };
        0x2::event::emit<SubscriptionEvent>(v2);
    }

    fun transfer_to_fee_receiver<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun upgrade_plan<T0>(arg0: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::Config, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::assert_not_paused(arg0);
        assert!(arg1 != arg2, 202);
        let v0 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan(arg0, arg2);
        let v1 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan_price(&v0);
        let v2 = &mut arg4;
        process_payment<T0>(arg0, v2, v1, arg5);
        let v3 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_fee_receiver(arg0);
        transfer_to_fee_receiver<T0>(arg4, v3);
        let v4 = UpgradeEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg5),
            receiver       : v3,
            from_plan_id   : arg1,
            to_plan_id     : arg2,
            amount_paid    : v1,
            coin_type      : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            immediate      : false,
        };
        0x2::event::emit<UpgradeEvent>(v4);
    }

    public fun upgrade_plan_immediately<T0>(arg0: &0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::Config, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::assert_not_paused(arg0);
        assert!(arg1 != arg2, 202);
        let v0 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan(arg0, arg1);
        let v1 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan(arg0, arg2);
        let v2 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan_price(&v0);
        let v3 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_plan_price(&v1);
        assert!(v3 > v2, 203);
        let v4 = v3 - v2;
        let v5 = &mut arg4;
        process_payment<T0>(arg0, v5, v4, arg5);
        let v6 = 0xb1a68620fe46c47c311b9e55f3861f39402467b8be99ac8117850dca0572ee9b::config::get_fee_receiver(arg0);
        transfer_to_fee_receiver<T0>(arg4, v6);
        let v7 = UpgradeEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg5),
            receiver       : v6,
            from_plan_id   : arg1,
            to_plan_id     : arg2,
            amount_paid    : v4,
            coin_type      : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            immediate      : true,
        };
        0x2::event::emit<UpgradeEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

