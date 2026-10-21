module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::locked_mint {
    struct LockKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ReserveKey has copy, drop, store {
        account_id: 0x2::object::ID,
    }

    struct Bucket has copy, drop, store {
        unlock_ms: u64,
        amount: u64,
        basis: u64,
        released: u64,
        prov: vector<Part>,
    }

    struct Part has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    struct Ledger<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        buckets: vector<Bucket>,
        free: u64,
    }

    struct ForfeitKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct LockedMintCreditedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_ms: u64,
        total_locked: u64,
    }

    struct MintReservedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        epoch: u64,
        amount: u64,
        total: u64,
    }

    struct LockedMintExitedEarlyEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        paid: u64,
        penalty: u64,
    }

    struct LockedMintReleasedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        caller: address,
        amount: u64,
        remaining: u64,
        next_unlock_ms: u64,
    }

    struct LockedMintScaledEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        burned: u64,
    }

    struct LockedMintVoidedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        unlock_ms: u64,
        amount: u64,
        basis: u64,
        remaining: u64,
        reason: u8,
    }

    fun add_parts(arg0: &mut vector<Part>, arg1: vector<Part>) {
        0x1::vector::reverse<Part>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(&arg1)) {
            let v1 = 0x1::vector::pop_back<Part>(&mut arg1);
            let v2 = 0;
            let v3;
            while (v2 < 0x1::vector::length<Part>(arg0)) {
                if (0x1::vector::borrow<Part>(arg0, v2).epoch == v1.epoch) {
                    v3 = 0x1::option::some<u64>(v2);
                    /* label 7 */
                    if (0x1::option::is_some<u64>(&v3)) {
                        let v4 = 0x1::vector::borrow_mut<Part>(arg0, 0x1::option::destroy_some<u64>(v3));
                        v4.amount = v4.amount + v1.amount;
                    } else {
                        0x1::vector::push_back<Part>(arg0, v1);
                    };
                    v0 = v0 + 1;
                    /* goto 1 */
                    continue
                };
                v2 = v2 + 1;
            };
            v3 = 0x1::option::none<u64>();
            /* goto 7 */
        };
        0x1::vector::destroy_empty<Part>(arg1);
    }

    fun admin_auth<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg1, arg0)
    }

    public fun admin_void<T0, T1>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: address, arg4: u64, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock) {
        let v0 = admin_auth<T0>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0);
        let (v2, v3, v4, v5) = take_locked<T0, T1>(&v0, arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg7));
        let v6 = v4;
        0x1::vector::reverse<Part>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Part>(&v6)) {
            let v8 = 0x1::vector::pop_back<Part>(&mut v6);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::unnote_mint<T0>(&v0, arg0, v8.epoch, v8.amount);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<Part>(v6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::burn_reward<T0, T1>(&v0, arg0, v2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::reverse_minted_loss<T0>(&v0, arg0, v3);
        let v9 = LockedMintVoidedEventV1{
            exchange_id : v1,
            owner       : arg3,
            unlock_ms   : arg4,
            amount      : arg5,
            basis       : v3,
            remaining   : v5,
            reason      : arg6,
        };
        let v10 = Event<LockedMintVoidedEventV1>{pos0: v9};
        0x2::event::emit<Event<LockedMintVoidedEventV1>>(v10);
    }

    public fun bucket_count<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        0x1::vector::length<Bucket>(&ledger<T0, T1>(arg0, arg1).buckets)
    }

    public fun entries<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        if (has_ledger<T0, T1>(arg0, arg1)) {
            let v2 = &ledger<T0, T1>(arg0, arg1).buckets;
            let v3 = 0;
            while (v3 < 0x1::vector::length<Bucket>(v2)) {
                let v4 = 0x1::vector::borrow<Bucket>(v2, v3);
                0x1::vector::push_back<u64>(&mut v0, v4.unlock_ms);
                let (_, v6) = settled_view<T0>(arg0, v4);
                let v7 = v6;
                0x1::vector::push_back<u64>(&mut v1, v7.amount);
                v3 = v3 + 1;
            };
        };
        (v0, v1)
    }

    public fun exit_early<T0, T1>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (!has_ledger<T0, T1>(arg0, v0)) {
            return (0, 0)
        };
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        let v3 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0);
        settle<T0, T1>(&v2, arg0, v0);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v2, arg0);
        let v5 = LockKey<T1>{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v4, v5);
        let v7 = 0x2::table::borrow_mut<address, Ledger<T1>>(v6, v0);
        let v8 = v7.free;
        let v9 = 0;
        v7.free = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<Bucket>(&v7.buckets)) {
            let v11 = 0x1::vector::borrow<Bucket>(&v7.buckets, v10);
            if (v11.unlock_ms <= v1 && 0x1::vector::is_empty<Part>(&v11.prov)) {
                let v12 = penalty(v11, v1);
                v8 = v8 + v11.amount - v11.released - v12;
                v9 = v9 + v12;
                0x1::vector::remove<Bucket>(&mut v7.buckets, v10);
                continue
            };
            v10 = v10 + 1;
        };
        if (0x1::vector::is_empty<Bucket>(&v7.buckets)) {
            let Ledger {
                balance : v13,
                buckets : _,
                free    : _,
            } = 0x2::table::remove<address, Ledger<T1>>(v6, v0);
            0x2::balance::destroy_zero<T1>(v13);
        };
        let v16 = 0x2::balance::split<T1>(&mut v7.balance, v9);
        let v17 = 0x2::balance::split<T1>(&mut v7.balance, v8);
        let v18 = 0x2::balance::value<T1>(&v17);
        let v19 = 0x2::balance::value<T1>(&v16);
        if (v19 > 0) {
            let v20 = ForfeitKey<T1>{dummy_field: false};
            if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v4, v20)) {
                let v21 = ForfeitKey<T1>{dummy_field: false};
                0x2::dynamic_field::add<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v4, v21, 0x2::balance::zero<T1>());
            };
            let v22 = ForfeitKey<T1>{dummy_field: false};
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v4, v22), v16);
        } else {
            0x2::balance::destroy_zero<T1>(v16);
        };
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg2), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v17);
        };
        if (v18 > 0 || v19 > 0) {
            let v23 = LockedMintExitedEarlyEventV1{
                exchange_id : v3,
                owner       : v0,
                paid        : v18,
                penalty     : v19,
            };
            let v24 = Event<LockedMintExitedEarlyEventV1>{pos0: v23};
            0x2::event::emit<Event<LockedMintExitedEarlyEventV1>>(v24);
        };
        (v18, v19)
    }

    fun fold_matured<T0>(arg0: &mut Ledger<T0>, arg1: u64) {
        loop {
            let v0 = if (!0x1::vector::is_empty<Bucket>(&arg0.buckets)) {
                if (0x1::vector::borrow<Bucket>(&arg0.buckets, 0).unlock_ms + 2592000000 <= arg1) {
                    0x1::vector::is_empty<Part>(&0x1::vector::borrow<Bucket>(&arg0.buckets, 0).prov)
                } else {
                    false
                }
            } else {
                false
            };
            if (v0) {
                let v1 = 0x1::vector::remove<Bucket>(&mut arg0.buckets, 0);
                arg0.free = arg0.free + v1.amount - v1.released;
            } else {
                break
            };
        };
    }

    public fun forfeits<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>) : u64 {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = ForfeitKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v0, v1)) {
            return 0
        };
        let v2 = ForfeitKey<T1>{dummy_field: false};
        0x2::balance::value<T1>(0x2::dynamic_field::borrow<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v0, v2))
    }

    fun has_ledger<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : bool {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = LockKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists<LockKey<T1>>(v0, v1)) {
            let v3 = LockKey<T1>{dummy_field: false};
            0x2::table::contains<address, Ledger<T1>>(0x2::dynamic_field::borrow<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v0, v3), arg1)
        } else {
            false
        }
    }

    fun ledger<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : &Ledger<T1> {
        let v0 = LockKey<T1>{dummy_field: false};
        0x2::table::borrow<address, Ledger<T1>>(0x2::dynamic_field::borrow<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), v0), arg1)
    }

    public(friend) fun lock<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        lock_loss<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4, arg5);
    }

    public(friend) fun lock_loss<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 > 0) {
            0x2::coin::value<T1>(&arg3)
        } else {
            0
        };
        let v1 = if (v0 > 0) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::note_mint<T0>(arg0, arg1, arg5, v0);
            let v2 = Part{
                epoch  : arg5 / 86400000,
                amount : v0,
            };
            let v3 = 0x1::vector::empty<Part>();
            0x1::vector::push_back<Part>(&mut v3, v2);
            v3
        } else {
            0x1::vector::empty<Part>()
        };
        lock_parts<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, arg5, arg6);
    }

    public fun lock_ms() : u64 {
        604800000
    }

    fun lock_parts<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<Part>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg3);
            return
        };
        let v1 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1);
        settle<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v3 = LockKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<LockKey<T1>>(v2, v3)) {
            let v4 = LockKey<T1>{dummy_field: false};
            0x2::dynamic_field::add<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v2, v4, 0x2::table::new<address, Ledger<T1>>(arg7));
        };
        let v5 = LockKey<T1>{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v2, v5);
        if (!0x2::table::contains<address, Ledger<T1>>(v6, arg2)) {
            let v7 = Ledger<T1>{
                balance : 0x2::balance::zero<T1>(),
                buckets : 0x1::vector::empty<Bucket>(),
                free    : 0,
            };
            0x2::table::add<address, Ledger<T1>>(v6, arg2, v7);
        };
        let v8 = 0x2::table::borrow_mut<address, Ledger<T1>>(v6, arg2);
        0x2::balance::join<T1>(&mut v8.balance, 0x2::coin::into_balance<T1>(arg3));
        fold_matured<T1>(v8, arg6);
        let v9 = arg6 + 604800000;
        let v10 = 0x1::vector::length<Bucket>(&v8.buckets);
        let v11 = if (v10 > 0) {
            let v12 = 0x1::vector::borrow<Bucket>(&v8.buckets, v10 - 1);
            v12.unlock_ms > arg6 && v12.unlock_ms / 86400000 == v9 / 86400000
        } else {
            false
        };
        let v13 = !v11 && v10 >= 39;
        if (v11 || v13) {
            let v14 = 0x1::vector::borrow_mut<Bucket>(&mut v8.buckets, v10 - 1);
            merge_into(v14, v0, arg4, arg5, v9);
        } else {
            let v15 = Bucket{
                unlock_ms : v9,
                amount    : v0,
                basis     : arg4,
                released  : 0,
                prov      : arg5,
            };
            0x1::vector::push_back<Bucket>(&mut v8.buckets, v15);
        };
        let v16 = LockedMintCreditedEventV1{
            exchange_id  : v1,
            owner        : arg2,
            amount       : v0,
            unlock_ms    : v9,
            total_locked : 0x2::balance::value<T1>(&v8.balance),
        };
        let v17 = Event<LockedMintCreditedEventV1>{pos0: v16};
        0x2::event::emit<Event<LockedMintCreditedEventV1>>(v17);
    }

    public(friend) fun lock_reserved<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<Part>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        lock_parts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun locked_balance<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        0x2::balance::value<T1>(&ledger<T0, T1>(arg0, arg1).balance)
    }

    public fun max_buckets() : u64 {
        39
    }

    fun merge_into(arg0: &mut Bucket, arg1: u64, arg2: u64, arg3: vector<Part>, arg4: u64) {
        if (arg0.released > 0) {
            arg0.basis = (((arg0.basis as u128) * ((arg0.amount - arg0.released) as u128) / (arg0.amount as u128)) as u64);
            arg0.amount = arg0.amount - arg0.released;
            arg0.released = 0;
        };
        arg0.amount = arg0.amount + arg1;
        arg0.basis = sat_add(arg0.basis, arg2);
        let v0 = &mut arg0.prov;
        add_parts(v0, arg3);
        arg0.unlock_ms = 0x1::u64::max(arg0.unlock_ms, arg4);
    }

    fun next_unlock_in(arg0: &vector<Bucket>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Bucket>(arg0)) {
            if (0x1::vector::borrow<Bucket>(arg0, v0).unlock_ms > arg1) {
                return 0x1::vector::borrow<Bucket>(arg0, v0).unlock_ms
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun next_unlock_ms<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        next_unlock_in(&ledger<T0, T1>(arg0, arg1).buckets, arg2)
    }

    public fun parts_total(arg0: &vector<Part>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Part>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<Part>(arg0, v1).amount;
            v1 = v1 + 1;
        };
        v0
    }

    fun penalty(arg0: &Bucket, arg1: u64) : u64 {
        if (arg1 < arg0.unlock_ms) {
            return 0
        };
        let v0 = arg1 - arg0.unlock_ms;
        if (v0 >= 2592000000) {
            return 0
        };
        ((((arg0.amount - vested(arg0, arg1)) as u128) * (5000 as u128) * ((2592000000 - v0) as u128) / 10000 * (2592000000 as u128)) as u64)
    }

    public fun releasable<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        let v0 = ledger<T0, T1>(arg0, arg1);
        let v1 = v0.free;
        let v2 = &v0.buckets;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Bucket>(v2)) {
            let (v4, v5) = settled_view<T0>(arg0, 0x1::vector::borrow<Bucket>(v2, v3));
            let v6 = v5;
            if (v4) {
                v1 = v1 + vested(&v6, arg2) - v6.released;
            };
            v3 = v3 + 1;
        };
        v1
    }

    public fun release_unlocked<T0, T1>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        settle<T0, T1>(&v1, arg0, arg1);
        if (releasable<T0, T1>(arg0, arg1, v0) == 0) {
            let v2 = if (has_ledger<T0, T1>(arg0, arg1)) {
                if (0x1::vector::is_empty<Bucket>(&ledger<T0, T1>(arg0, arg1).buckets)) {
                    0x2::balance::value<T1>(&ledger<T0, T1>(arg0, arg1).balance) == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                let v3 = LockKey<T1>{dummy_field: false};
                let Ledger {
                    balance : v4,
                    buckets : _,
                    free    : _,
                } = 0x2::table::remove<address, Ledger<T1>>(0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v1, arg0), v3), arg1);
                0x2::balance::destroy_zero<T1>(v4);
            };
            return 0
        };
        let v7 = LockKey<T1>{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v1, arg0), v7);
        let v9 = 0x2::table::borrow_mut<address, Ledger<T1>>(v8, arg1);
        let v10 = v9.free;
        v9.free = 0;
        let v11 = &mut v9.buckets;
        let v12 = 0;
        while (v12 < 0x1::vector::length<Bucket>(v11)) {
            let v13 = 0x1::vector::borrow_mut<Bucket>(v11, v12);
            if (0x1::vector::is_empty<Part>(&v13.prov)) {
                let v14 = vested(v13, v0);
                v10 = v10 + v14 - v13.released;
                v13.released = v14;
            };
            v12 = v12 + 1;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<Bucket>(&v9.buckets)) {
            if (0x1::vector::borrow<Bucket>(&v9.buckets, v15).released == 0x1::vector::borrow<Bucket>(&v9.buckets, v15).amount) {
                0x1::vector::remove<Bucket>(&mut v9.buckets, v15);
                continue
            };
            v15 = v15 + 1;
        };
        if (0x1::vector::is_empty<Bucket>(&v9.buckets)) {
            let Ledger {
                balance : v16,
                buckets : _,
                free    : _,
            } = 0x2::table::remove<address, Ledger<T1>>(v8, arg1);
            0x2::balance::destroy_zero<T1>(v16);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9.balance, v10), arg3), arg1);
        let v19 = LockedMintReleasedEventV1{
            exchange_id    : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0),
            owner          : arg1,
            caller         : 0x2::tx_context::sender(arg3),
            amount         : v10,
            remaining      : 0x2::balance::value<T1>(&v9.balance),
            next_unlock_ms : next_unlock_in(&v9.buckets, v0),
        };
        let v20 = Event<LockedMintReleasedEventV1>{pos0: v19};
        0x2::event::emit<Event<LockedMintReleasedEventV1>>(v20);
        v10
    }

    public(friend) fun reserve<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        if (arg3 == 0) {
            return
        };
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::note_mint<T0>(arg0, arg1, arg4, arg3);
        let v0 = arg4 / 86400000;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = ReserveKey{account_id: arg2};
        if (!0x2::dynamic_field::exists<ReserveKey>(v1, v2)) {
            0x2::dynamic_field::add<ReserveKey, vector<Part>>(v1, v2, 0x1::vector::empty<Part>());
        };
        let v3 = 0x2::dynamic_field::borrow_mut<ReserveKey, vector<Part>>(v1, v2);
        let v4 = Part{
            epoch  : v0,
            amount : arg3,
        };
        let v5 = 0x1::vector::empty<Part>();
        0x1::vector::push_back<Part>(&mut v5, v4);
        add_parts(v3, v5);
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<Part>(v3)) {
            v6 = sat_add(v6, 0x1::vector::borrow<Part>(v3, v7).amount);
            v7 = v7 + 1;
        };
        let v8 = MintReservedEventV1{
            exchange_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1),
            account_id  : arg2,
            epoch       : v0,
            amount      : arg3,
            total       : v6,
        };
        let v9 = Event<MintReservedEventV1>{pos0: v8};
        0x2::event::emit<Event<MintReservedEventV1>>(v9);
    }

    public fun reserved<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = ReserveKey{account_id: arg1};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v1)) {
            return 0
        };
        let v2 = 0;
        let v3 = ReserveKey{account_id: arg1};
        let v4 = 0x2::dynamic_field::borrow<ReserveKey, vector<Part>>(v0, v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<Part>(v4)) {
            v2 = sat_add(v2, 0x1::vector::borrow<Part>(v4, v5).amount);
            v5 = v5 + 1;
        };
        v2
    }

    fun sat_add(arg0: u64, arg1: u64) : u64 {
        let v0 = 18446744073709551615;
        if (arg0 > v0 - arg1) {
            v0
        } else {
            arg0 + arg1
        }
    }

    fun settle<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address) {
        if (!has_ledger<T0, T1>(arg1, arg2)) {
            return
        };
        let v0 = vector[];
        let v1 = &ledger<T0, T1>(arg1, arg2).buckets;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Bucket>(v1)) {
            let v3 = 0x1::vector::borrow<Bucket>(v1, v2);
            let (v4, v5) = settled_view<T0>(arg1, v3);
            let v6 = v5;
            let v7 = if (v4 && !0x1::vector::is_empty<Part>(&v3.prov)) {
                v3.amount - v6.amount
            } else {
                18446744073709551615
            };
            0x1::vector::push_back<u64>(&mut v0, v7);
            v2 = v2 + 1;
        };
        let v8 = LockKey<T1>{dummy_field: false};
        let v9 = 0x2::table::borrow_mut<address, Ledger<T1>>(0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1), v8), arg2);
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v0)) {
            if (*0x1::vector::borrow<u64>(&v0, v11) != 18446744073709551615) {
                let v12 = 0x1::vector::borrow_mut<Bucket>(&mut v9.buckets, v11);
                v12.basis = (((v12.basis as u128) * ((v12.amount - *0x1::vector::borrow<u64>(&v0, v11)) as u128) / (v12.amount as u128)) as u64);
                v12.amount = v12.amount - *0x1::vector::borrow<u64>(&v0, v11);
                v12.prov = 0x1::vector::empty<Part>();
                v10 = v10 + *0x1::vector::borrow<u64>(&v0, v11);
            };
            v11 = v11 + 1;
        };
        if (v10 == 0) {
            return
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<Bucket>(&v9.buckets)) {
            if (0x1::vector::borrow<Bucket>(&v9.buckets, v13).amount == 0) {
                0x1::vector::remove<Bucket>(&mut v9.buckets, v13);
                continue
            };
            v13 = v13 + 1;
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::burn_reward<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(&mut v9.balance, v10));
        let v14 = LockedMintScaledEventV1{
            exchange_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1),
            owner       : arg2,
            burned      : v10,
        };
        let v15 = Event<LockedMintScaledEventV1>{pos0: v14};
        0x2::event::emit<Event<LockedMintScaledEventV1>>(v15);
    }

    fun settled_view<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &Bucket) : (bool, Bucket) {
        let v0 = *arg1;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Part>(&arg1.prov)) {
            let v3 = 0x1::vector::borrow<Part>(&arg1.prov, v2);
            let (v4, v5) = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::scale_of<T0>(arg0, v3.epoch);
            if (!v4) {
                return (false, v0)
            };
            v1 = v1 + v3.amount - (((v3.amount as u128) * (v5 as u128) / 1000000) as u64);
            v2 = v2 + 1;
        };
        v0.amount = v0.amount - v1;
        v0.prov = 0x1::vector::empty<Part>();
        (true, v0)
    }

    public fun take_forfeits<T0, T1>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::StakingSink) : 0x2::balance::Balance<T1> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x2::object::id<0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::StakingSink>(arg1);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0);
        let v2 = ForfeitKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v1, v2)) {
            return 0x2::balance::zero<T1>()
        };
        let v3 = ForfeitKey<T1>{dummy_field: false};
        0x2::balance::withdraw_all<T1>(0x2::dynamic_field::borrow_mut<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v1, v3))
    }

    fun take_locked<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T1>, u64, vector<Part>, u64) {
        assert!(has_ledger<T0, T1>(arg1, arg2), 0);
        settle<T0, T1>(arg0, arg1, arg2);
        let v0 = LockKey<T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1), v0);
        let v2 = 0x2::table::borrow_mut<address, Ledger<T1>>(v1, arg2);
        let v3 = &v2.buckets;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<Bucket>(v3)) {
            if (0x1::vector::borrow<Bucket>(v3, v4).unlock_ms == arg3) {
                v5 = 0x1::option::some<u64>(v4);
                /* label 9 */
                assert!(0x1::option::is_some<u64>(&v5), 0);
                let v6 = 0x1::option::destroy_some<u64>(v5);
                assert!(arg3 > arg5, 1);
                let v7 = 0x1::vector::borrow_mut<Bucket>(&mut v2.buckets, v6);
                assert!(arg4 > 0 && arg4 <= v7.amount, 2);
                let v8 = if (arg4 == v7.amount) {
                    v7.basis
                } else {
                    (((v7.basis as u128) * (arg4 as u128) / (v7.amount as u128)) as u64)
                };
                let v9 = v7.amount;
                let v10 = 0;
                let v11 = &v7.prov;
                let v12 = 0;
                while (v12 < 0x1::vector::length<Part>(v11)) {
                    v10 = v10 + 0x1::vector::borrow<Part>(v11, v12).amount;
                    v12 = v12 + 1;
                };
                let v13 = arg4 - ((((v9 - v10) as u128) * (arg4 as u128) / (v9 as u128)) as u64);
                let v14 = &v7.prov;
                let v15 = vector[];
                let v16 = 0;
                while (v16 < 0x1::vector::length<Part>(v14)) {
                    let v17 = (((0x1::vector::borrow<Part>(v14, v16).amount as u128) * (arg4 as u128) / (v9 as u128)) as u64);
                    v13 = v13 - v17;
                    0x1::vector::push_back<u64>(&mut v15, v17);
                    v16 = v16 + 1;
                };
                let v18 = 0x1::vector::empty<Part>();
                let v19 = 0;
                0x1::vector::reverse<u64>(&mut v15);
                let v20 = 0;
                while (v20 < 0x1::vector::length<u64>(&v15)) {
                    let v21 = 0x1::vector::pop_back<u64>(&mut v15);
                    let v22 = 0x1::vector::borrow_mut<Part>(&mut v7.prov, v19);
                    let v23 = v21 + 0x1::u64::min(v13, v22.amount - v21);
                    v13 = v13 - v23 - v21;
                    v22.amount = v22.amount - v23;
                    if (v23 > 0) {
                        let v24 = Part{
                            epoch  : v22.epoch,
                            amount : v23,
                        };
                        0x1::vector::push_back<Part>(&mut v18, v24);
                    };
                    if (v22.amount == 0) {
                        0x1::vector::remove<Part>(&mut v7.prov, v19);
                    } else {
                        v19 = v19 + 1;
                    };
                    v20 = v20 + 1;
                };
                0x1::vector::destroy_empty<u64>(v15);
                v7.basis = v7.basis - v8;
                v7.amount = v7.amount - arg4;
                if (v7.amount == 0) {
                    0x1::vector::remove<Bucket>(&mut v2.buckets, v6);
                };
                if (0x1::vector::is_empty<Bucket>(&v2.buckets) && v2.free == 0) {
                    let Ledger {
                        balance : v25,
                        buckets : _,
                        free    : _,
                    } = 0x2::table::remove<address, Ledger<T1>>(v1, arg2);
                    0x2::balance::destroy_zero<T1>(v25);
                };
                return (0x2::balance::split<T1>(&mut v2.balance, arg4), v8, v18, 0x2::balance::value<T1>(&v2.balance))
            };
            v4 = v4 + 1;
        };
        v5 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public(friend) fun take_reserve<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) : vector<Part> {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = ReserveKey{account_id: arg2};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v1)) {
            return 0x1::vector::empty<Part>()
        };
        let v2 = 0x2::dynamic_field::remove<ReserveKey, vector<Part>>(v0, v1);
        let v3 = 0;
        let v4 = &v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Part>(v4)) {
            v3 = v3 + (0x1::vector::borrow<Part>(v4, v5).amount as u128);
            v5 = v5 + 1;
        };
        if (v3 <= (arg3 as u128)) {
            return v2
        };
        let v6 = 0x1::vector::empty<Part>();
        0x1::vector::reverse<Part>(&mut v2);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Part>(&v2)) {
            let v8 = 0x1::vector::pop_back<Part>(&mut v2);
            let v9 = (((v8.amount as u128) * (arg3 as u128) / v3) as u64);
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::unnote_mint<T0>(arg0, arg1, v8.epoch, v8.amount - v9);
            if (v9 > 0) {
                let v10 = Part{
                    epoch  : v8.epoch,
                    amount : v9,
                };
                0x1::vector::push_back<Part>(&mut v6, v10);
            };
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<Part>(v2);
        v6
    }

    public fun vest_ms() : u64 {
        2592000000
    }

    public fun vest_status<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64) {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v0 = ledger<T0, T1>(arg0, arg1);
        let v1 = 0;
        let v2 = v0.free;
        let v3 = 0;
        let v4 = 0;
        let v5 = &v0.buckets;
        let v6 = 0;
        while (v6 < 0x1::vector::length<Bucket>(v5)) {
            let (v7, v8) = settled_view<T0>(arg0, 0x1::vector::borrow<Bucket>(v5, v6));
            let v9 = v8;
            if (v9.unlock_ms > arg2 || !v7) {
                v4 = v4 + v9.amount;
            } else {
                let v10 = vested(&v9, arg2);
                v2 = v2 + v10 - v9.released;
                v3 = v3 + v9.amount - v10;
                v1 = v1 + penalty(&v9, arg2);
            };
            v6 = v6 + 1;
        };
        (v4, v3, v2, v2 + v3 - v1, v1)
    }

    fun vested(arg0: &Bucket, arg1: u64) : u64 {
        if (arg1 <= arg0.unlock_ms) {
            return 0
        };
        let v0 = arg1 - arg0.unlock_ms;
        if (v0 >= 2592000000) {
            return arg0.amount
        };
        (((arg0.amount as u128) * (v0 as u128) / (2592000000 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

