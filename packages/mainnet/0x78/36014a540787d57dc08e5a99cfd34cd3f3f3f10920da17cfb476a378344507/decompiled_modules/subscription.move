module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::subscription {
    struct SubscriptionPlan has store, key {
        id: 0x2::object::UID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        billing_cycle: u64,
        trial_period: u64,
        max_subscriptions: u64,
        active_count: u64,
        is_active: bool,
        created_at: u64,
    }

    struct Subscription has store, key {
        id: 0x2::object::UID,
        plan_id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        subscriber: address,
        status: u8,
        start_time: u64,
        current_period_start: u64,
        current_period_end: u64,
        paid_periods: u64,
        auto_renew: bool,
        created_at: u64,
    }

    struct InvoiceNFT has store, key {
        id: 0x2::object::UID,
        subscription_id: 0x2::object::ID,
        plan_name: 0x1::string::String,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        period_start: u64,
        period_end: u64,
        period_number: u64,
        payment_timestamp: u64,
        subscriber: address,
        merchant_id: 0x2::object::ID,
    }

    struct PlanCreated has copy, drop {
        plan_id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        amount: u64,
        billing_cycle: u64,
        created_at: u64,
    }

    struct PlanUpdated has copy, drop {
        plan_id: 0x2::object::ID,
        name: 0x1::string::String,
        amount: u64,
        billing_cycle: u64,
        updated_at: u64,
    }

    struct PlanStatusToggled has copy, drop {
        plan_id: 0x2::object::ID,
        is_active: bool,
        toggled_at: u64,
    }

    struct SubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        plan_id: 0x2::object::ID,
        subscriber: address,
        start_time: u64,
        period_end: u64,
        in_trial: bool,
        created_at: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        period_number: u64,
        amount: u64,
        period_start: u64,
        period_end: u64,
        renewed_at: u64,
    }

    struct SubscriptionCancelled has copy, drop {
        subscription_id: 0x2::object::ID,
        cancelled_at: u64,
        period_end: u64,
    }

    struct SubscriptionPaused has copy, drop {
        subscription_id: 0x2::object::ID,
        paused_at: u64,
    }

    struct SubscriptionResumed has copy, drop {
        subscription_id: 0x2::object::ID,
        resumed_at: u64,
        new_period_end: u64,
    }

    struct InvoiceIssued has copy, drop {
        invoice_id: 0x2::object::ID,
        subscription_id: 0x2::object::ID,
        amount: u64,
        period_number: u64,
        issued_at: u64,
    }

    public fun cancel_subscription(arg0: &mut Subscription, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg2), 607);
        assert!(arg0.status != 2, 604);
        arg0.status = 2;
        arg0.auto_renew = false;
        let v0 = SubscriptionCancelled{
            subscription_id : 0x2::object::uid_to_inner(&arg0.id),
            cancelled_at    : 0x2::clock::timestamp_ms(arg1),
            period_end      : arg0.current_period_end,
        };
        0x2::event::emit<SubscriptionCancelled>(v0);
    }

    fun create_invoice_nft(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: 0x2::object::ID, arg10: &mut 0x2::tx_context::TxContext) : InvoiceNFT {
        let v0 = 0x2::object::new(arg10);
        let v1 = InvoiceNFT{
            id                : v0,
            subscription_id   : arg0,
            plan_name         : arg1,
            amount            : arg2,
            currency          : arg3,
            period_start      : arg4,
            period_end        : arg5,
            period_number     : arg6,
            payment_timestamp : arg7,
            subscriber        : arg8,
            merchant_id       : arg9,
        };
        let v2 = InvoiceIssued{
            invoice_id      : 0x2::object::uid_to_inner(&v0),
            subscription_id : arg0,
            amount          : arg2,
            period_number   : arg6,
            issued_at       : arg7,
        };
        0x2::event::emit<InvoiceIssued>(v2);
        v1
    }

    public fun create_subscription_plan(arg0: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::MerchantCap, arg1: &mut 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SubscriptionPlan {
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::verify_merchant_cap(arg0, arg1), 608);
        assert!(arg4 > 0, 610);
        assert!(arg6 >= 86400000 && arg6 <= 31536000000, 609);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = SubscriptionPlan{
            id                : v0,
            merchant_id       : 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg1),
            name              : arg2,
            description       : arg3,
            amount            : arg4,
            currency          : arg5,
            billing_cycle     : arg6,
            trial_period      : arg7,
            max_subscriptions : arg8,
            active_count      : 0,
            is_active         : true,
            created_at        : v1,
        };
        let v3 = PlanCreated{
            plan_id       : 0x2::object::uid_to_inner(&v0),
            merchant_id   : 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg1),
            name          : v2.name,
            amount        : arg4,
            billing_cycle : arg6,
            created_at    : v1,
        };
        0x2::event::emit<PlanCreated>(v3);
        v2
    }

    public fun get_invoice_details(arg0: &InvoiceNFT) : (u64, 0x1::type_name::TypeName, u64, u64, u64) {
        (arg0.amount, arg0.currency, arg0.period_start, arg0.period_end, arg0.period_number)
    }

    public fun get_paid_periods(arg0: &Subscription) : u64 {
        arg0.paid_periods
    }

    public fun get_plan_id(arg0: &SubscriptionPlan) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_plan_info(arg0: &SubscriptionPlan) : (0x1::string::String, 0x1::string::String, u64, 0x1::type_name::TypeName, u64, u64, u64, bool) {
        (arg0.name, arg0.description, arg0.amount, arg0.currency, arg0.billing_cycle, arg0.trial_period, arg0.active_count, arg0.is_active)
    }

    public fun get_subscription_period(arg0: &Subscription) : (u64, u64) {
        (arg0.current_period_start, arg0.current_period_end)
    }

    public fun get_subscription_status(arg0: &Subscription) : u8 {
        arg0.status
    }

    public fun is_auto_renew(arg0: &Subscription) : bool {
        arg0.auto_renew
    }

    public fun is_subscription_active(arg0: &Subscription) : bool {
        arg0.status == 0
    }

    public fun needs_renewal(arg0: &Subscription, arg1: u64) : bool {
        arg0.status == 0 && arg1 >= arg0.current_period_end
    }

    public fun pause_subscription(arg0: &mut Subscription, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg2), 607);
        assert!(arg0.status == 0, 603);
        arg0.status = 1;
        let v0 = SubscriptionPaused{
            subscription_id : 0x2::object::uid_to_inner(&arg0.id),
            paused_at       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SubscriptionPaused>(v0);
    }

    public fun renew_subscription<T0>(arg0: &mut Subscription, arg1: &SubscriptionPlan, arg2: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : InvoiceNFT {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg0.subscriber == v1, 607);
        assert!(arg0.status == 0, 603);
        assert!(arg0.plan_id == 0x2::object::uid_to_inner(&arg1.id), 608);
        assert!(arg1.merchant_id == 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg2), 608);
        assert!(v0 >= arg0.current_period_end, 605);
        assert!(0x1::type_name::get<T0>() == arg1.currency, 611);
        assert!(0x2::coin::value<T0>(&arg3) >= arg1.amount, 602);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, arg1.amount, arg5), 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_receiving_address<T0>(arg2));
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v2 = arg0.current_period_end;
        let v3 = v2 + arg1.billing_cycle;
        arg0.current_period_start = v2;
        arg0.current_period_end = v3;
        arg0.paid_periods = arg0.paid_periods + 1;
        let v4 = SubscriptionRenewed{
            subscription_id : 0x2::object::uid_to_inner(&arg0.id),
            period_number   : arg0.paid_periods,
            amount          : arg1.amount,
            period_start    : v2,
            period_end      : v3,
            renewed_at      : v0,
        };
        0x2::event::emit<SubscriptionRenewed>(v4);
        create_invoice_nft(0x2::object::uid_to_inner(&arg0.id), arg1.name, arg1.amount, arg1.currency, v2, v3, arg0.paid_periods, v0, v1, arg1.merchant_id, arg5)
    }

    public fun resume_subscription(arg0: &mut Subscription, arg1: &SubscriptionPlan, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg3), 607);
        assert!(arg0.status == 1, 612);
        assert!(arg0.plan_id == 0x2::object::uid_to_inner(&arg1.id), 608);
        arg0.status = 0;
        let v1 = arg0.current_period_end + v0 - arg0.current_period_start;
        arg0.current_period_end = v1;
        let v2 = SubscriptionResumed{
            subscription_id : 0x2::object::uid_to_inner(&arg0.id),
            resumed_at      : v0,
            new_period_end  : v1,
        };
        0x2::event::emit<SubscriptionResumed>(v2);
    }

    public fun set_auto_renew(arg0: &mut Subscription, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg2), 607);
        arg0.auto_renew = arg1;
    }

    public fun subscribe<T0>(arg0: &mut SubscriptionPlan, arg1: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Subscription, 0x1::option::Option<InvoiceNFT>) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg0.is_active, 600);
        if (arg0.max_subscriptions > 0) {
            assert!(arg0.active_count < arg0.max_subscriptions, 601);
        };
        assert!(0x1::type_name::get<T0>() == arg0.currency, 611);
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let (v4, v5, v6) = if (arg0.trial_period > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
            (v0 + arg0.trial_period, true, 0x1::option::none<InvoiceNFT>())
        } else {
            assert!(0x2::coin::value<T0>(&arg2) >= arg0.amount, 602);
            assert!(arg0.merchant_id == 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg1), 608);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg0.amount, arg5), 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_receiving_address<T0>(arg1));
            if (0x2::coin::value<T0>(&arg2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
            } else {
                0x2::coin::destroy_zero<T0>(arg2);
            };
            let v7 = v0 + arg0.billing_cycle;
            (v7, false, 0x1::option::some<InvoiceNFT>(create_invoice_nft(v3, arg0.name, arg0.amount, arg0.currency, v0, v7, 1, v0, v1, arg0.merchant_id, arg5)))
        };
        let v8 = if (v5) {
            0
        } else {
            1
        };
        let v9 = Subscription{
            id                   : v2,
            plan_id              : 0x2::object::uid_to_inner(&arg0.id),
            merchant_id          : arg0.merchant_id,
            subscriber           : v1,
            status               : 0,
            start_time           : v0,
            current_period_start : v0,
            current_period_end   : v4,
            paid_periods         : v8,
            auto_renew           : arg3,
            created_at           : v0,
        };
        arg0.active_count = arg0.active_count + 1;
        let v10 = SubscriptionCreated{
            subscription_id : v3,
            plan_id         : 0x2::object::uid_to_inner(&arg0.id),
            subscriber      : v1,
            start_time      : v0,
            period_end      : v4,
            in_trial        : v5,
            created_at      : v0,
        };
        0x2::event::emit<SubscriptionCreated>(v10);
        (v9, v6)
    }

    public fun toggle_plan_status(arg0: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::MerchantCap, arg1: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: &mut SubscriptionPlan, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::verify_merchant_cap(arg0, arg1), 608);
        assert!(arg2.merchant_id == 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg1), 608);
        arg2.is_active = arg3;
        let v0 = PlanStatusToggled{
            plan_id    : 0x2::object::uid_to_inner(&arg2.id),
            is_active  : arg3,
            toggled_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PlanStatusToggled>(v0);
    }

    public fun update_subscription_plan(arg0: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::MerchantCap, arg1: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: &mut SubscriptionPlan, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::verify_merchant_cap(arg0, arg1), 608);
        assert!(arg2.merchant_id == 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_merchant_id(arg1), 608);
        assert!(arg5 > 0, 610);
        assert!(arg6 >= 86400000 && arg6 <= 31536000000, 609);
        arg2.name = arg3;
        arg2.description = arg4;
        arg2.amount = arg5;
        arg2.billing_cycle = arg6;
        arg2.trial_period = arg7;
        arg2.max_subscriptions = arg8;
        let v0 = PlanUpdated{
            plan_id       : 0x2::object::uid_to_inner(&arg2.id),
            name          : arg2.name,
            amount        : arg5,
            billing_cycle : arg6,
            updated_at    : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<PlanUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

