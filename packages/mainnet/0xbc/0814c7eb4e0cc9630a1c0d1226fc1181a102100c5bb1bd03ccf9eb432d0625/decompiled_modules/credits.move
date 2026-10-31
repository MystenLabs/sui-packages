module 0xbc0814c7eb4e0cc9630a1c0d1226fc1181a102100c5bb1bd03ccf9eb432d0625::credits {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Settings has key {
        id: 0x2::object::UID,
        paused: bool,
        max_balance: u64,
        max_per_day_cap: u64,
        max_per_plan: u64,
        coin_type: 0x1::option::Option<0x1::ascii::String>,
        registry_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Plan has copy, drop, store {
        creator: address,
        kind: 0x1::string::String,
        amount: u64,
        period_ms: u64,
        next_due_ms: u64,
        paid: u64,
    }

    struct Credits<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<T0>,
        keys: 0x2::vec_map::VecMap<address, u64>,
        max_per_gift: u64,
        max_per_day: u64,
        day_start_ms: u64,
        spent_today: u64,
        total_sent: u64,
        plans: 0x2::vec_map::VecMap<u64, Plan>,
        next_plan_id: u64,
    }

    struct CreditsOpened has copy, drop {
        credits_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        max_per_gift: u64,
        max_per_day: u64,
    }

    struct CreditsToppedUp has copy, drop {
        credits_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct CreditsWithdrawn has copy, drop {
        credits_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct DeviceChanged has copy, drop {
        credits_id: 0x2::object::ID,
        owner: address,
        device: address,
        expires_at_ms: u64,
    }

    struct LimitsChanged has copy, drop {
        credits_id: 0x2::object::ID,
        owner: address,
        max_per_gift: u64,
        max_per_day: u64,
    }

    struct CreditsGiftSent has copy, drop {
        credits_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        owner: address,
        signer: address,
        creator: address,
        gift_id: 0x1::string::String,
        stream_id: 0x1::string::String,
        amount: u64,
        remaining: u64,
        spent_today: u64,
        timestamp_ms: u64,
    }

    struct PlanStarted has copy, drop {
        credits_id: 0x2::object::ID,
        plan_id: u64,
        owner: address,
        creator: address,
        kind: 0x1::string::String,
        amount: u64,
        period_ms: u64,
    }

    struct PlanPaid has copy, drop {
        credits_id: 0x2::object::ID,
        plan_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        creator: address,
        kind: 0x1::string::String,
        amount: u64,
        period: u64,
        paid_until_ms: u64,
        collector: address,
        remaining: u64,
        timestamp_ms: u64,
    }

    struct PlanCancelled has copy, drop {
        credits_id: 0x2::object::ID,
        plan_id: u64,
        owner: address,
        creator: address,
        kind: 0x1::string::String,
        paid_until_ms: u64,
        by: address,
    }

    struct SettingsChanged has copy, drop {
        paused: bool,
        max_balance: u64,
        max_per_day_cap: u64,
        max_per_plan: u64,
    }

    struct Configured has copy, drop {
        coin_type: 0x1::ascii::String,
        registry_id: 0x2::object::ID,
    }

    public fun value<T0>(arg0: &Credits<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun send_gift<T0>(arg0: &Settings, arg1: &mut Credits<T0>, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg7: &mut 0x8c1ae6083a2802691f445bc5005444298c34daf9d08ece020f51e88dafdcea4f::gift_payments::Config, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        check_registry<T0>(arg0, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        check_signer<T0>(arg1, v0, v1);
        assert!(arg2 > 0, 7);
        assert!(arg3 != arg1.owner, 8);
        assert!(arg3 != v0 && arg3 != @0x0, 17);
        assert!(arg2 <= arg1.max_per_gift, 4);
        if (v1 >= arg1.day_start_ms + 86400000) {
            arg1.day_start_ms = v1;
            arg1.spent_today = 0;
        };
        assert!(arg1.spent_today + arg2 <= arg1.max_per_day, 5);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= arg2, 6);
        arg1.spent_today = arg1.spent_today + arg2;
        arg1.total_sent = arg1.total_sent + arg2;
        0x8c1ae6083a2802691f445bc5005444298c34daf9d08ece020f51e88dafdcea4f::gift_payments::send_gift<T0>(0x2::coin::take<T0>(&mut arg1.funds, arg2, arg9), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = CreditsGiftSent{
            credits_id   : 0x2::object::id<Credits<T0>>(arg1),
            coin_type    : check_coin<T0>(arg0),
            owner        : arg1.owner,
            signer       : v0,
            creator      : arg3,
            gift_id      : arg4,
            stream_id    : arg5,
            amount       : arg2,
            remaining    : 0x2::balance::value<T0>(&arg1.funds),
            spent_today  : arg1.spent_today,
            timestamp_ms : v1,
        };
        0x2::event::emit<CreditsGiftSent>(v2);
    }

    public fun add_device<T0>(arg0: &mut Credits<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        put_key<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_plan<T0>(arg0: &mut Credits<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        check_signer<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
        assert!(0x2::vec_map::contains<u64, Plan>(&arg0.plans, &arg1), 22);
        let (_, v2) = 0x2::vec_map::remove<u64, Plan>(&mut arg0.plans, &arg1);
        let v3 = v2;
        let v4 = PlanCancelled{
            credits_id    : 0x2::object::id<Credits<T0>>(arg0),
            plan_id       : arg1,
            owner         : arg0.owner,
            creator       : v3.creator,
            kind          : v3.kind,
            paid_until_ms : v3.next_due_ms,
            by            : v0,
        };
        0x2::event::emit<PlanCancelled>(v4);
    }

    fun check_coin<T0>(arg0: &Settings) : 0x1::ascii::String {
        assert!(0x1::option::is_some<0x1::ascii::String>(&arg0.coin_type), 13);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(*0x1::option::borrow<0x1::ascii::String>(&arg0.coin_type) == v0, 15);
        v0
    }

    fun check_expiry(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0 && arg1 <= arg0 + 7776000000, 12);
    }

    fun check_limits(arg0: &Settings, arg1: u64, arg2: u64) {
        let v0 = if (arg1 > 0) {
            if (arg2 >= arg1) {
                arg2 <= arg0.max_per_day_cap
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
    }

    fun check_registry<T0>(arg0: &Settings, arg1: &0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.registry_id) == 0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg1), 16);
    }

    fun check_signer<T0>(arg0: &Credits<T0>, arg1: address, arg2: u64) {
        if (arg1 == arg0.owner) {
            return
        };
        assert!(0x2::vec_map::contains<address, u64>(&arg0.keys, &arg1), 2);
        assert!(arg2 < *0x2::vec_map::get<address, u64>(&arg0.keys, &arg1), 3);
    }

    public fun collect<T0>(arg0: &Settings, arg1: &mut Credits<T0>, arg2: u64, arg3: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg4: &mut 0x299548dbaff253e60a6757a2f61975dc20fbadfbce47968d9a8c3fb853db83e0::netstream_payments::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        check_registry<T0>(arg0, arg3);
        assert!(0x2::vec_map::contains<u64, Plan>(&arg1.plans, &arg2), 22);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::vec_map::get<u64, Plan>(&arg1.plans, &arg2);
        assert!(v0 >= v1.next_due_ms, 24);
        assert!(v0 <= v1.next_due_ms + 259200000, 25);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= v1.amount, 6);
        pay_period<T0>(arg1, arg2, arg3, arg4, v0, arg5, arg6);
    }

    public fun configure<T0>(arg0: &AdminCap, arg1: &mut Settings, arg2: &0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>) {
        assert!(0x1::option::is_none<0x1::ascii::String>(&arg1.coin_type) && 0x1::option::is_none<0x2::object::ID>(&arg1.registry_id), 14);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        arg1.coin_type = 0x1::option::some<0x1::ascii::String>(v0);
        arg1.registry_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg2));
        let v1 = Configured{
            coin_type   : v0,
            registry_id : 0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg2),
        };
        0x2::event::emit<Configured>(v1);
    }

    public fun device_count<T0>(arg0: &Credits<T0>) : u64 {
        0x2::vec_map::length<address, u64>(&arg0.keys)
    }

    public fun device_expiry<T0>(arg0: &Credits<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.keys, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.keys, &arg1)
        } else {
            0
        }
    }

    fun emit_settings(arg0: &Settings) {
        let v0 = SettingsChanged{
            paused          : arg0.paused,
            max_balance     : arg0.max_balance,
            max_per_day_cap : arg0.max_per_day_cap,
            max_per_plan    : arg0.max_per_plan,
        };
        0x2::event::emit<SettingsChanged>(v0);
    }

    public fun grace_ms() : u64 {
        259200000
    }

    public fun has_plan<T0>(arg0: &Credits<T0>, arg1: u64) : bool {
        0x2::vec_map::contains<u64, Plan>(&arg0.plans, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Settings{
            id              : 0x2::object::new(arg0),
            paused          : false,
            max_balance     : 500000000,
            max_per_day_cap : 100000000,
            max_per_plan    : 50000000,
            coin_type       : 0x1::option::none<0x1::ascii::String>(),
            registry_id     : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Settings>(v1);
    }

    public fun is_paused(arg0: &Settings) : bool {
        arg0.paused
    }

    public fun limits<T0>(arg0: &Credits<T0>) : (u64, u64) {
        (arg0.max_per_gift, arg0.max_per_day)
    }

    public fun max_balance(arg0: &Settings) : u64 {
        arg0.max_balance
    }

    public fun max_per_day_cap(arg0: &Settings) : u64 {
        arg0.max_per_day_cap
    }

    public fun max_per_plan(arg0: &Settings) : u64 {
        arg0.max_per_plan
    }

    public fun open<T0>(arg0: &Settings, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        assert!(v0 <= arg0.max_balance, 10);
        check_limits(arg0, arg2, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = Credits<T0>{
            id           : 0x2::object::new(arg7),
            owner        : v2,
            funds        : 0x2::coin::into_balance<T0>(arg1),
            keys         : 0x2::vec_map::empty<address, u64>(),
            max_per_gift : arg2,
            max_per_day  : arg3,
            day_start_ms : v1,
            spent_today  : 0,
            total_sent   : 0,
            plans        : 0x2::vec_map::empty<u64, Plan>(),
            next_plan_id : 0,
        };
        let v4 = CreditsOpened{
            credits_id   : 0x2::object::id<Credits<T0>>(&v3),
            owner        : v2,
            amount       : v0,
            max_per_gift : arg2,
            max_per_day  : arg3,
        };
        0x2::event::emit<CreditsOpened>(v4);
        if (0x1::option::is_some<address>(&arg4)) {
            let v5 = &mut v3;
            put_key<T0>(v5, *0x1::option::borrow<address>(&arg4), arg5, v1);
        };
        0x2::transfer::share_object<Credits<T0>>(v3);
    }

    public fun owner<T0>(arg0: &Credits<T0>) : address {
        arg0.owner
    }

    fun pay_period<T0>(arg0: &mut Credits<T0>, arg1: u64, arg2: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg3: &mut 0x299548dbaff253e60a6757a2f61975dc20fbadfbce47968d9a8c3fb853db83e0::netstream_payments::Config, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        let v1 = 0x2::vec_map::get_mut<u64, Plan>(&mut arg0.plans, &arg1);
        let v2 = v1.amount;
        let v3 = v1.creator;
        let v4 = v1.kind;
        v1.next_due_ms = v1.next_due_ms + v1.period_ms;
        v1.paid = v1.paid + 1;
        0x299548dbaff253e60a6757a2f61975dc20fbadfbce47968d9a8c3fb853db83e0::netstream_payments::process_payment<T0>(0x2::coin::take<T0>(&mut arg0.funds, v2, arg6), v3, v4, 0x2::address::to_string(v0), arg2, arg3, arg5, arg6);
        let v5 = PlanPaid{
            credits_id    : 0x2::object::id<Credits<T0>>(arg0),
            plan_id       : arg1,
            coin_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            owner         : v0,
            creator       : v3,
            kind          : v4,
            amount        : v2,
            period        : v1.paid,
            paid_until_ms : v1.next_due_ms,
            collector     : 0x2::tx_context::sender(arg6),
            remaining     : 0x2::balance::value<T0>(&arg0.funds),
            timestamp_ms  : arg4,
        };
        0x2::event::emit<PlanPaid>(v5);
    }

    public fun plan<T0>(arg0: &Credits<T0>, arg1: u64) : (address, 0x1::string::String, u64, u64, u64, u64) {
        let v0 = 0x2::vec_map::get<u64, Plan>(&arg0.plans, &arg1);
        (v0.creator, v0.kind, v0.amount, v0.period_ms, v0.next_due_ms, v0.paid)
    }

    public fun plan_count<T0>(arg0: &Credits<T0>) : u64 {
        0x2::vec_map::length<u64, Plan>(&arg0.plans)
    }

    fun put_key<T0>(arg0: &mut Credits<T0>, arg1: address, arg2: u64, arg3: u64) {
        assert!(arg1 != arg0.owner && arg1 != @0x0, 20);
        check_expiry(arg3, arg2);
        if (0x2::vec_map::contains<address, u64>(&arg0.keys, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.keys, &arg1) = arg2;
        } else {
            assert!(0x2::vec_map::length<address, u64>(&arg0.keys) < 5, 18);
            0x2::vec_map::insert<address, u64>(&mut arg0.keys, arg1, arg2);
        };
        let v0 = DeviceChanged{
            credits_id    : 0x2::object::id<Credits<T0>>(arg0),
            owner         : arg0.owner,
            device        : arg1,
            expires_at_ms : arg2,
        };
        0x2::event::emit<DeviceChanged>(v0);
    }

    public fun remove_device<T0>(arg0: &mut Credits<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || v0 == arg1, 2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.keys, &arg1), 19);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.keys, &arg1);
        let v3 = DeviceChanged{
            credits_id    : 0x2::object::id<Credits<T0>>(arg0),
            owner         : arg0.owner,
            device        : arg1,
            expires_at_ms : 0,
        };
        0x2::event::emit<DeviceChanged>(v3);
    }

    public fun set_limits<T0>(arg0: &Settings, arg1: &mut Credits<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        check_limits(arg0, arg2, arg3);
        arg1.max_per_gift = arg2;
        arg1.max_per_day = arg3;
        let v0 = LimitsChanged{
            credits_id   : 0x2::object::id<Credits<T0>>(arg1),
            owner        : arg1.owner,
            max_per_gift : arg2,
            max_per_day  : arg3,
        };
        0x2::event::emit<LimitsChanged>(v0);
    }

    public fun set_max_balance(arg0: &AdminCap, arg1: &mut Settings, arg2: u64) {
        assert!(arg2 > 0, 11);
        arg1.max_balance = arg2;
        emit_settings(arg1);
    }

    public fun set_max_per_day_cap(arg0: &AdminCap, arg1: &mut Settings, arg2: u64) {
        assert!(arg2 > 0, 11);
        arg1.max_per_day_cap = arg2;
        emit_settings(arg1);
    }

    public fun set_max_per_plan(arg0: &AdminCap, arg1: &mut Settings, arg2: u64) {
        assert!(arg2 > 0, 11);
        arg1.max_per_plan = arg2;
        emit_settings(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Settings, arg2: bool) {
        arg1.paused = arg2;
        emit_settings(arg1);
    }

    public fun spent_today<T0>(arg0: &Credits<T0>) : u64 {
        arg0.spent_today
    }

    public fun start_plan<T0>(arg0: &Settings, arg1: &mut Credits<T0>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg7: &mut 0x299548dbaff253e60a6757a2f61975dc20fbadfbce47968d9a8c3fb853db83e0::netstream_payments::Config, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg1.owner, 1);
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        check_registry<T0>(arg0, arg6);
        assert!(arg2 != arg1.owner, 8);
        assert!(arg2 != @0x0, 17);
        let v0 = 0x1::string::length(&arg3);
        assert!(v0 > 0 && v0 <= 32, 26);
        assert!(arg4 > 0 && arg4 <= arg0.max_per_plan, 26);
        assert!(arg5 >= 604800000 && arg5 <= 31622400000, 26);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<u64, Plan>(&arg1.plans)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<u64, Plan>(&arg1.plans, v2);
            if (v4.creator == arg2 && v4.kind == arg3) {
                assert!(v1 > v4.next_due_ms + 259200000, 23);
                let v5 = *v3;
                let (_, _) = 0x2::vec_map::remove<u64, Plan>(&mut arg1.plans, &v5);
                break
            };
            v2 = v2 + 1;
        };
        assert!(0x2::vec_map::length<u64, Plan>(&arg1.plans) < 20, 21);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= arg4, 6);
        let v8 = arg1.next_plan_id;
        arg1.next_plan_id = v8 + 1;
        let v9 = Plan{
            creator     : arg2,
            kind        : arg3,
            amount      : arg4,
            period_ms   : arg5,
            next_due_ms : v1,
            paid        : 0,
        };
        0x2::vec_map::insert<u64, Plan>(&mut arg1.plans, v8, v9);
        let v10 = PlanStarted{
            credits_id : 0x2::object::id<Credits<T0>>(arg1),
            plan_id    : v8,
            owner      : arg1.owner,
            creator    : arg2,
            kind       : arg3,
            amount     : arg4,
            period_ms  : arg5,
        };
        0x2::event::emit<PlanStarted>(v10);
        pay_period<T0>(arg1, v8, arg6, arg7, v1, arg8, arg9);
    }

    public fun top_up<T0>(arg0: &Settings, arg1: &mut Credits<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        assert!(0x2::balance::value<T0>(&arg1.funds) + v0 <= arg0.max_balance, 10);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg2));
        let v1 = CreditsToppedUp{
            credits_id  : 0x2::object::id<Credits<T0>>(arg1),
            owner       : arg1.owner,
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg1.funds),
        };
        0x2::event::emit<CreditsToppedUp>(v1);
    }

    public fun total_sent<T0>(arg0: &Credits<T0>) : u64 {
        arg0.total_sent
    }

    public fun withdraw<T0>(arg0: &mut Credits<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 > 0, 7);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg1, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funds, arg1, arg2), arg0.owner);
        let v0 = CreditsWithdrawn{
            credits_id  : 0x2::object::id<Credits<T0>>(arg0),
            owner       : arg0.owner,
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.funds),
        };
        0x2::event::emit<CreditsWithdrawn>(v0);
    }

    public fun withdraw_all<T0>(arg0: &mut Credits<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funds, v0, arg1), arg0.owner);
        };
        while (0x2::vec_map::length<address, u64>(&arg0.keys) > 0) {
            let (v1, _) = 0x2::vec_map::remove_entry_by_idx<address, u64>(&mut arg0.keys, 0);
            let v3 = DeviceChanged{
                credits_id    : 0x2::object::id<Credits<T0>>(arg0),
                owner         : arg0.owner,
                device        : v1,
                expires_at_ms : 0,
            };
            0x2::event::emit<DeviceChanged>(v3);
        };
        let v4 = CreditsWithdrawn{
            credits_id  : 0x2::object::id<Credits<T0>>(arg0),
            owner       : arg0.owner,
            amount      : v0,
            new_balance : 0,
        };
        0x2::event::emit<CreditsWithdrawn>(v4);
    }

    // decompiled from Move bytecode v7
}

