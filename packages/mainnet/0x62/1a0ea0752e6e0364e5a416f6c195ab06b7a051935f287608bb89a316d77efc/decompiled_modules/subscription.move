module 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::subscription {
    struct SubscriptionEvent has copy, drop {
        user_reference: vector<u8>,
        payer: address,
        plan_id: u64,
        amount_paid: u64,
    }

    struct UpgradeEvent has copy, drop {
        user_reference: vector<u8>,
        payer: address,
        from_plan_id: u64,
        to_plan_id: u64,
        amount_paid: u64,
        immediate: bool,
    }

    fun is_valid_payment_coin_type<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == 0x1::ascii::string(b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")
    }

    fun process_payment<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_payment_coin_type<T0>(), 110);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 201);
        if (0x2::coin::value<T0>(arg0) > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) - arg1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun subscribe_plan<T0>(arg0: &0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::Config, arg1: u64, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::assert_not_paused(arg0);
        let v0 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan(arg0, arg1);
        let v1 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan_price(&v0);
        let v2 = &mut arg3;
        process_payment<T0>(v2, v1, arg4);
        transfer_to_admin<T0>(arg3, 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_admin_wallet(arg0));
        let v3 = SubscriptionEvent{
            user_reference : arg2,
            payer          : 0x2::tx_context::sender(arg4),
            plan_id        : arg1,
            amount_paid    : v1,
        };
        0x2::event::emit<SubscriptionEvent>(v3);
    }

    public fun subscribe_plan_with_admin<T0>(arg0: &0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::admin::AdminCap, arg1: &0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::Config, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::assert_not_paused(arg1);
        let v0 = &mut arg5;
        process_payment<T0>(v0, arg4, arg6);
        transfer_to_admin<T0>(arg5, 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_admin_wallet(arg1));
        let v1 = SubscriptionEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg6),
            plan_id        : arg2,
            amount_paid    : arg4,
        };
        0x2::event::emit<SubscriptionEvent>(v1);
    }

    fun transfer_to_admin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun upgrade_plan<T0>(arg0: &0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::Config, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::assert_not_paused(arg0);
        assert!(arg1 != arg2, 202);
        let v0 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan(arg0, arg2);
        let v1 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan_price(&v0);
        let v2 = &mut arg4;
        process_payment<T0>(v2, v1, arg5);
        transfer_to_admin<T0>(arg4, 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_admin_wallet(arg0));
        let v3 = UpgradeEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg5),
            from_plan_id   : arg1,
            to_plan_id     : arg2,
            amount_paid    : v1,
            immediate      : false,
        };
        0x2::event::emit<UpgradeEvent>(v3);
    }

    public fun upgrade_plan_immediately<T0>(arg0: &0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::Config, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::assert_not_paused(arg0);
        assert!(arg1 != arg2, 202);
        let v0 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan(arg0, arg1);
        let v1 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan(arg0, arg2);
        let v2 = 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan_price(&v1) - 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_plan_price(&v0);
        assert!(v2 > 0, 203);
        let v3 = &mut arg4;
        process_payment<T0>(v3, v2, arg5);
        transfer_to_admin<T0>(arg4, 0x621a0ea0752e6e0364e5a416f6c195ab06b7a051935f287608bb89a316d77efc::config::get_admin_wallet(arg0));
        let v4 = UpgradeEvent{
            user_reference : arg3,
            payer          : 0x2::tx_context::sender(arg5),
            from_plan_id   : arg1,
            to_plan_id     : arg2,
            amount_paid    : v2,
            immediate      : true,
        };
        0x2::event::emit<UpgradeEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

