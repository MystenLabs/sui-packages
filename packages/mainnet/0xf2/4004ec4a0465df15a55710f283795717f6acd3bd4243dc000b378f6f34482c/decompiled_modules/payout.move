module 0xf24004ec4a0465df15a55710f283795717f6acd3bd4243dc000b378f6f34482c::payout {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        authorizer_id: 0x1::option::Option<0x2::object::ID>,
        payments_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct AuthorizerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cadence: u8,
        vault: 0x2::balance::Balance<T0>,
        reserved: u64,
        max_per_item: u64,
        max_per_period: u64,
        authorization_paused: bool,
        lookback_days: u64,
        pay_delay_ms: u64,
        period_totals: 0x2::table::Table<u64, u64>,
        payouts: 0x2::table::Table<PayoutKey, Payout>,
    }

    struct PayoutKey has copy, drop, store {
        period: u64,
        recipient: address,
    }

    struct Payout has copy, drop, store {
        amount: u64,
        paid: bool,
        authorized_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        treasury: address,
    }

    struct PoolCreated has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        cadence: u8,
        max_per_item: u64,
        max_per_period: u64,
        lookback_days: u64,
        pay_delay_ms: u64,
    }

    struct Funded has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        amount: u64,
    }

    struct BatchAuthorized has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        period: u64,
        manifest_hash: vector<u8>,
        items: u64,
        total: u64,
    }

    struct PayoutAuthorized has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        period: u64,
        recipient: address,
        amount: u64,
    }

    struct PayoutPaid has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        period: u64,
        recipient: address,
        amount: u64,
    }

    struct BatchPaid has copy, drop {
        pool_id: 0x2::object::ID,
        period: u64,
        paid: u64,
        skipped: u64,
        total: u64,
    }

    struct PayoutCancelled has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::ascii::String,
        period: u64,
        recipient: address,
        amount: u64,
    }

    struct PayoutPruned has copy, drop {
        pool_id: 0x2::object::ID,
        period: u64,
        recipients: vector<address>,
    }

    struct UnreservedWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
    }

    struct LimitsChanged has copy, drop {
        pool_id: 0x2::object::ID,
        max_per_item: u64,
        max_per_period: u64,
        lookback_days: u64,
        pay_delay_ms: u64,
    }

    struct Migrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct PauseChanged has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        authorization: bool,
        paused: bool,
    }

    struct AuthorizerRotated has copy, drop {
        registry_id: 0x2::object::ID,
        authorizer_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct TreasuryChanged has copy, drop {
        registry_id: 0x2::object::ID,
        treasury: address,
    }

    public fun payout<T0>(arg0: &Pool<T0>, arg1: u64, arg2: address) : (u64, bool) {
        let v0 = PayoutKey{
            period    : arg1,
            recipient : arg2,
        };
        assert!(0x2::table::contains<PayoutKey, Payout>(&arg0.payouts, v0), 6);
        let v1 = 0x2::table::borrow<PayoutKey, Payout>(&arg0.payouts, v0);
        (v1.amount, v1.paid)
    }

    fun assert_admin(arg0: &Registry, arg1: &AdminCap) {
        assert_version(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_authorizer(arg0: &Registry, arg1: &AuthorizerCap) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0) && arg0.authorizer_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<AuthorizerCap>(arg1)), 3);
    }

    fun assert_limits(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg1 >= arg0, 13);
    }

    fun assert_pool<T0>(arg0: &Registry, arg1: &Pool<T0>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_timing(arg0: u64, arg1: u64) {
        let v0 = if (arg0 >= 1) {
            if (arg0 <= 90) {
                arg1 <= 86400000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 22);
    }

    fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 1, 2);
    }

    fun asset<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public fun authorize_batch<T0>(arg0: &Registry, arg1: &AuthorizerCap, arg2: &mut Pool<T0>, arg3: u64, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u64>, arg7: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_pool<T0>(arg0, arg2);
        assert_authorizer(arg0, arg1);
        assert!(!arg2.authorization_paused, 8);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 20);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = v0 / 86400000;
        assert!(arg3 < v1 && arg3 + arg2.lookback_days >= v1, 14);
        assert!(arg2.cadence == 1 || is_last_day_of_month(arg3), 14);
        let v2 = 0x1::vector::length<address>(&arg5);
        let v3 = if (v2 > 0) {
            if (v2 <= 256) {
                0x1::vector::length<u64>(&arg6) == v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 4);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = *0x1::vector::borrow<address>(&arg5, v5);
            let v7 = *0x1::vector::borrow<u64>(&arg6, v5);
            assert!(v6 != @0x0, 11);
            assert!(v7 > 0, 9);
            assert!(v7 <= arg2.max_per_item, 12);
            let v8 = PayoutKey{
                period    : arg3,
                recipient : v6,
            };
            assert!(!0x2::table::contains<PayoutKey, Payout>(&arg2.payouts, v8), 5);
            let v9 = Payout{
                amount        : v7,
                paid          : false,
                authorized_ms : v0,
            };
            0x2::table::add<PayoutKey, Payout>(&mut arg2.payouts, v8, v9);
            let v10 = PayoutAuthorized{
                pool_id   : 0x2::object::id<Pool<T0>>(arg2),
                asset     : asset<T0>(),
                period    : arg3,
                recipient : v6,
                amount    : v7,
            };
            0x2::event::emit<PayoutAuthorized>(v10);
            v4 = v4 + v7;
            v5 = v5 + 1;
        };
        if (!0x2::table::contains<u64, u64>(&arg2.period_totals, arg3)) {
            0x2::table::add<u64, u64>(&mut arg2.period_totals, arg3, 0);
        };
        let v11 = arg2.max_per_period;
        let v12 = 0x2::table::borrow_mut<u64, u64>(&mut arg2.period_totals, arg3);
        assert!(*v12 <= v11 && v4 <= v11 - *v12, 13);
        assert!(v4 <= available<T0>(arg2), 7);
        *v12 = *v12 + v4;
        arg2.reserved = arg2.reserved + v4;
        let v13 = BatchAuthorized{
            pool_id       : 0x2::object::id<Pool<T0>>(arg2),
            asset         : asset<T0>(),
            period        : arg3,
            manifest_hash : arg4,
            items         : v2,
            total         : v4,
        };
        0x2::event::emit<BatchAuthorized>(v13);
    }

    public fun available<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault) - arg0.reserved
    }

    public fun cadence<T0>(arg0: &Pool<T0>) : u8 {
        arg0.cadence
    }

    public fun cadence_daily() : u8 {
        1
    }

    public fun cadence_monthly() : u8 {
        2
    }

    public fun cancel_unpaid<T0>(arg0: &Registry, arg1: &AdminCap, arg2: &mut Pool<T0>, arg3: u64, arg4: vector<address>) {
        assert_admin(arg0, arg1);
        assert_pool<T0>(arg0, arg2);
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0 && v0 <= 256, 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = PayoutKey{
                period    : arg3,
                recipient : *0x1::vector::borrow<address>(&arg4, v1),
            };
            assert!(0x2::table::contains<PayoutKey, Payout>(&arg2.payouts, v2), 6);
            let v3 = 0x2::table::remove<PayoutKey, Payout>(&mut arg2.payouts, v2);
            assert!(!v3.paid, 16);
            arg2.reserved = arg2.reserved - v3.amount;
            let v4 = 0x2::table::borrow_mut<u64, u64>(&mut arg2.period_totals, arg3);
            *v4 = *v4 - v3.amount;
            let v5 = PayoutCancelled{
                pool_id   : 0x2::object::id<Pool<T0>>(arg2),
                asset     : asset<T0>(),
                period    : arg3,
                recipient : v2.recipient,
                amount    : v3.amount,
            };
            0x2::event::emit<PayoutCancelled>(v5);
            v1 = v1 + 1;
        };
    }

    public fun create_pool<T0>(arg0: &Registry, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = new_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = PoolCreated{
            registry_id    : 0x2::object::id<Registry>(arg0),
            pool_id        : 0x2::object::id<Pool<T0>>(&v0),
            asset          : asset<T0>(),
            cadence        : arg2,
            max_per_item   : arg3,
            max_per_period : arg4,
            lookback_days  : arg5,
            pay_delay_ms   : arg6,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun day_of_month(arg0: u64) : u64 {
        let v0 = arg0 + 719468;
        let v1 = v0 - v0 / 146097 * 146097;
        let v2 = (v1 - v1 / 1460 + v1 / 36524 - v1 / 146096) / 365;
        let v3 = v1 - 365 * v2 + v2 / 4 - v2 / 100;
        v3 - (153 * (5 * v3 + 2) / 153 + 2) / 5 + 1
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Funded{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            asset   : asset<T0>(),
            amount  : v0,
        };
        0x2::event::emit<Funded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = new_registry(v0, arg0);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v1);
    }

    fun is_last_day_of_month(arg0: u64) : bool {
        day_of_month(arg0 + 1) == 1
    }

    public fun lookback_days<T0>(arg0: &Pool<T0>) : u64 {
        arg0.lookback_days
    }

    public fun max_items() : u64 {
        256
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg0.version < 1, 2);
        let v0 = Migrated{
            registry_id  : 0x2::object::id<Registry>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg0.version = 1;
    }

    fun new_pool<T0>(arg0: &Registry, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert_admin(arg0, arg1);
        assert!(arg2 == 1 || arg2 == 2, 19);
        assert_limits(arg3, arg4);
        assert_timing(arg5, arg6);
        Pool<T0>{
            id                   : 0x2::object::new(arg7),
            registry_id          : 0x2::object::id<Registry>(arg0),
            cadence              : arg2,
            vault                : 0x2::balance::zero<T0>(),
            reserved             : 0,
            max_per_item         : arg3,
            max_per_period       : arg4,
            authorization_paused : false,
            lookback_days        : arg5,
            pay_delay_ms         : arg6,
            period_totals        : 0x2::table::new<u64, u64>(arg7),
            payouts              : 0x2::table::new<PayoutKey, Payout>(arg7),
        }
    }

    fun new_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (Registry, AdminCap) {
        assert!(arg0 != @0x0, 11);
        let v0 = Registry{
            id              : 0x2::object::new(arg1),
            version         : 1,
            treasury        : arg0,
            authorizer_id   : 0x1::option::none<0x2::object::ID>(),
            payments_paused : false,
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg1),
            registry_id : 0x2::object::id<Registry>(&v0),
        };
        let v2 = RegistryCreated{
            registry_id : 0x2::object::id<Registry>(&v0),
            treasury    : arg0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        (v0, v1)
    }

    public fun pay_batch<T0>(arg0: &Registry, arg1: &mut Pool<T0>, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_pool<T0>(arg0, arg1);
        assert!(!arg0.payments_paused, 15);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0 && v0 <= 256, 4);
        let v1 = 0x2::object::id<Pool<T0>>(arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = PayoutKey{
                period    : arg2,
                recipient : *0x1::vector::borrow<address>(&arg3, v4),
            };
            assert!(0x2::table::contains<PayoutKey, Payout>(&arg1.payouts, v5), 6);
            let v6 = 0x2::table::borrow_mut<PayoutKey, Payout>(&mut arg1.payouts, v5);
            if (!v6.paid) {
                assert!(0x2::clock::timestamp_ms(arg4) >= v6.authorized_ms + arg1.pay_delay_ms, 21);
                let v7 = v6.amount;
                v6.paid = true;
                arg1.reserved = arg1.reserved - v7;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v7), arg5), v5.recipient);
                let v8 = PayoutPaid{
                    pool_id   : v1,
                    asset     : asset<T0>(),
                    period    : arg2,
                    recipient : v5.recipient,
                    amount    : v7,
                };
                0x2::event::emit<PayoutPaid>(v8);
                v3 = v3 + 1;
                v2 = v2 + v7;
            };
            v4 = v4 + 1;
        };
        let v9 = BatchPaid{
            pool_id : v1,
            period  : arg2,
            paid    : v3,
            skipped : v0 - v3,
            total   : v2,
        };
        0x2::event::emit<BatchPaid>(v9);
    }

    public fun pay_delay_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.pay_delay_ms
    }

    public fun period_total<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.period_totals, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.period_totals, arg1)
        } else {
            0
        }
    }

    public fun prune_paid<T0>(arg0: &Registry, arg1: &mut Pool<T0>, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_pool<T0>(arg0, arg1);
        assert!(arg2 + 90 < 0x2::clock::timestamp_ms(arg4) / 86400000, 18);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0 && v0 <= 256, 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = PayoutKey{
                period    : arg2,
                recipient : *0x1::vector::borrow<address>(&arg3, v1),
            };
            assert!(0x2::table::contains<PayoutKey, Payout>(&arg1.payouts, v2), 6);
            let v3 = 0x2::table::remove<PayoutKey, Payout>(&mut arg1.payouts, v2);
            assert!(v3.paid, 17);
            v1 = v1 + 1;
        };
        let v4 = PayoutPruned{
            pool_id    : 0x2::object::id<Pool<T0>>(arg1),
            period     : arg2,
            recipients : arg3,
        };
        0x2::event::emit<PayoutPruned>(v4);
    }

    public fun reserved<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reserved
    }

    public fun retention_days() : u64 {
        90
    }

    public fun revoke_authorizer(arg0: &mut Registry, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        arg0.authorizer_id = 0x1::option::none<0x2::object::ID>();
        let v0 = AuthorizerRotated{
            registry_id   : 0x2::object::id<Registry>(arg0),
            authorizer_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<AuthorizerRotated>(v0);
    }

    public fun rotate_authorizer(arg0: &mut Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : AuthorizerCap {
        assert_admin(arg0, arg1);
        let v0 = AuthorizerCap{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        arg0.authorizer_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<AuthorizerCap>(&v0));
        let v1 = AuthorizerRotated{
            registry_id   : 0x2::object::id<Registry>(arg0),
            authorizer_id : arg0.authorizer_id,
        };
        0x2::event::emit<AuthorizerRotated>(v1);
        v0
    }

    public fun set_authorization_paused<T0>(arg0: &Registry, arg1: &AdminCap, arg2: &mut Pool<T0>, arg3: bool) {
        assert_admin(arg0, arg1);
        assert_pool<T0>(arg0, arg2);
        arg2.authorization_paused = arg3;
        let v0 = PauseChanged{
            registry_id   : 0x2::object::id<Registry>(arg0),
            pool_id       : 0x1::option::some<0x2::object::ID>(0x2::object::id<Pool<T0>>(arg2)),
            authorization : true,
            paused        : arg3,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_limits<T0>(arg0: &Registry, arg1: &AdminCap, arg2: &mut Pool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_admin(arg0, arg1);
        assert_pool<T0>(arg0, arg2);
        assert_limits(arg3, arg4);
        assert_timing(arg5, arg6);
        arg2.max_per_item = arg3;
        arg2.max_per_period = arg4;
        arg2.lookback_days = arg5;
        arg2.pay_delay_ms = arg6;
        let v0 = LimitsChanged{
            pool_id        : 0x2::object::id<Pool<T0>>(arg2),
            max_per_item   : arg3,
            max_per_period : arg4,
            lookback_days  : arg5,
            pay_delay_ms   : arg6,
        };
        0x2::event::emit<LimitsChanged>(v0);
    }

    public fun set_payments_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.payments_paused = arg2;
        let v0 = PauseChanged{
            registry_id   : 0x2::object::id<Registry>(arg0),
            pool_id       : 0x1::option::none<0x2::object::ID>(),
            authorization : false,
            paused        : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_treasury(arg0: &mut Registry, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        assert!(arg2 != @0x0, 11);
        arg0.treasury = arg2;
        let v0 = TreasuryChanged{
            registry_id : 0x2::object::id<Registry>(arg0),
            treasury    : arg2,
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun vault_balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun withdraw_unreserved<T0>(arg0: &Registry, arg1: &AdminCap, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_pool<T0>(arg0, arg2);
        assert!(arg3 > 0, 9);
        assert!(arg3 <= available<T0>(arg2), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.vault, arg3), arg4), arg0.treasury);
        let v0 = UnreservedWithdrawn{
            pool_id  : 0x2::object::id<Pool<T0>>(arg2),
            treasury : arg0.treasury,
            amount   : arg3,
        };
        0x2::event::emit<UnreservedWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

