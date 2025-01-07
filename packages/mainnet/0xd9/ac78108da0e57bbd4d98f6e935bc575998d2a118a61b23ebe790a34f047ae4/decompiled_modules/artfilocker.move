module 0xb8963f9f73f085e243e302ff302a7bf183a5a0a590c63b230cebf7150e7c407a::artfilocker {
    struct Locker<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        unlocked: u64,
        duration: u64,
        last_claim_time: u64,
        claim_interval: u64,
        tokens_per_interval: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct DebugClaimEvent has copy, drop {
        user: address,
        current_time: u64,
        last_claim_time: u64,
        time_since_last_claim: u64,
        claim_interval: u64,
        claimable_amount: u64,
        lapsed_amount: u64,
        total_elapsed_intervals: u64,
        claimed_intervals: u64,
    }

    struct LapsedClaimsRegistry has key {
        id: 0x2::object::UID,
    }

    struct LockerStorage has key {
        id: 0x2::object::UID,
        users: 0x2::vec_set::VecSet<address>,
    }

    struct LockEvent has copy, drop {
        user: address,
        amount: u64,
        start: u64,
        duration: u64,
    }

    struct LapsedClaimEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct UserCountEvent has copy, drop {
        count: u64,
    }

    struct DiagnosticEvent has copy, drop {
        user_address: address,
        storage_exists: bool,
        registry_exists: bool,
        start_time: u64,
        duration: u64,
    }

    struct BasicDiagnosticEvent has copy, drop {
        storage_id_exists: bool,
        registry_id_exists: bool,
        user_count: u64,
    }

    struct UserCheckEvent has copy, drop {
        user_exists: bool,
        locker_exists: bool,
    }

    struct ExpandedUserCheckEvent has copy, drop {
        user_exists: bool,
        locker_exists: bool,
        balance: u64,
        start_time: u64,
        duration: u64,
    }

    struct BulkBalanceCheckEvent has copy, drop {
        total_balance: u64,
        users_checked: u64,
    }

    struct WithdrawExpiredLockersEvent has copy, drop {
        users_processed: u64,
        total_withdrawn: u64,
    }

    struct AdminWithdrawExpiredLockersEvent has copy, drop {
        users_processed: u64,
        total_withdrawn: u64,
    }

    public fun balance<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).balance)
    }

    public entry fun admin_update_lapsed_claims<T0>(arg0: &AdminCap, arg1: &mut LockerStorage, arg2: &mut LapsedClaimsRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            let v2 = *0x1::vector::borrow<address>(&v0, v1);
            if (0x2::dynamic_field::exists_<address>(&arg1.id, v2)) {
                let v3 = 0x2::dynamic_field::borrow_mut<address, Locker<T0>>(&mut arg1.id, v2);
                let (_, v5) = unlock<T0>(v3, arg3, arg2, v2);
                if (v5 > 0) {
                    let v6 = LapsedClaimEvent{
                        user   : v2,
                        amount : v5,
                    };
                    0x2::event::emit<LapsedClaimEvent>(v6);
                };
            };
            v1 = v1 + 1;
        };
    }

    public entry fun admin_withdraw_expired_lockers<T0>(arg0: &AdminCap, arg1: &mut LockerStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::coin::zero<T0>(arg4);
        while (v1 < arg3 && !0x1::vector::is_empty<address>(&v0)) {
            let v4 = 0x1::vector::pop_back<address>(&mut v0);
            if (0x2::dynamic_field::exists_<address>(&arg1.id, v4)) {
                let v5 = 0x2::dynamic_field::borrow_mut<address, Locker<T0>>(&mut arg1.id, v4);
                if (0x2::clock::timestamp_ms(arg2) >= v5.start + v5.duration) {
                    let v6 = 0x2::balance::value<T0>(&v5.balance);
                    if (v6 > 0) {
                        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v5.balance), arg4));
                        v2 = v2 + v6;
                    };
                };
            };
            v1 = v1 + 1;
        };
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.admin);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        let v7 = AdminWithdrawExpiredLockersEvent{
            users_processed : v1,
            total_withdrawn : v2,
        };
        0x2::event::emit<AdminWithdrawExpiredLockersEvent>(v7);
    }

    public entry fun admin_withdraw_lapsed<T0>(arg0: &AdminCap, arg1: &mut LockerStorage, arg2: &mut LapsedClaimsRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 5);
        let v0 = 0x2::balance::zero<T0>();
        assert!(!0x2::vec_set::is_empty<address>(&arg1.users), 7);
        let v1 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v2 = 0x1::vector::length<address>(&v1);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<address>(&v1, v3);
            if (0x2::dynamic_field::exists_<address>(&arg2.id, v4)) {
                0x2::balance::join<T0>(&mut v0, 0x2::dynamic_field::remove<address, 0x2::balance::Balance<T0>>(&mut arg2.id, v4));
            };
            v3 = v3 + 1;
        };
        let v5 = 0;
        while (v5 < v2) {
            let v6 = *0x1::vector::borrow<address>(&v1, v5);
            if (0x2::dynamic_field::exists_<address>(&arg1.id, v6)) {
                let v7 = 0x2::dynamic_field::borrow_mut<address, Locker<T0>>(&mut arg1.id, v6);
                if (0x2::clock::timestamp_ms(arg3) >= v7.start + v7.duration) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut v7.balance));
                };
            };
            v5 = v5 + 1;
        };
        let v8 = 0x2::balance::value<T0>(&v0);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
            let v9 = AdminWithdrawEvent{amount: v8};
            0x2::event::emit<AdminWithdrawEvent>(v9);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun bulk_balance_check<T0>(arg0: &AdminCap, arg1: &LockerStorage, arg2: u64) {
        let v0 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg2 && !0x1::vector::is_empty<address>(&v0)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v0);
            if (0x2::dynamic_field::exists_<address>(&arg1.id, v3)) {
                v1 = v1 + 0x2::balance::value<T0>(&0x2::dynamic_field::borrow<address, Locker<T0>>(&arg1.id, v3).balance);
                v2 = v2 + 1;
            };
        };
        let v4 = BulkBalanceCheckEvent{
            total_balance : v1,
            users_checked : v2,
        };
        0x2::event::emit<BulkBalanceCheckEvent>(v4);
    }

    fun calculate_claimable_and_lapsed<T0>(arg0: &Locker<T0>, arg1: u64) : (u64, u64) {
        let v0 = arg0.duration / arg0.claim_interval;
        let v1 = (arg1 - arg0.start) / arg0.claim_interval;
        let v2 = arg0.unlocked / arg0.tokens_per_interval;
        let v3 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        let v4 = (arg1 - arg0.last_claim_time) / arg0.claim_interval;
        let v5 = if (v4 > 0 && v2 < v0) {
            v4
        } else {
            0
        };
        let v6 = v5 * arg0.tokens_per_interval;
        let v7 = v6;
        let v8 = if (v3 > v2 + v5) {
            v3 - v2 - v5
        } else {
            0
        };
        let v9 = v8 * arg0.tokens_per_interval;
        let v10 = v9;
        let v11 = 0x2::balance::value<T0>(&arg0.balance);
        if (v6 + v9 > v11) {
            if (v6 > v11) {
                v7 = v11;
                v10 = 0;
            } else {
                v10 = v11 - v6;
            };
        };
        (v7, v10)
    }

    public entry fun check_single_user(arg0: &AdminCap, arg1: &LockerStorage, arg2: address) {
        let v0 = UserCheckEvent{
            user_exists   : 0x2::vec_set::contains<address>(&arg1.users, &arg2),
            locker_exists : 0x2::dynamic_field::exists_<address>(&arg1.id, arg2),
        };
        0x2::event::emit<UserCheckEvent>(v0);
    }

    public entry fun claim<T0>(arg0: &mut LockerStorage, arg1: &mut LapsedClaimsRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::dynamic_field::borrow_mut<address, Locker<T0>>(&mut arg0.id, v0);
        assert!(v1 < v2.start + v2.duration, 3);
        let v3 = v1 - v2.last_claim_time;
        assert!(v3 >= v2.claim_interval, 6);
        let (v4, v5) = calculate_claimable_and_lapsed<T0>(v2, v1);
        assert!(v4 > 0, 4);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, v4), arg3), v0);
            v2.unlocked = v2.unlocked + v4;
            let v6 = ClaimEvent{
                user   : v0,
                amount : v4,
            };
            0x2::event::emit<ClaimEvent>(v6);
        };
        if (v5 > 0) {
            handle_lapsed_claims<T0>(v2, arg1, v0, v5);
            let v7 = LapsedClaimEvent{
                user   : v0,
                amount : v5,
            };
            0x2::event::emit<LapsedClaimEvent>(v7);
        };
        v2.last_claim_time = v1;
        let v8 = DebugClaimEvent{
            user                    : v0,
            current_time            : v1,
            last_claim_time         : v2.last_claim_time,
            time_since_last_claim   : v3,
            claim_interval          : v2.claim_interval,
            claimable_amount        : v4,
            lapsed_amount           : v5,
            total_elapsed_intervals : (v1 - v2.start) / v2.claim_interval,
            claimed_intervals       : v2.unlocked / v2.tokens_per_interval,
        };
        0x2::event::emit<DebugClaimEvent>(v8);
    }

    public fun claim_interval<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).claim_interval
    }

    public entry fun create_locker<T0>(arg0: &mut LockerStorage, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg3), 0);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 2);
        let v0 = arg2 / arg5 / arg6;
        let v1 = if (v0 == 0) {
            1
        } else {
            v0
        };
        let v2 = Locker<T0>{
            balance             : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg8)),
            start               : arg4,
            unlocked            : 0,
            duration            : arg5,
            last_claim_time     : arg4,
            claim_interval      : arg6,
            tokens_per_interval : v1,
        };
        0x2::dynamic_field::add<address, Locker<T0>>(&mut arg0.id, arg7, v2);
        0x2::vec_set::insert<address>(&mut arg0.users, arg7);
        let v3 = LockEvent{
            user     : arg7,
            amount   : arg2,
            start    : arg4,
            duration : arg5,
        };
        0x2::event::emit<LockEvent>(v3);
    }

    public entry fun diagnose_contract_state<T0>(arg0: &AdminCap, arg1: &LockerStorage, arg2: &LapsedClaimsRegistry) {
        let v0 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = UserCountEvent{count: v1};
        0x2::event::emit<UserCountEvent>(v2);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            let v5 = 0x2::dynamic_field::exists_<address>(&arg1.id, v4);
            let v6 = 0;
            let v7 = 0;
            if (v5) {
                let v8 = 0x2::dynamic_field::borrow<address, Locker<T0>>(&arg1.id, v4);
                v6 = v8.start;
                v7 = v8.duration;
            };
            let v9 = DiagnosticEvent{
                user_address    : v4,
                storage_exists  : v5,
                registry_exists : 0x2::dynamic_field::exists_<address>(&arg2.id, v4),
                start_time      : v6,
                duration        : v7,
            };
            0x2::event::emit<DiagnosticEvent>(v9);
            v3 = v3 + 1;
        };
    }

    public fun duration<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).duration
    }

    public entry fun expanded_check_single_user<T0>(arg0: &AdminCap, arg1: &LockerStorage, arg2: address) {
        let v0 = 0x2::dynamic_field::exists_<address>(&arg1.id, arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        if (v0) {
            let v4 = 0x2::dynamic_field::borrow<address, Locker<T0>>(&arg1.id, arg2);
            v1 = 0x2::balance::value<T0>(&v4.balance);
            v2 = v4.start;
            v3 = v4.duration;
        };
        let v5 = ExpandedUserCheckEvent{
            user_exists   : 0x2::vec_set::contains<address>(&arg1.users, &arg2),
            locker_exists : v0,
            balance       : v1,
            start_time    : v2,
            duration      : v3,
        };
        0x2::event::emit<ExpandedUserCheckEvent>(v5);
    }

    fun handle_lapsed_claims<T0>(arg0: &mut Locker<T0>, arg1: &mut LapsedClaimsRegistry, arg2: address, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = if (arg3 > v0) {
            v0
        } else {
            arg3
        };
        if (v1 > 0) {
            if (0x2::dynamic_field::exists_<address>(&arg1.id, arg2)) {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg1.id, arg2), 0x2::balance::split<T0>(&mut arg0.balance, v1));
            } else {
                0x2::dynamic_field::add<address, 0x2::balance::Balance<T0>>(&mut arg1.id, arg2, 0x2::balance::split<T0>(&mut arg0.balance, v1));
            };
        };
        v1
    }

    public fun has_lapsed_claims(arg0: &LapsedClaimsRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public entry fun initialize(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 5);
        let v0 = LapsedClaimsRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<LapsedClaimsRegistry>(v0);
        let v1 = LockerStorage{
            id    : 0x2::object::new(arg1),
            users : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<LockerStorage>(v1);
    }

    fun is_id_zero(arg0: &0x2::object::UID) : bool {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != 0) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun last_claim_time<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).last_claim_time
    }

    public entry fun minimal_diagnose(arg0: &AdminCap, arg1: &LockerStorage, arg2: &LapsedClaimsRegistry) {
        let v0 = BasicDiagnosticEvent{
            storage_id_exists  : !is_id_zero(&arg1.id),
            registry_id_exists : !is_id_zero(&arg2.id),
            user_count         : 0x2::vec_set::size<address>(&arg1.users),
        };
        0x2::event::emit<BasicDiagnosticEvent>(v0);
    }

    public fun start<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).start
    }

    fun unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut LapsedClaimsRegistry, arg3: address) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start, 1);
        let (v1, v2) = calculate_claimable_and_lapsed<T0>(arg0, v0);
        if (v2 > 0) {
            handle_lapsed_claims<T0>(arg0, arg2, arg3, v2);
        };
        arg0.last_claim_time = v0;
        (v1, v2)
    }

    public fun unlocked<T0>(arg0: &LockerStorage, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, Locker<T0>>(&arg0.id, arg1).unlocked
    }

    public entry fun withdraw_expired_lockers<T0>(arg0: &AdminCap, arg1: &mut LockerStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::into_keys<address>(arg1.users);
        let v1 = 0;
        let v2 = 0;
        while (v1 < arg3 && !0x1::vector::is_empty<address>(&v0)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v0);
            if (0x2::dynamic_field::exists_<address>(&arg1.id, v3)) {
                let v4 = 0x2::dynamic_field::borrow_mut<address, Locker<T0>>(&mut arg1.id, v3);
                if (0x2::clock::timestamp_ms(arg2) >= v4.start + v4.duration) {
                    let v5 = 0x2::balance::value<T0>(&v4.balance);
                    if (v5 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v4.balance), arg4), v3);
                        v2 = v2 + v5;
                    };
                };
            };
            v1 = v1 + 1;
        };
        let v6 = WithdrawExpiredLockersEvent{
            users_processed : v1,
            total_withdrawn : v2,
        };
        0x2::event::emit<WithdrawExpiredLockersEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

