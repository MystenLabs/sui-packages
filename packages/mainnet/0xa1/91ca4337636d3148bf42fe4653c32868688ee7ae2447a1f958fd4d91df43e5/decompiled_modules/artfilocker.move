module 0xa191ca4337636d3148bf42fe4653c32868688ee7ae2447a1f958fd4d91df43e5::artfilocker {
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
    }

    struct LapsedClaimsRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        lapsed_claims: 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>,
    }

    struct LockerStorage<phantom T0> has key {
        id: 0x2::object::UID,
        lockers: 0x2::table::Table<address, Locker<T0>>,
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

    public fun balance<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::balance::value<T0>(&0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).balance)
    }

    public entry fun admin_update_lapsed_claims<T0>(arg0: &AdminCap, arg1: &mut LockerStorage<T0>, arg2: &mut LapsedClaimsRegistry<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::keys<address>(&arg1.users);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            let v2 = *0x1::vector::borrow<address>(v0, v1);
            if (0x2::table::contains<address, Locker<T0>>(&arg1.lockers, v2)) {
                let v3 = 0x2::table::borrow_mut<address, Locker<T0>>(&mut arg1.lockers, v2);
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

    public entry fun admin_withdraw_lapsed<T0>(arg0: &AdminCap, arg1: &mut LockerStorage<T0>, arg2: &mut LapsedClaimsRegistry<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x2::vec_map::is_empty<address, 0x2::balance::Balance<T0>>(&arg2.lapsed_claims)) {
            let (_, v2) = 0x2::vec_map::pop<address, 0x2::balance::Balance<T0>>(&mut arg2.lapsed_claims);
            0x2::balance::join<T0>(&mut v0, v2);
        };
        let v3 = 0x2::vec_set::keys<address>(&arg1.users);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v3)) {
            let v5 = *0x1::vector::borrow<address>(v3, v4);
            if (0x2::table::contains<address, Locker<T0>>(&arg1.lockers, v5)) {
                let v6 = 0x2::table::borrow_mut<address, Locker<T0>>(&mut arg1.lockers, v5);
                if (0x2::clock::timestamp_ms(arg3) >= v6.start + v6.duration) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut v6.balance));
                };
            };
            v4 = v4 + 1;
        };
        let v7 = 0x2::balance::value<T0>(&v0);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
            let v8 = AdminWithdrawEvent{amount: v7};
            0x2::event::emit<AdminWithdrawEvent>(v8);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    fun calculate_claimable_and_lapsed<T0>(arg0: &Locker<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.duration / arg0.claim_interval;
        let v2 = (v0 - arg0.start) / arg0.claim_interval;
        let v3 = arg0.unlocked / arg0.tokens_per_interval;
        let v4 = if (v2 > v1) {
            v1
        } else {
            v2
        };
        let v5 = (v0 - arg0.last_claim_time) / arg0.claim_interval;
        let v6 = if (v5 > 0 && v3 < v1) {
            arg0.tokens_per_interval
        } else {
            0
        };
        let v7 = v6;
        let v8 = if (v4 > v3 + 1) {
            v4 - v3 - 1
        } else {
            0
        };
        let v9 = if (v8 > v5) {
            v5
        } else {
            v8
        };
        let v10 = v9 * arg0.tokens_per_interval;
        let v11 = v10;
        let v12 = 0x2::balance::value<T0>(&arg0.balance);
        if (v6 + v10 > v12) {
            if (v6 > v12) {
                v7 = v12;
                v11 = 0;
            } else {
                v11 = v12 - v6;
            };
        };
        (v7, v11)
    }

    public entry fun claim<T0>(arg0: &mut LockerStorage<T0>, arg1: &mut LapsedClaimsRegistry<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<address, Locker<T0>>(&mut arg0.lockers, v0);
        assert!(v1 < v2.start + v2.duration, 3);
        let (v3, v4) = calculate_claimable_and_lapsed<T0>(v2, arg2);
        assert!(v3 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, v3), arg3), v0);
        v2.unlocked = v2.unlocked + v3;
        let v5 = ClaimEvent{
            user   : v0,
            amount : v3,
        };
        0x2::event::emit<ClaimEvent>(v5);
        v2.last_claim_time = v2.start + ((v1 - v2.start) / v2.claim_interval + 1) * v2.claim_interval;
        if (v4 > 0) {
            handle_lapsed_claims<T0>(v2, arg1, v0, v4);
            let v6 = LapsedClaimEvent{
                user   : v0,
                amount : v4,
            };
            0x2::event::emit<LapsedClaimEvent>(v6);
        };
    }

    public fun claim_interval<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).claim_interval
    }

    public entry fun create_locker<T0>(arg0: &mut LockerStorage<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
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
        0x2::table::add<address, Locker<T0>>(&mut arg0.lockers, arg7, v2);
        0x2::vec_set::insert<address>(&mut arg0.users, arg7);
        let v3 = LockEvent{
            user     : arg7,
            amount   : arg2,
            start    : arg4,
            duration : arg5,
        };
        0x2::event::emit<LockEvent>(v3);
    }

    public fun duration<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).duration
    }

    fun handle_lapsed_claims<T0>(arg0: &mut Locker<T0>, arg1: &mut LapsedClaimsRegistry<T0>, arg2: address, arg3: u64) : u64 {
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
            if (0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(&arg1.lapsed_claims, &arg2)) {
                0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(&mut arg1.lapsed_claims, &arg2), 0x2::balance::split<T0>(&mut arg0.balance, v1));
            } else {
                0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(&mut arg1.lapsed_claims, arg2, 0x2::balance::split<T0>(&mut arg0.balance, v1));
            };
        };
        v1
    }

    public fun has_lapsed_claims<T0>(arg0: &LapsedClaimsRegistry<T0>) : bool {
        !0x2::vec_map::is_empty<address, 0x2::balance::Balance<T0>>(&arg0.lapsed_claims)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LapsedClaimsRegistry<T0>{
            id            : 0x2::object::new(arg0),
            lapsed_claims : 0x2::vec_map::empty<address, 0x2::balance::Balance<T0>>(),
        };
        0x2::transfer::share_object<LapsedClaimsRegistry<T0>>(v0);
        let v1 = LockerStorage<T0>{
            id      : 0x2::object::new(arg0),
            lockers : 0x2::table::new<address, Locker<T0>>(arg0),
            users   : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<LockerStorage<T0>>(v1);
    }

    public fun last_claim_time<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).last_claim_time
    }

    public fun start<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).start
    }

    fun unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut LapsedClaimsRegistry<T0>, arg3: address) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start, 1);
        let (v1, v2) = calculate_claimable_and_lapsed<T0>(arg0, arg1);
        if (v2 > 0) {
            handle_lapsed_claims<T0>(arg0, arg2, arg3, v2);
        };
        arg0.last_claim_time = v0;
        (v1, v2)
    }

    public fun unlocked<T0>(arg0: &LockerStorage<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, Locker<T0>>(&arg0.lockers, arg1).unlocked
    }

    // decompiled from Move bytecode v6
}

