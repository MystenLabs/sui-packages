module 0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint {
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

    struct EpochBasis has copy, drop, store {
        epoch: u64,
        basis: u64,
    }

    struct ReserveLossKey has copy, drop, store {
        account_id: 0x2::object::ID,
    }

    struct BucketLossKey<phantom T0> has copy, drop, store {
        owner: address,
        unlock_ms: u64,
    }

    struct BucketKeptKey<phantom T0> has copy, drop, store {
        owner: address,
        unlock_ms: u64,
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
        parts: vector<Part>,
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

    fun add_bucket_kept<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketKeptKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (0x2::dynamic_field::exists<BucketKeptKey<T1>>(v0, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<BucketKeptKey<T1>, u64>(v0, v1);
            *v2 = sat_add(*v2, arg4);
        } else {
            0x2::dynamic_field::add<BucketKeptKey<T1>, u64>(v0, v1, arg4);
        };
    }

    fun add_epoch_basis(arg0: &mut vector<EpochBasis>, arg1: u64, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<EpochBasis>(arg0)) {
            if (0x1::vector::borrow<EpochBasis>(arg0, v0).epoch == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 7 */
                if (0x1::option::is_some<u64>(&v1)) {
                    let v2 = 0x1::vector::borrow_mut<EpochBasis>(arg0, 0x1::option::destroy_some<u64>(v1));
                    v2.basis = sat_add(v2.basis, arg2);
                } else {
                    let v3 = EpochBasis{
                        epoch : arg1,
                        basis : arg2,
                    };
                    0x1::vector::push_back<EpochBasis>(arg0, v3);
                };
                return
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 7 */
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

    public fun admin_void<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: address, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        let v0 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1);
        let (v1, v2, v3, v4, v5, v6) = take_locked<T0, T1>(arg0, arg1, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg8));
        let v7 = v5;
        unnote_voided_loss<T0>(arg0, arg1, &v7);
        let v8 = v3;
        0x1::vector::reverse<Part>(&mut v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<Part>(&v8)) {
            let v10 = 0x1::vector::pop_back<Part>(&mut v8);
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unnote_mint<T0>(arg0, arg1, v10.epoch, v10.amount);
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<Part>(v8);
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unwind_debt<T0>(arg0, arg1, v6);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::burn_reward<T0, T1>(arg0, arg1, v1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::reverse_minted_loss<T0>(arg0, arg1, v2);
        let v11 = LockedMintVoidedEventV1{
            exchange_id : v0,
            owner       : arg4,
            unlock_ms   : arg5,
            amount      : arg6,
            basis       : v2,
            remaining   : v4,
            reason      : arg7,
        };
        let v12 = Event<LockedMintVoidedEventV1>{pos0: v11};
        0x2::event::emit<Event<LockedMintVoidedEventV1>>(v12);
    }

    fun attach_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: vector<EpochBasis>) {
        let v0 = if (arg3) {
            load_bucket_loss<T0, T1>(arg0, arg1, arg2, arg4)
        } else {
            0x1::vector::empty<EpochBasis>()
        };
        let v1 = v0;
        if (arg3 && arg4 != arg5) {
            let v2 = &mut v1;
            let v3 = load_bucket_loss<T0, T1>(arg0, arg1, arg2, arg5);
            merge_epoch_basis(v2, v3);
        };
        if (0x1::vector::is_empty<EpochBasis>(&v1)) {
            v1 = arg6;
        } else {
            let v4 = &mut v1;
            merge_epoch_basis(v4, arg6);
        };
        store_bucket_loss<T0, T1>(arg0, arg1, arg2, arg5, v1);
    }

    public fun bucket_count<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        0x1::vector::length<Bucket>(&ledger<T0, T1>(arg0, arg1).buckets)
    }

    fun drop_final_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) {
        let v0 = 0x1::vector::empty<EpochBasis>();
        let v1 = load_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3);
        0x1::vector::reverse<EpochBasis>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<EpochBasis>(&v1)) {
            let v3 = 0x1::vector::pop_back<EpochBasis>(&mut v1);
            let (v4, _) = 0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::scale_of<T0>(arg1, v3.epoch);
            if (!v4) {
                0x1::vector::push_back<EpochBasis>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<EpochBasis>(v1);
        if (0x1::vector::is_empty<EpochBasis>(&v0) || !has_unlock<T0, T1>(arg1, arg2, arg3)) {
            return
        };
        store_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3, v0);
    }

    fun drop_zero_basis(arg0: &mut vector<EpochBasis>) {
        let v0 = 0x1::vector::empty<EpochBasis>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<EpochBasis>(arg0)) {
            let v2 = 0x1::vector::borrow<EpochBasis>(arg0, v1);
            if (v2.basis > 0) {
                0x1::vector::push_back<EpochBasis>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        *arg0 = v0;
    }

    public fun entries<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : (vector<u64>, vector<u64>) {
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

    public fun exit_early<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        exit_entries<T0, T1>(arg0, arg1, arg2, 0x1::option::none<vector<u64>>(), 18446744073709551615, arg3)
    }

    public fun exit_early_bounded<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x2::clock::Clock, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        exit_entries<T0, T1>(arg0, arg1, arg2, 0x1::option::some<vector<u64>>(arg3), arg4, arg5)
    }

    fun exit_entries<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<vector<u64>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!has_ledger<T0, T1>(arg1, v0)) {
            return (0, 0)
        };
        let v2 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1);
        settle<T0, T1>(arg0, arg1, v0, v1);
        let v3 = vector[];
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v5 = LockKey<T1>{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v4, v5);
        let v7 = 0x2::table::borrow_mut<address, Ledger<T1>>(v6, v0);
        let v8 = v7.free;
        let v9 = 0;
        v7.free = 0;
        let v10 = 0;
        let v11 = true;
        while (v10 < 0x1::vector::length<Bucket>(&v7.buckets)) {
            let v12 = 0x1::vector::borrow<Bucket>(&v7.buckets, v10);
            let v13 = v12.unlock_ms <= v1 && 0x1::vector::is_empty<Part>(&v12.prov);
            let v14 = if (v13) {
                if (0x1::option::is_some<vector<u64>>(&arg3)) {
                    !0x1::vector::contains<u64>(0x1::option::borrow<vector<u64>>(&arg3), &v12.unlock_ms)
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                v11 = false;
            };
            if (v13 && v11) {
                let v15 = penalty(v12, v1);
                v8 = v8 + v12.amount - v12.released - v15;
                v9 = v9 + v15;
                let v16 = 0x1::vector::remove<Bucket>(&mut v7.buckets, v10);
                0x1::vector::push_back<u64>(&mut v3, v16.unlock_ms);
                continue
            };
            v10 = v10 + 1;
        };
        assert!(v9 <= arg4, 5);
        if (0x1::vector::is_empty<Bucket>(&v7.buckets)) {
            let Ledger {
                balance : v17,
                buckets : _,
                free    : _,
            } = 0x2::table::remove<address, Ledger<T1>>(v6, v0);
            0x2::balance::destroy_zero<T1>(v17);
        };
        let v20 = 0x2::balance::split<T1>(&mut v7.balance, v9);
        let v21 = 0x2::balance::split<T1>(&mut v7.balance, v8);
        let v22 = 0x2::balance::value<T1>(&v21);
        let v23 = 0x2::balance::value<T1>(&v20);
        if (v23 > 0) {
            let v24 = ForfeitKey<T1>{dummy_field: false};
            if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v4, v24)) {
                let v25 = ForfeitKey<T1>{dummy_field: false};
                0x2::dynamic_field::add<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v4, v25, 0x2::balance::zero<T1>());
            };
            let v26 = ForfeitKey<T1>{dummy_field: false};
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v4, v26), v20);
        } else {
            0x2::balance::destroy_zero<T1>(v20);
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v21, arg5), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v21);
        };
        0x1::vector::reverse<u64>(&mut v3);
        let v27 = 0;
        while (v27 < 0x1::vector::length<u64>(&v3)) {
            forget_bucket<T0, T1>(arg0, arg1, v0, 0x1::vector::pop_back<u64>(&mut v3));
            v27 = v27 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        if (v22 > 0 || v23 > 0) {
            let v28 = LockedMintExitedEarlyEventV1{
                exchange_id : v2,
                owner       : v0,
                paid        : v22,
                penalty     : v23,
            };
            let v29 = Event<LockedMintExitedEarlyEventV1>{pos0: v28};
            0x2::event::emit<Event<LockedMintExitedEarlyEventV1>>(v29);
        };
        (v22, v23)
    }

    fun fold_matured<T0>(arg0: &mut Ledger<T0>, arg1: u64) : vector<u64> {
        let v0 = vector[];
        loop {
            let v1 = if (!0x1::vector::is_empty<Bucket>(&arg0.buckets)) {
                if (0x1::vector::borrow<Bucket>(&arg0.buckets, 0).unlock_ms + 2592000000 <= arg1) {
                    0x1::vector::is_empty<Part>(&0x1::vector::borrow<Bucket>(&arg0.buckets, 0).prov)
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                let v2 = 0x1::vector::remove<Bucket>(&mut arg0.buckets, 0);
                arg0.free = arg0.free + v2.amount - v2.released;
                0x1::vector::push_back<u64>(&mut v0, v2.unlock_ms);
            } else {
                break
            };
        };
        v0
    }

    public fun forfeits<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : u64 {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
        let v1 = ForfeitKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v0, v1)) {
            return 0
        };
        let v2 = ForfeitKey<T1>{dummy_field: false};
        0x2::balance::value<T1>(0x2::dynamic_field::borrow<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v0, v2))
    }

    fun forget_bucket<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketLossKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v1)) {
            0x2::dynamic_field::remove<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1);
        };
        take_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun has_ledger<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : bool {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
        let v1 = LockKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists<LockKey<T1>>(v0, v1)) {
            let v3 = LockKey<T1>{dummy_field: false};
            0x2::table::contains<address, Ledger<T1>>(0x2::dynamic_field::borrow<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v0, v3), arg1)
        } else {
            false
        }
    }

    fun has_unlock<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : bool {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return false
        };
        let v0 = &ledger<T0, T1>(arg0, arg1).buckets;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Bucket>(v0)) {
            if (0x1::vector::borrow<Bucket>(v0, v1).unlock_ms == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 9 */
                return 0x1::option::is_some<u64>(&v2)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    fun ledger<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : &Ledger<T1> {
        let v0 = LockKey<T1>{dummy_field: false};
        0x2::table::borrow<address, Ledger<T1>>(0x2::dynamic_field::borrow<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), v0), arg1)
    }

    fun load_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) : vector<EpochBasis> {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketLossKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (!0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v1)) {
            return 0x1::vector::empty<EpochBasis>()
        };
        0x2::dynamic_field::remove<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1)
    }

    public fun lock<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        lock_loss<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4, arg5);
    }

    public fun lock_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 > 0) {
            0x2::coin::value<T1>(&arg3)
        } else {
            0
        };
        let v1 = 0x1::vector::empty<EpochBasis>();
        let v2 = if (v0 > 0) {
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_mint<T0>(arg0, arg1, arg5, v0);
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_loss<T0>(arg0, arg1, arg5, arg4);
            let v3 = &mut v1;
            add_epoch_basis(v3, arg5 / 86400000, arg4);
            let v4 = Part{
                epoch  : arg5 / 86400000,
                amount : v0,
            };
            let v5 = 0x1::vector::empty<Part>();
            0x1::vector::push_back<Part>(&mut v5, v4);
            v5
        } else {
            0x1::vector::empty<Part>()
        };
        lock_parts<T0, T1>(arg0, arg1, arg2, arg3, arg4, v2, v1, arg5, arg6);
    }

    public fun lock_ms() : u64 {
        604800000
    }

    fun lock_parts<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<Part>, arg6: vector<EpochBasis>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg3);
            return
        };
        let v1 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1);
        settle<T0, T1>(arg0, arg1, arg2, arg7);
        let v2 = arg7 + 604800000;
        let v3 = false;
        let v4 = 0;
        let v5 = v2;
        let v6 = false;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v10 = LockKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<LockKey<T1>>(v9, v10)) {
            let v11 = LockKey<T1>{dummy_field: false};
            0x2::dynamic_field::add<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v9, v11, 0x2::table::new<address, Ledger<T1>>(arg8));
        };
        let v12 = LockKey<T1>{dummy_field: false};
        let v13 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(v9, v12);
        if (!0x2::table::contains<address, Ledger<T1>>(v13, arg2)) {
            let v14 = Ledger<T1>{
                balance : 0x2::balance::zero<T1>(),
                buckets : 0x1::vector::empty<Bucket>(),
                free    : 0,
            };
            0x2::table::add<address, Ledger<T1>>(v13, arg2, v14);
        };
        let v15 = 0x2::table::borrow_mut<address, Ledger<T1>>(v13, arg2);
        0x2::balance::join<T1>(&mut v15.balance, 0x2::coin::into_balance<T1>(arg3));
        let v16 = fold_matured<T1>(v15, arg7);
        let v17 = 0x1::vector::length<Bucket>(&v15.buckets);
        let v18 = if (v17 > 0) {
            let v19 = 0x1::vector::borrow<Bucket>(&v15.buckets, v17 - 1);
            v19.unlock_ms > arg7 && v19.unlock_ms / 86400000 == v2 / 86400000
        } else {
            false
        };
        let v20 = !v18 && v17 >= 39;
        if (v18 || v20) {
            v3 = true;
            let v21 = 0x1::vector::borrow<Bucket>(&v15.buckets, v17 - 1);
            v4 = v21.unlock_ms;
            if (v21.released > 0 && v21.amount > 0) {
                v6 = true;
                v7 = v21.amount - v21.released;
                v8 = v21.amount;
            };
            let v22 = 0x1::vector::borrow_mut<Bucket>(&mut v15.buckets, v17 - 1);
            merge_into(v22, v0, arg4, arg5, v2);
            v5 = 0x1::vector::borrow<Bucket>(&v15.buckets, v17 - 1).unlock_ms;
        } else {
            let v23 = Bucket{
                unlock_ms : v2,
                amount    : v0,
                basis     : arg4,
                released  : 0,
                prov      : arg5,
            };
            0x1::vector::push_back<Bucket>(&mut v15.buckets, v23);
        };
        0x1::vector::reverse<u64>(&mut v16);
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v16)) {
            forget_bucket<T0, T1>(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut v16));
            v24 = v24 + 1;
        };
        0x1::vector::destroy_empty<u64>(v16);
        if (v6) {
            scale_bucket_loss<T0, T1>(arg0, arg1, arg2, v4, v7, v8);
            scale_bucket_kept<T0, T1>(arg0, arg1, arg2, v4, v7, v8);
        };
        if (v3 && v4 != v5) {
            rekey_bucket_kept<T0, T1>(arg0, arg1, arg2, v4, v5);
        };
        if (!0x1::vector::is_empty<EpochBasis>(&arg6)) {
            attach_bucket_loss<T0, T1>(arg0, arg1, arg2, v3, v4, v5, arg6);
        } else if (v3 && v4 != v5) {
            rekey_bucket_loss<T0, T1>(arg0, arg1, arg2, v4, v5);
        };
        let v25 = LockedMintCreditedEventV1{
            exchange_id  : v1,
            owner        : arg2,
            amount       : v0,
            unlock_ms    : v2,
            total_locked : 0x2::balance::value<T1>(&v15.balance),
            parts        : arg5,
        };
        let v26 = Event<LockedMintCreditedEventV1>{pos0: v25};
        0x2::event::emit<Event<LockedMintCreditedEventV1>>(v26);
    }

    public fun lock_reserved<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<Part>, arg6: vector<EpochBasis>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        lock_parts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun locked_balance<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        0x2::balance::value<T1>(&ledger<T0, T1>(arg0, arg1).balance)
    }

    public fun max_buckets() : u64 {
        39
    }

    fun merge_epoch_basis(arg0: &mut vector<EpochBasis>, arg1: vector<EpochBasis>) {
        0x1::vector::reverse<EpochBasis>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<EpochBasis>(&arg1)) {
            let v1 = 0x1::vector::pop_back<EpochBasis>(&mut arg1);
            add_epoch_basis(arg0, v1.epoch, v1.basis);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<EpochBasis>(arg1);
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

    public fun next_unlock_ms<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        if (!has_ledger<T0, T1>(arg0, arg1)) {
            return 0
        };
        next_unlock_in(&ledger<T0, T1>(arg0, arg1).buckets, arg2)
    }

    fun note_reserve_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = ReserveLossKey{account_id: arg2};
        if (!0x2::dynamic_field::exists<ReserveLossKey>(v0, v1)) {
            0x2::dynamic_field::add<ReserveLossKey, vector<EpochBasis>>(v0, v1, 0x1::vector::empty<EpochBasis>());
        };
        let v2 = 0x2::dynamic_field::borrow_mut<ReserveLossKey, vector<EpochBasis>>(v0, v1);
        let v3 = 0x1::vector::length<EpochBasis>(v2);
        if (v3 > 0 && 0x1::vector::borrow<EpochBasis>(v2, v3 - 1).epoch == arg3) {
            0x1::vector::borrow_mut<EpochBasis>(v2, v3 - 1).basis = sat_add(0x1::vector::borrow<EpochBasis>(v2, v3 - 1).basis, arg4);
        } else {
            let v4 = EpochBasis{
                epoch : arg3,
                basis : arg4,
            };
            0x1::vector::push_back<EpochBasis>(v2, v4);
        };
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

    fun rekey_bucket_kept<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64) {
        let v0 = take_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3);
        if (v0 > 0) {
            add_bucket_kept<T0, T1>(arg0, arg1, arg2, arg4, v0);
        };
    }

    fun rekey_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketLossKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (!0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v1)) {
            return
        };
        let v2 = BucketLossKey<T1>{
            owner     : arg2,
            unlock_ms : arg4,
        };
        if (0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v2)) {
            let v3 = 0x2::dynamic_field::borrow_mut<BucketLossKey<T1>, vector<EpochBasis>>(v0, v2);
            merge_epoch_basis(v3, 0x2::dynamic_field::remove<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1));
        } else {
            0x2::dynamic_field::add<BucketLossKey<T1>, vector<EpochBasis>>(v0, v2, 0x2::dynamic_field::remove<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1));
        };
    }

    public fun releasable<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
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

    public fun release_unlocked<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        settle<T0, T1>(arg0, arg1, arg2, v0);
        if (releasable<T0, T1>(arg1, arg2, v0) == 0) {
            let v1 = if (has_ledger<T0, T1>(arg1, arg2)) {
                if (0x1::vector::is_empty<Bucket>(&ledger<T0, T1>(arg1, arg2).buckets)) {
                    0x2::balance::value<T1>(&ledger<T0, T1>(arg1, arg2).balance) == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                let v2 = LockKey<T1>{dummy_field: false};
                let Ledger {
                    balance : v3,
                    buckets : _,
                    free    : _,
                } = 0x2::table::remove<address, Ledger<T1>>(0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v2), arg2);
                0x2::balance::destroy_zero<T1>(v3);
            };
            return 0
        };
        let v6 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1);
        let v7 = LockKey<T1>{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v7);
        let v9 = 0x2::table::borrow_mut<address, Ledger<T1>>(v8, arg2);
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
        let v15 = vector[];
        let v16 = 0;
        while (v16 < 0x1::vector::length<Bucket>(&v9.buckets)) {
            if (0x1::vector::borrow<Bucket>(&v9.buckets, v16).released == 0x1::vector::borrow<Bucket>(&v9.buckets, v16).amount) {
                let v17 = 0x1::vector::remove<Bucket>(&mut v9.buckets, v16);
                0x1::vector::push_back<u64>(&mut v15, v17.unlock_ms);
                continue
            };
            v16 = v16 + 1;
        };
        if (0x1::vector::is_empty<Bucket>(&v9.buckets)) {
            let Ledger {
                balance : v18,
                buckets : _,
                free    : _,
            } = 0x2::table::remove<address, Ledger<T1>>(v8, arg2);
            0x2::balance::destroy_zero<T1>(v18);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9.balance, v10), arg4), arg2);
        0x1::vector::reverse<u64>(&mut v15);
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(&v15)) {
            forget_bucket<T0, T1>(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut v15));
            v21 = v21 + 1;
        };
        0x1::vector::destroy_empty<u64>(v15);
        let v22 = LockedMintReleasedEventV1{
            exchange_id    : v6,
            owner          : arg2,
            caller         : 0x2::tx_context::sender(arg4),
            amount         : v10,
            remaining      : 0x2::balance::value<T1>(&v9.balance),
            next_unlock_ms : next_unlock_in(&v9.buckets, v0),
        };
        let v23 = Event<LockedMintReleasedEventV1>{pos0: v22};
        0x2::event::emit<Event<LockedMintReleasedEventV1>>(v23);
        v10
    }

    public fun reserve<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        if (arg4 > 0) {
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_loss<T0>(arg0, arg1, arg5, arg4);
            note_reserve_loss<T0>(arg0, arg1, arg2, arg5 / 86400000, arg4);
        };
        if (arg3 == 0) {
            return
        };
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_mint<T0>(arg0, arg1, arg5, arg3);
        let v0 = arg5 / 86400000;
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = ReserveKey{account_id: arg2};
        if (!0x2::dynamic_field::exists<ReserveKey>(v1, v2)) {
            0x2::dynamic_field::add<ReserveKey, vector<Part>>(v1, v2, 0x1::vector::empty<Part>());
        };
        let v3 = 0x2::dynamic_field::borrow_mut<ReserveKey, vector<Part>>(v1, v2);
        let v4 = 0x1::vector::length<Part>(v3);
        if (v4 > 0 && 0x1::vector::borrow<Part>(v3, v4 - 1).epoch == v0) {
            0x1::vector::borrow_mut<Part>(v3, v4 - 1).amount = 0x1::vector::borrow<Part>(v3, v4 - 1).amount + arg3;
        } else {
            let v5 = Part{
                epoch  : v0,
                amount : arg3,
            };
            0x1::vector::push_back<Part>(v3, v5);
        };
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<Part>(v3)) {
            v6 = sat_add(v6, 0x1::vector::borrow<Part>(v3, v7).amount);
            v7 = v7 + 1;
        };
        let v8 = MintReservedEventV1{
            exchange_id : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1),
            account_id  : arg2,
            epoch       : v0,
            amount      : arg3,
            total       : v6,
        };
        let v9 = Event<MintReservedEventV1>{pos0: v8};
        0x2::event::emit<Event<MintReservedEventV1>>(v9);
    }

    public fun reserved<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
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

    fun scale_bucket_kept<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        if (arg5 == 0 || arg4 == arg5) {
            return
        };
        let v0 = take_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = (((v0 as u128) * (arg4 as u128) / (arg5 as u128)) as u64);
        if (v1 > 0) {
            add_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3, v1);
        };
    }

    fun scale_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        if (arg5 == 0 || arg4 == arg5) {
            return
        };
        let v0 = load_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<EpochBasis>(&v0)) {
            0x1::vector::borrow_mut<EpochBasis>(&mut v0, v1).basis = (((0x1::vector::borrow<EpochBasis>(&v0, v1).basis as u128) * (arg4 as u128) / (arg5 as u128)) as u64);
            v1 = v1 + 1;
        };
        let v2 = &mut v0;
        drop_zero_basis(v2);
        store_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3, v0);
    }

    fun settle<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) {
        if (!has_ledger<T0, T1>(arg1, arg2)) {
            return
        };
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = &ledger<T0, T1>(arg1, arg2).buckets;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Bucket>(v4)) {
            let v6 = 0x1::vector::borrow<Bucket>(v4, v5);
            let (v7, v8) = settled_view<T0>(arg1, v6);
            let v9 = v8;
            if (v7 && !0x1::vector::is_empty<Part>(&v6.prov)) {
                let v10 = parts_total(&v6.prov);
                0x1::vector::push_back<u64>(&mut v0, v6.amount - v9.amount);
                0x1::vector::push_back<u64>(&mut v1, settled_basis<T0, T1>(arg1, arg2, v6, v6.amount - v9.amount));
                if (v6.unlock_ms > arg3 && v10 > v6.amount - v9.amount) {
                    0x1::vector::push_back<u64>(&mut v2, v6.unlock_ms);
                    0x1::vector::push_back<u64>(&mut v3, v10 - v6.amount - v9.amount);
                };
            } else {
                0x1::vector::push_back<u64>(&mut v0, 18446744073709551615);
                0x1::vector::push_back<u64>(&mut v1, 0);
            };
            v5 = v5 + 1;
        };
        0x1::vector::reverse<u64>(&mut v3);
        assert!(0x1::vector::length<u64>(&v2) == 0x1::vector::length<u64>(&v3), 13906837408453754879);
        0x1::vector::reverse<u64>(&mut v2);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v2)) {
            add_bucket_kept<T0, T1>(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v3));
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        0x1::vector::destroy_empty<u64>(v3);
        let v12 = vector[];
        let v13 = LockKey<T1>{dummy_field: false};
        let v14 = 0x2::table::borrow_mut<address, Ledger<T1>>(0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v13), arg2);
        let v15 = 0;
        let v16 = 0;
        while (v16 < 0x1::vector::length<u64>(&v0)) {
            if (*0x1::vector::borrow<u64>(&v0, v16) != 18446744073709551615) {
                let v17 = 0x1::vector::borrow_mut<Bucket>(&mut v14.buckets, v16);
                v17.basis = *0x1::vector::borrow<u64>(&v1, v16);
                v17.amount = v17.amount - *0x1::vector::borrow<u64>(&v0, v16);
                v17.prov = 0x1::vector::empty<Part>();
                0x1::vector::push_back<u64>(&mut v12, v17.unlock_ms);
                v15 = v15 + *0x1::vector::borrow<u64>(&v0, v16);
            };
            v16 = v16 + 1;
        };
        if (v15 > 0) {
            let v18 = 0;
            while (v18 < 0x1::vector::length<Bucket>(&v14.buckets)) {
                if (0x1::vector::borrow<Bucket>(&v14.buckets, v18).amount == 0) {
                    0x1::vector::remove<Bucket>(&mut v14.buckets, v18);
                    continue
                };
                v18 = v18 + 1;
            };
        };
        0x1::vector::reverse<u64>(&mut v12);
        let v19 = 0;
        while (v19 < 0x1::vector::length<u64>(&v12)) {
            drop_final_bucket_loss<T0, T1>(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut v12));
            v19 = v19 + 1;
        };
        0x1::vector::destroy_empty<u64>(v12);
        if (v15 == 0) {
            return
        };
        let v20 = LockKey<T1>{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::burn_reward<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(&mut 0x2::table::borrow_mut<address, Ledger<T1>>(0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v20), arg2).balance, v15));
        let v21 = LockedMintScaledEventV1{
            exchange_id : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1),
            owner       : arg2,
            burned      : v15,
        };
        let v22 = Event<LockedMintScaledEventV1>{pos0: v21};
        0x2::event::emit<Event<LockedMintScaledEventV1>>(v22);
    }

    fun settled_basis<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: &Bucket, arg3: u64) : u64 {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
        let v1 = BucketLossKey<T1>{
            owner     : arg1,
            unlock_ms : arg2.unlock_ms,
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v1)) {
            let v6 = 0x2::dynamic_field::borrow<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1);
            let v7 = 0;
            let v8 = &arg2.prov;
            let v9 = 0;
            while (v9 < 0x1::vector::length<Part>(v8)) {
                let v10 = 0x1::vector::borrow<Part>(v8, v9);
                let v11 = v7 < 0x1::vector::length<EpochBasis>(v6) && 0x1::vector::borrow<EpochBasis>(v6, v7).epoch == v10.epoch;
                let v12;
                let v13;
                let v14 = if (v11) {
                    0x1::option::some<u64>(v7)
                } else {
                    v13 = 0;
                    /* label 11 */
                    let v14;
                    while (v13 < 0x1::vector::length<EpochBasis>(v6)) {
                        if (0x1::vector::borrow<EpochBasis>(v6, v13).epoch == v10.epoch) {
                            v12 = 0x1::option::some<u64>(v13);
                            /* label 14 */
                            v14 = v12;
                            /* goto 15 */
                        } else {
                            /* goto 24 */
                        };
                    };
                    v14
                };
                /* label 15 */
                let v15 = v14;
                if (0x1::option::is_some<u64>(&v15)) {
                    v7 = *0x1::option::borrow<u64>(&v15) + 1;
                };
                if (v10.amount > 0 && 0x1::option::is_some<u64>(&v15)) {
                    let v16 = (0x1::vector::borrow<EpochBasis>(v6, 0x1::option::destroy_some<u64>(v15)).basis as u128);
                    let (_, v18) = 0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::scale_of<T0>(arg0, v10.epoch);
                    let v19 = (((v10.amount as u128) * (v18 as u128) / 1000000) as u64);
                    v2 = v2 + v16;
                    v3 = v3 + v16 * (v19 as u128) / (v10.amount as u128);
                    v4 = v4 + v10.amount;
                    v5 = v5 + v10.amount - v19;
                };
                v9 = v9 + 1;
                continue;
                /* label 24 */
                v13 = v13 + 1;
                /* goto 11 */
                continue;
                v12 = 0x1::option::none<u64>();
                /* goto 14 */
            };
        };
        let v20 = (arg2.basis as u128);
        let v21 = if (v20 > v2) {
            v20 - v2
        } else {
            0
        };
        let v22 = arg2.amount - v4;
        let v23 = if (v22 == 0) {
            v21
        } else {
            v21 * ((v22 - arg3 - v5) as u128) / (v22 as u128)
        };
        let v24 = v23 + v3;
        if (v24 < v20) {
            (v24 as u64)
        } else {
            arg2.basis
        }
    }

    fun settled_view<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &Bucket) : (bool, Bucket) {
        let v0 = *arg1;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Part>(&arg1.prov)) {
            let v3 = 0x1::vector::borrow<Part>(&arg1.prov, v2);
            let (v4, v5) = 0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::scale_of<T0>(arg0, v3.epoch);
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

    fun split_bucket_kept<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = take_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3);
        if (v0 == 0) {
            return 0
        };
        if (arg4 >= arg5) {
            return v0
        };
        let v1 = (((v0 as u128) * (arg4 as u128) / (arg5 as u128)) as u64);
        if (v0 > v1) {
            add_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3, v0 - v1);
        };
        v1
    }

    fun split_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) : vector<EpochBasis> {
        let v0 = load_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = &mut v0;
        store_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3, v0);
        take_epoch_basis(v1, arg4, arg5)
    }

    fun store_bucket_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: vector<EpochBasis>) {
        if (0x1::vector::is_empty<EpochBasis>(&arg4)) {
            return
        };
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketLossKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (0x2::dynamic_field::exists<BucketLossKey<T1>>(v0, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1);
            merge_epoch_basis(v2, arg4);
        } else {
            0x2::dynamic_field::add<BucketLossKey<T1>, vector<EpochBasis>>(v0, v1, arg4);
        };
    }

    fun take_bucket_kept<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) : u64 {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = BucketKeptKey<T1>{
            owner     : arg2,
            unlock_ms : arg3,
        };
        if (!0x2::dynamic_field::exists<BucketKeptKey<T1>>(v0, v1)) {
            return 0
        };
        0x2::dynamic_field::remove<BucketKeptKey<T1>, u64>(v0, v1)
    }

    fun take_epoch_basis(arg0: &mut vector<EpochBasis>, arg1: u64, arg2: u64) : vector<EpochBasis> {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            0x1::vector::is_empty<EpochBasis>(arg0)
        };
        if (v0) {
            return 0x1::vector::empty<EpochBasis>()
        };
        if (arg1 >= arg2) {
            *arg0 = 0x1::vector::empty<EpochBasis>();
            return *arg0
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<EpochBasis>(arg0)) {
            v1 = v1 + (0x1::vector::borrow<EpochBasis>(arg0, v2).basis as u128);
            v2 = v2 + 1;
        };
        let v3 = v1 * (arg1 as u128) / (arg2 as u128);
        let v4 = 0x1::vector::empty<EpochBasis>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<EpochBasis>(arg0)) {
            let v7 = 0x1::vector::borrow<EpochBasis>(arg0, v6).basis;
            let v8 = (((v7 as u128) * (arg1 as u128) / (arg2 as u128)) as u64);
            let v9 = if (v8 < v7) {
                v8
            } else {
                v7
            };
            0x1::vector::borrow_mut<EpochBasis>(arg0, v6).basis = v7 - v9;
            v5 = v5 + (v9 as u128);
            if (v9 > 0) {
                let v10 = EpochBasis{
                    epoch : 0x1::vector::borrow<EpochBasis>(arg0, v6).epoch,
                    basis : v9,
                };
                0x1::vector::push_back<EpochBasis>(&mut v4, v10);
            };
            v6 = v6 + 1;
        };
        let v11 = if (v3 > v5) {
            v3 - v5
        } else {
            0
        };
        let v12 = v11;
        v6 = 0;
        while (v12 > 0 && v6 < 0x1::vector::length<EpochBasis>(arg0)) {
            let v13 = 0x1::vector::borrow<EpochBasis>(arg0, v6).basis;
            let v14;
            let v15;
            if (v13 > 0) {
                let v16 = if ((v13 as u128) < v12) {
                    v13
                } else {
                    (v12 as u64)
                };
                let v17 = 0x1::vector::borrow<EpochBasis>(arg0, v6).epoch;
                0x1::vector::borrow_mut<EpochBasis>(arg0, v6).basis = v13 - v16;
                v12 = v12 - (v16 as u128);
                let v18 = &v4;
                v15 = 0;
                while (v15 < 0x1::vector::length<EpochBasis>(v18)) {
                    if (0x1::vector::borrow<EpochBasis>(v18, v15).epoch == v17) {
                        v14 = 0x1::option::some<u64>(v15);
                        /* label 38 */
                        if (0x1::option::is_some<u64>(&v14)) {
                            let v19 = 0x1::vector::borrow_mut<EpochBasis>(&mut v4, 0x1::option::destroy_some<u64>(v14));
                            v19.basis = v19.basis + v16;
                            /* goto 41 */
                        } else {
                            let v20 = EpochBasis{
                                epoch : v17,
                                basis : v16,
                            };
                            0x1::vector::push_back<EpochBasis>(&mut v4, v20);
                            /* goto 41 */
                        };
                    } else {
                        /* goto 42 */
                    };
                };
            };
            /* label 41 */
            v6 = v6 + 1;
            continue;
            /* label 42 */
            v15 = v15 + 1;
            /* goto 33 */
            continue;
            v14 = 0x1::option::none<u64>();
            /* goto 38 */
        };
        drop_zero_basis(arg0);
        v4
    }

    public fun take_forfeits<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : 0x2::balance::Balance<T1> {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = ForfeitKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ForfeitKey<T1>>(v0, v1)) {
            return 0x2::balance::zero<T1>()
        };
        let v2 = ForfeitKey<T1>{dummy_field: false};
        0x2::balance::withdraw_all<T1>(0x2::dynamic_field::borrow_mut<ForfeitKey<T1>, 0x2::balance::Balance<T1>>(v0, v2))
    }

    fun take_locked<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T1>, u64, vector<Part>, u64, vector<EpochBasis>, u64) {
        assert!(has_ledger<T0, T1>(arg1, arg2), 0);
        settle<T0, T1>(arg0, arg1, arg2, arg5);
        let v0 = LockKey<T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LockKey<T1>, 0x2::table::Table<address, Ledger<T1>>>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v0);
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
                let v28 = split_bucket_loss<T0, T1>(arg0, arg1, arg2, arg3, arg4, v9);
                return (0x2::balance::split<T1>(&mut v2.balance, arg4), v8, v18, 0x2::balance::value<T1>(&v2.balance), v28, split_bucket_kept<T0, T1>(arg0, arg1, arg2, arg3, arg4, v9))
            };
            v4 = v4 + 1;
        };
        v5 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun take_reserve<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) : (vector<Part>, vector<EpochBasis>) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = ReserveLossKey{account_id: arg2};
        let v2 = if (0x2::dynamic_field::exists<ReserveLossKey>(v0, v1)) {
            0x2::dynamic_field::remove<ReserveLossKey, vector<EpochBasis>>(v0, v1)
        } else {
            0x1::vector::empty<EpochBasis>()
        };
        let v3 = ReserveKey{account_id: arg2};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v3)) {
            return (0x1::vector::empty<Part>(), v2)
        };
        let v4 = 0x2::dynamic_field::remove<ReserveKey, vector<Part>>(v0, v3);
        let v5 = 0;
        let v6 = &v4;
        let v7 = 0;
        while (v7 < 0x1::vector::length<Part>(v6)) {
            v5 = v5 + (0x1::vector::borrow<Part>(v6, v7).amount as u128);
            v7 = v7 + 1;
        };
        if (v5 <= (arg3 as u128)) {
            return (v4, v2)
        };
        let v8 = 0x1::vector::empty<Part>();
        0x1::vector::reverse<Part>(&mut v4);
        let v9 = 0;
        while (v9 < 0x1::vector::length<Part>(&v4)) {
            let v10 = 0x1::vector::pop_back<Part>(&mut v4);
            let v11 = (((v10.amount as u128) * (arg3 as u128) / v5) as u64);
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unnote_mint<T0>(arg0, arg1, v10.epoch, v10.amount - v11);
            if (v11 > 0) {
                let v12 = Part{
                    epoch  : v10.epoch,
                    amount : v11,
                };
                0x1::vector::push_back<Part>(&mut v8, v12);
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<Part>(v4);
        (v8, v2)
    }

    fun unnote_voided_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &vector<EpochBasis>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<EpochBasis>(arg2)) {
            let v1 = 0x1::vector::borrow<EpochBasis>(arg2, v0);
            0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unnote_loss<T0>(arg0, arg1, v1.epoch, v1.basis);
            v0 = v0 + 1;
        };
    }

    public fun vest_ms() : u64 {
        2592000000
    }

    public fun vest_status<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64) {
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

