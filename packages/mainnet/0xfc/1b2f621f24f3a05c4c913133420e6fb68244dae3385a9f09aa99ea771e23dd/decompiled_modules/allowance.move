module 0xfc1b2f621f24f3a05c4c913133420e6fb68244dae3385a9f09aa99ea771e23dd::allowance {
    struct ActivityEntry has copy, drop, store {
        kind: u8,
        actor: address,
        amount: u64,
        timestamp_ms: u64,
        aux: u64,
    }

    struct AllowanceVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        start_ms: u64,
        period_ms: u64,
        amount_per_period: u64,
        claimed_total: u64,
        created_at_ms: u64,
        closed: bool,
        activity: vector<ActivityEntry>,
    }

    struct AllowanceMembership<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AllowanceCreatedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        amount_per_period: u64,
        period_ms: u64,
        created_at_ms: u64,
    }

    struct AllowanceToppedUpEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
        new_balance: u64,
        topped_up_at_ms: u64,
    }

    struct AllowanceClaimedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        claimed_total: u64,
        new_balance: u64,
        claimed_at_ms: u64,
    }

    struct AllowanceClosedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        closed_at_ms: u64,
    }

    public fun balance<T0>(arg0: &AllowanceVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun activity_actor(arg0: &ActivityEntry) : address {
        arg0.actor
    }

    public fun activity_amount(arg0: &ActivityEntry) : u64 {
        arg0.amount
    }

    public fun activity_at<T0>(arg0: &AllowanceVault<T0>, arg1: u64) : &ActivityEntry {
        0x1::vector::borrow<ActivityEntry>(&arg0.activity, arg1)
    }

    public fun activity_aux(arg0: &ActivityEntry) : u64 {
        arg0.aux
    }

    public fun activity_kind(arg0: &ActivityEntry) : u8 {
        arg0.kind
    }

    public fun activity_len<T0>(arg0: &AllowanceVault<T0>) : u64 {
        0x1::vector::length<ActivityEntry>(&arg0.activity)
    }

    public fun activity_max() : u64 {
        100
    }

    public fun activity_timestamp_ms(arg0: &ActivityEntry) : u64 {
        arg0.timestamp_ms
    }

    public fun amount_per_period<T0>(arg0: &AllowanceVault<T0>) : u64 {
        arg0.amount_per_period
    }

    fun assert_supported_coin<T0>() {
        assert!(is_supported_coin<T0>(), 22);
    }

    public fun claim<T0>(arg0: &mut AllowanceVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_internal<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun claim_internal<T0>(arg0: &mut AllowanceVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 60);
        assert!(!arg0.closed, 31);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = claimable_at<T0>(arg0, v0);
        assert!(v1 > 0, 30);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2);
        arg0.claimed_total = arg0.claimed_total + v1;
        let v3 = 0x2::balance::value<T0>(&arg0.balance);
        let v4 = arg0.owner;
        let v5 = ActivityEntry{
            kind         : 2,
            actor        : v4,
            amount       : v1,
            timestamp_ms : v0,
            aux          : periods_elapsed_at<T0>(arg0, v0),
        };
        push_activity<T0>(arg0, v5);
        let v6 = AllowanceClaimedEvent<T0>{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            owner         : v4,
            amount        : v1,
            claimed_total : arg0.claimed_total,
            new_balance   : v3,
            claimed_at_ms : v0,
        };
        0x2::event::emit<AllowanceClaimedEvent<T0>>(v6);
        v2
    }

    public fun claimable<T0>(arg0: &AllowanceVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.closed) {
            0
        } else {
            claimable_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
        }
    }

    fun claimable_at<T0>(arg0: &AllowanceVault<T0>, arg1: u64) : u64 {
        let v0 = arg0.claimed_total;
        let v1 = (periods_elapsed_at<T0>(arg0, arg1) as u128) * (arg0.amount_per_period as u128);
        let v2 = (0x2::balance::value<T0>(&arg0.balance) as u128) + (v0 as u128);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        ((v3 - (v0 as u128)) as u64)
    }

    public fun claimed_total<T0>(arg0: &AllowanceVault<T0>) : u64 {
        arg0.claimed_total
    }

    public fun close<T0>(arg0: &mut AllowanceVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 60);
        assert!(!arg0.closed, 31);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 32);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2);
        arg0.closed = true;
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = arg0.owner;
        let v4 = ActivityEntry{
            kind         : 3,
            actor        : v3,
            amount       : v0,
            timestamp_ms : v2,
            aux          : 0,
        };
        push_activity<T0>(arg0, v4);
        let v5 = AllowanceClosedEvent<T0>{
            vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            owner        : v3,
            amount       : v0,
            closed_at_ms : v2,
        };
        0x2::event::emit<AllowanceClosedEvent<T0>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v3);
    }

    public fun closed<T0>(arg0: &AllowanceVault<T0>) : bool {
        arg0.closed
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_supported_coin<T0>();
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 20);
        assert!(v0 >= min_amount_for<T0>(), 21);
        assert!(arg1 > 0, 23);
        assert!(arg2 >= 3600000, 24);
        assert!(arg2 <= 31536000000, 25);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x1::vector::empty<ActivityEntry>();
        let v4 = ActivityEntry{
            kind         : 0,
            actor        : v2,
            amount       : v0,
            timestamp_ms : v1,
            aux          : arg1,
        };
        0x1::vector::push_back<ActivityEntry>(&mut v3, v4);
        let v5 = AllowanceVault<T0>{
            id                : 0x2::object::new(arg4),
            owner             : v2,
            balance           : 0x2::coin::into_balance<T0>(arg0),
            start_ms          : v1,
            period_ms         : arg2,
            amount_per_period : arg1,
            claimed_total     : 0,
            created_at_ms     : v1,
            closed            : false,
            activity          : v3,
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        let v7 = AllowanceMembership<T0>{
            id       : 0x2::object::new(arg4),
            vault_id : v6,
        };
        0x2::transfer::transfer<AllowanceMembership<T0>>(v7, v2);
        0x2::transfer::share_object<AllowanceVault<T0>>(v5);
        let v8 = AllowanceCreatedEvent<T0>{
            vault_id          : v6,
            owner             : v2,
            amount            : v0,
            amount_per_period : arg1,
            period_ms         : arg2,
            created_at_ms     : v1,
        };
        0x2::event::emit<AllowanceCreatedEvent<T0>>(v8);
    }

    public fun created_at_ms<T0>(arg0: &AllowanceVault<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun is_supported_coin<T0>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        v0 == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") || v0 == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")
    }

    public fun max_period_ms() : u64 {
        31536000000
    }

    public fun min_amount_for<T0>() : u64 {
        if (0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI")) {
            1000000000
        } else {
            1000000
        }
    }

    public fun min_period_ms() : u64 {
        3600000
    }

    public fun owner<T0>(arg0: &AllowanceVault<T0>) : address {
        arg0.owner
    }

    public fun period_ms<T0>(arg0: &AllowanceVault<T0>) : u64 {
        arg0.period_ms
    }

    public fun periods_elapsed<T0>(arg0: &AllowanceVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        periods_elapsed_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun periods_elapsed_at<T0>(arg0: &AllowanceVault<T0>, arg1: u64) : u64 {
        if (arg1 <= arg0.start_ms) {
            0
        } else {
            (arg1 - arg0.start_ms) / arg0.period_ms
        }
    }

    fun push_activity<T0>(arg0: &mut AllowanceVault<T0>, arg1: ActivityEntry) {
        if (0x1::vector::length<ActivityEntry>(&arg0.activity) >= 100) {
            0x1::vector::remove<ActivityEntry>(&mut arg0.activity, 0);
        };
        0x1::vector::push_back<ActivityEntry>(&mut arg0.activity, arg1);
    }

    public fun start_ms<T0>(arg0: &AllowanceVault<T0>) : u64 {
        arg0.start_ms
    }

    public fun top_up<T0>(arg0: &mut AllowanceVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 20);
        assert!(v0 >= min_amount_for<T0>(), 21);
        assert!(!arg0.closed, 31);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = ActivityEntry{
            kind         : 1,
            actor        : v2,
            amount       : v0,
            timestamp_ms : v3,
            aux          : v1,
        };
        push_activity<T0>(arg0, v4);
        let v5 = AllowanceToppedUpEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            contributor     : v2,
            amount          : v0,
            new_balance     : v1,
            topped_up_at_ms : v3,
        };
        0x2::event::emit<AllowanceToppedUpEvent<T0>>(v5);
    }

    public fun vault_id_of<T0>(arg0: &AllowanceMembership<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

