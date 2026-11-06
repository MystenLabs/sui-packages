module 0x5065412934bf6d7e344656972694e5f0c84a5c02c05472787076f4bdc72b9993::grant {
    struct Grant has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        agent: address,
        weekly_budget: u64,
        per_call_cap: u64,
        spent_this_week: u64,
        week_start_ms: u64,
        expires_ms: u64,
        revoked: bool,
        last_heartbeat_ms: u64,
        dormancy_ms: u64,
        service_caps: 0x2::vec_map::VecMap<address, u64>,
        total_spent: u64,
        payments: u64,
    }

    struct VaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Deposited has copy, drop {
        grant: 0x2::object::ID,
        from: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        grant: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct GrantCreated has copy, drop {
        grant: 0x2::object::ID,
        owner: address,
        agent: address,
        weekly_budget: u64,
        per_call_cap: u64,
        expires_ms: u64,
        dormancy_ms: u64,
    }

    struct SpendRecorded has copy, drop {
        grant: 0x2::object::ID,
        payee: address,
        amount: u64,
        digest: vector<u8>,
        spent_this_week: u64,
    }

    struct CapChanged has copy, drop {
        grant: 0x2::object::ID,
        payee: address,
        cap: u64,
    }

    struct Heartbeat has copy, drop {
        grant: 0x2::object::ID,
        at_ms: u64,
    }

    struct Revoked has copy, drop {
        grant: 0x2::object::ID,
    }

    public fun active(arg0: &Grant, arg1: u64) : bool {
        if (!arg0.revoked) {
            if (arg1 < arg0.expires_ms) {
                arg1 < arg0.last_heartbeat_ms + arg0.dormancy_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun agent(arg0: &Grant) : address {
        arg0.agent
    }

    fun apply_spend(arg0: &mut Grant, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(!arg0.revoked, 2);
        assert!(v0 < arg0.expires_ms, 3);
        assert!(v0 < arg0.last_heartbeat_ms + arg0.dormancy_ms, 4);
        assert!(arg2 <= cap_for(arg0, arg1), 5);
        if (v0 >= arg0.week_start_ms + 604800000) {
            arg0.week_start_ms = arg0.week_start_ms + (v0 - arg0.week_start_ms) / 604800000 * 604800000;
            arg0.spent_this_week = 0;
        };
        assert!(arg0.spent_this_week + arg2 <= arg0.weekly_budget, 6);
        arg0.spent_this_week = arg0.spent_this_week + arg2;
        arg0.total_spent = arg0.total_spent + arg2;
        arg0.payments = arg0.payments + 1;
        let v1 = SpendRecorded{
            grant           : 0x2::object::id<Grant>(arg0),
            payee           : arg1,
            amount          : arg2,
            digest          : arg3,
            spent_this_week : arg0.spent_this_week,
        };
        0x2::event::emit<SpendRecorded>(v1);
    }

    fun assert_owner(arg0: &Grant, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    fun assert_usdc<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(*0x1::type_name::as_string(&v0) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 10);
    }

    public fun cap_for(arg0: &Grant, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.service_caps, &arg1)) {
            let v1 = *0x2::vec_map::get<address, u64>(&arg0.service_caps, &arg1);
            if (v1 < arg0.per_call_cap) {
                v1
            } else {
                arg0.per_call_cap
            }
        } else {
            arg0.per_call_cap
        }
    }

    entry fun create(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg2 > 0 && arg2 <= arg1, 7);
        assert!(arg3 > v0 && arg4 > 0, 7);
        let v1 = Grant{
            id                : 0x2::object::new(arg6),
            version           : 1,
            owner             : 0x2::tx_context::sender(arg6),
            agent             : arg0,
            weekly_budget     : arg1,
            per_call_cap      : arg2,
            spent_this_week   : 0,
            week_start_ms     : v0,
            expires_ms        : arg3,
            revoked           : false,
            last_heartbeat_ms : v0,
            dormancy_ms       : arg4,
            service_caps      : 0x2::vec_map::empty<address, u64>(),
            total_spent       : 0,
            payments          : 0,
        };
        let v2 = GrantCreated{
            grant         : 0x2::object::id<Grant>(&v1),
            owner         : v1.owner,
            agent         : arg0,
            weekly_budget : arg1,
            per_call_cap  : arg2,
            expires_ms    : arg3,
            dormancy_ms   : arg4,
        };
        0x2::event::emit<GrantCreated>(v2);
        0x2::transfer::share_object<Grant>(v1);
    }

    entry fun deposit<T0>(arg0: &mut Grant, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert_usdc<T0>();
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = VaultKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VaultKey>(&arg0.id, v1)) {
            let v2 = VaultKey{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v3 = VaultKey{dummy_field: false};
            0x2::dynamic_field::add<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::coin::into_balance<T0>(arg1));
        };
        let v4 = Deposited{
            grant  : 0x2::object::id<Grant>(arg0),
            from   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Deposited>(v4);
    }

    entry fun heartbeat(arg0: &mut Grant, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.last_heartbeat_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = Heartbeat{
            grant : 0x2::object::id<Grant>(arg0),
            at_ms : arg0.last_heartbeat_ms,
        };
        0x2::event::emit<Heartbeat>(v0);
    }

    public fun owner(arg0: &Grant) : address {
        arg0.owner
    }

    entry fun pay<T0>(arg0: &mut Grant, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert_usdc<T0>();
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 1);
        apply_spend(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg2, arg5), arg1);
    }

    public fun payments(arg0: &Grant) : u64 {
        arg0.payments
    }

    entry fun record_spend(arg0: &mut Grant, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 1);
        apply_spend(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun revoke(arg0: &mut Grant, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.revoked = true;
        let v0 = Revoked{grant: 0x2::object::id<Grant>(arg0)};
        0x2::event::emit<Revoked>(v0);
    }

    public fun revoked(arg0: &Grant) : bool {
        arg0.revoked
    }

    entry fun set_service_cap(arg0: &mut Grant, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert!(arg2 <= arg0.per_call_cap, 7);
        if (0x2::vec_map::contains<address, u64>(&arg0.service_caps, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.service_caps, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.service_caps, arg1, arg2);
        };
        let v0 = CapChanged{
            grant : 0x2::object::id<Grant>(arg0),
            payee : arg1,
            cap   : arg2,
        };
        0x2::event::emit<CapChanged>(v0);
    }

    public fun spent_this_week(arg0: &Grant) : u64 {
        arg0.spent_this_week
    }

    fun take<T0>(arg0: &mut Grant, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = VaultKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<VaultKey>(&arg0.id, v0), 11);
        let v1 = VaultKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 11);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg2)
    }

    public fun total_spent(arg0: &Grant) : u64 {
        arg0.total_spent
    }

    public fun vault_balance<T0>(arg0: &Grant) : u64 {
        let v0 = VaultKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VaultKey>(&arg0.id, v0)) {
            let v2 = VaultKey{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<VaultKey, 0x2::balance::Balance<T0>>(&arg0.id, v2))
        } else {
            0
        }
    }

    entry fun withdraw<T0>(arg0: &mut Grant, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_usdc<T0>();
        assert!(arg1 > 0, 9);
        let v0 = take<T0>(arg0, arg1, arg2);
        let v1 = arg0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v1);
        let v2 = Withdrawn{
            grant  : 0x2::object::id<Grant>(arg0),
            to     : v1,
            amount : arg1,
        };
        0x2::event::emit<Withdrawn>(v2);
    }

    // decompiled from Move bytecode v7
}

