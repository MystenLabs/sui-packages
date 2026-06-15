module 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool {
    struct StreamPool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        org: address,
        total_deposited: u64,
        total_claimed: u64,
        balance: 0x2::balance::Balance<T0>,
        streams: 0x2::table::Table<address, Stream>,
        delegated_roles: 0x2::table::Table<address, u8>,
        total_weekly_committed: u128,
        min_coverage_weeks: u64,
        pending_org: 0x1::option::Option<address>,
    }

    struct Stream has store {
        employee: address,
        rate_amount: u128,
        rate_period_ms: u64,
        pending_balance: u64,
        started_at: u64,
        claimed_at: u64,
        total_paused_ms: u64,
        paused_at: 0x1::option::Option<u64>,
        stopped_at: 0x1::option::Option<u64>,
    }

    struct PoolFunded<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        org: address,
        gross: u64,
        fee: u64,
        net: u64,
        timestamp: u64,
    }

    struct StreamCreated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        employee: address,
        rate_amount: u128,
        rate_period_ms: u64,
        started_at: u64,
    }

    struct PoolToppedUp<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        org: address,
        gross: u64,
        fee: u64,
        net: u64,
    }

    struct FundsClaimed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        employee: address,
        amount: u64,
        timestamp: u64,
    }

    struct StreamPaused<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        employee: address,
        paused_at: u64,
    }

    struct StreamResumed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        employee: address,
        resumed_at: u64,
    }

    struct StreamStopped<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        employee: address,
        stopped_at: u64,
    }

    struct PoolRoleGranted has copy, drop {
        pool_id: 0x2::object::ID,
        account: address,
        role: u8,
    }

    struct PoolRoleRevoked has copy, drop {
        pool_id: 0x2::object::ID,
        account: address,
        role: u8,
    }

    struct OrgTransferProposed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        current_org: address,
        proposed_to: address,
    }

    struct OrgTransferCancelled<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        cancelled_by: address,
    }

    struct OrgTransferred<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        old_org: address,
        new_org: address,
    }

    struct ExcessWithdrawn<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        org: address,
        amount: u64,
    }

    public fun accept_org_transfer<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906836265993895959);
        assert!(0x1::option::is_some<address>(&arg0.pending_org), 13906836270289387551);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_org);
        assert!(0x2::tx_context::sender(arg1) == v0, 13906836278879453217);
        arg0.org = v0;
        arg0.pending_org = 0x1::option::none<address>();
        let v1 = OrgTransferred<T0>{
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            old_org : arg0.org,
            new_org : v0,
        };
        0x2::event::emit<OrgTransferred<T0>>(v1);
    }

    public fun balance_value<T0>(arg0: &StreamPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun borrow_uid<T0>(arg0: &StreamPool<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_uid_mut<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::tx_context::TxContext) : &mut 0x2::object::UID {
        assert!(0x2::tx_context::sender(arg1) == arg0.org, 13906835999704481793);
        &mut arg0.id
    }

    public fun borrow_uid_mut_yield<T0>(arg0: &mut StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun cancel_org_transfer<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906836317533503511);
        assert!(0x2::tx_context::sender(arg1) == arg0.org, 13906836321827028993);
        assert!(0x1::option::is_some<address>(&arg0.pending_org), 13906836326123962399);
        arg0.pending_org = 0x1::option::none<address>();
        let v0 = OrgTransferCancelled<T0>{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            cancelled_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<OrgTransferCancelled<T0>>(v0);
    }

    public fun claim<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906835364050763799);
        assert!(0x2::table::contains<address, Stream>(&arg0.streams, 0x2::tx_context::sender(arg2)), 13906835368344420355);
        let v0 = 0x2::table::borrow_mut<address, Stream>(&mut arg0.streams, 0x2::tx_context::sender(arg2));
        let v1 = if (0x1::option::is_some<u64>(&v0.paused_at)) {
            *0x1::option::borrow<u64>(&v0.paused_at)
        } else if (0x1::option::is_some<u64>(&v0.stopped_at)) {
            *0x1::option::borrow<u64>(&v0.stopped_at)
        } else {
            0x2::clock::timestamp_ms(arg1)
        };
        let v2 = v1 - v0.claimed_at;
        let v3 = if (v2 > v0.total_paused_ms) {
            v2 - v0.total_paused_ms
        } else {
            0
        };
        let v4 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((v3 as u128), v0.rate_amount, (v0.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v4)) {
            let v5 = 0x1::option::destroy_some<u128>(v4);
            assert!(v5 <= 18446744073709551615, 13906835432769978387);
            let v6 = (v0.pending_balance as u128) + ((v5 as u64) as u128);
            assert!(v6 <= 18446744073709551615, 13906835445654880275);
            let v7 = (v6 as u64);
            assert!(v7 > 0, 13906835454244421645);
            let v8 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((604800000 as u128), v0.rate_amount, (v0.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
            if (0x1::option::is_some<u128>(&v8)) {
                assert!(v7 >= (0x1::option::destroy_some<u128>(v8) as u64) / 10 || v0.pending_balance > 0, 13906835475719520273);
                assert!(0x2::balance::value<T0>(&arg0.balance) >= v7, 13906835480014094347);
                arg0.total_claimed = arg0.total_claimed + v7;
                v0.claimed_at = v1;
                v0.total_paused_ms = 0;
                v0.pending_balance = 0;
                let v9 = FundsClaimed<T0>{
                    pool_id   : 0x2::object::uid_to_inner(&arg0.id),
                    employee  : 0x2::tx_context::sender(arg2),
                    amount    : v7,
                    timestamp : 0x2::clock::timestamp_ms(arg1),
                };
                0x2::event::emit<FundsClaimed<T0>>(v9);
                return 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v7), arg2)
            } else {
                0x1::option::destroy_none<u128>(v8);
                abort 13906835467129716755
            };
        } else {
            0x1::option::destroy_none<u128>(v4);
            abort 13906835428475011091
        };
    }

    entry fun claim_and_keep<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun claimable_amount<T0>(arg0: &StreamPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, Stream>(&arg0.streams, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Stream>(&arg0.streams, arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0.paused_at)) {
            *0x1::option::borrow<u64>(&v0.paused_at)
        } else if (0x1::option::is_some<u64>(&v0.stopped_at)) {
            *0x1::option::borrow<u64>(&v0.stopped_at)
        } else {
            0x2::clock::timestamp_ms(arg2)
        };
        let v2 = v1 - v0.claimed_at;
        let v3 = if (v2 > v0.total_paused_ms) {
            v2 - v0.total_paused_ms
        } else {
            0
        };
        let v4 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((v3 as u128), v0.rate_amount, (v0.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v4)) {
            let v5 = (v0.pending_balance as u128) + 0x1::option::destroy_some<u128>(v4);
            if (v5 > 18446744073709551615) {
                return 0
            };
            return (v5 as u64)
        };
        0x1::option::destroy_none<u128>(v4);
        v0.pending_balance
    }

    entry fun create_and_share<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StreamPool<T0>>(create_pool<T0>(arg0, arg1));
    }

    public fun create_pool<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : StreamPool<T0> {
        assert!(arg0 >= 1, 13906834513647632413);
        StreamPool<T0>{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            org                    : 0x2::tx_context::sender(arg1),
            total_deposited        : 0,
            total_claimed          : 0,
            balance                : 0x2::balance::zero<T0>(),
            streams                : 0x2::table::new<address, Stream>(arg1),
            delegated_roles        : 0x2::table::new<address, u8>(arg1),
            total_weekly_committed : 0,
            min_coverage_weeks     : arg0,
            pending_org            : 0x1::option::none<address>(),
        }
    }

    public fun deposit<T0>(arg0: &mut StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: vector<address>, arg4: vector<u128>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834805705015319);
        assert!(0x2::tx_context::sender(arg7) == arg0.org, 13906834809998540801);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u128>(&arg4) && 0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg5), 13906834814294425615);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v0, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::deposit_fee_bps(arg1), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = v0 - v2;
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg7), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg1));
            };
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
            arg0.total_deposited = arg0.total_deposited + v3;
            let v4 = 0x2::clock::timestamp_ms(arg6);
            let v5 = 0x2::object::uid_to_inner(&arg0.id);
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(&arg3)) {
                let v7 = *0x1::vector::borrow<address>(&arg3, v6);
                let v8 = *0x1::vector::borrow<u128>(&arg4, v6);
                let v9 = *0x1::vector::borrow<u64>(&arg5, v6);
                assert!(v9 > 0, 13906834908784099349);
                if (0x2::table::contains<address, Stream>(&arg0.streams, v7)) {
                    let v10 = 0x2::table::borrow_mut<address, Stream>(&mut arg0.streams, v7);
                    let v11 = 0x1::option::is_some<u64>(&v10.stopped_at);
                    let v12 = if (0x1::option::is_some<u64>(&v10.paused_at)) {
                        *0x1::option::borrow<u64>(&v10.paused_at)
                    } else if (0x1::option::is_some<u64>(&v10.stopped_at)) {
                        *0x1::option::borrow<u64>(&v10.stopped_at)
                    } else {
                        v4
                    };
                    let v13 = v12 - v10.claimed_at;
                    let v14 = if (v13 > v10.total_paused_ms) {
                        v13 - v10.total_paused_ms
                    } else {
                        0
                    };
                    let v15 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((v14 as u128), v10.rate_amount, (v10.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
                    if (0x1::option::is_some<u128>(&v15)) {
                        let v16 = 0x1::option::destroy_some<u128>(v15);
                        assert!(v16 <= 18446744073709551615, 13906835011863183379);
                        let v17 = (v10.pending_balance as u128) + ((v16 as u64) as u128);
                        assert!(v17 <= 18446744073709551615, 13906835024748085267);
                        v10.pending_balance = (v17 as u64);
                        v10.claimed_at = v12;
                        v10.total_paused_ms = 0;
                        v10.stopped_at = 0x1::option::none<u64>();
                        if (v11) {
                            v10.claimed_at = v4;
                            v10.started_at = v4;
                        };
                        v10.rate_amount = v8;
                        v10.rate_period_ms = v9;
                        let v18 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v8, (604800000 as u128), (v9 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
                        if (0x1::option::is_some<u128>(&v18)) {
                            if (v11) {
                                arg0.total_weekly_committed = arg0.total_weekly_committed + 0x1::option::destroy_some<u128>(v18);
                            } else {
                                let v19 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v10.rate_amount, (604800000 as u128), (v10.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
                                if (0x1::option::is_some<u128>(&v19)) {
                                    arg0.total_weekly_committed = arg0.total_weekly_committed - 0x1::option::destroy_some<u128>(v19) + 0x1::option::destroy_some<u128>(v18);
                                } else {
                                    0x1::option::destroy_none<u128>(v19);
                                    abort 13906835132122267667
                                };
                            };
                        } else {
                            0x1::option::destroy_none<u128>(v18);
                            abort 13906835110647431187
                        };
                    } else {
                        0x1::option::destroy_none<u128>(v15);
                        abort 13906835007568216083
                    };
                } else {
                    let v20 = Stream{
                        employee        : v7,
                        rate_amount     : v8,
                        rate_period_ms  : v9,
                        pending_balance : 0,
                        started_at      : v4,
                        claimed_at      : v4,
                        total_paused_ms : 0,
                        paused_at       : 0x1::option::none<u64>(),
                        stopped_at      : 0x1::option::none<u64>(),
                    };
                    0x2::table::add<address, Stream>(&mut arg0.streams, v7, v20);
                    let v21 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v8, (604800000 as u128), (v9 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
                    if (0x1::option::is_some<u128>(&v21)) {
                        arg0.total_weekly_committed = arg0.total_weekly_committed + 0x1::option::destroy_some<u128>(v21);
                        let v22 = StreamCreated<T0>{
                            pool_id        : v5,
                            employee       : v7,
                            rate_amount    : v8,
                            rate_period_ms : v9,
                            started_at     : v4,
                        };
                        0x2::event::emit<StreamCreated<T0>>(v22);
                    } else {
                        0x1::option::destroy_none<u128>(v21);
                        abort 13906835200841744403
                    };
                };
                v6 = v6 + 1;
            };
            assert!((0x2::balance::value<T0>(&arg0.balance) as u128) >= arg0.total_weekly_committed * (arg0.min_coverage_weeks as u128), 13906835230906908697);
            let v23 = PoolFunded<T0>{
                pool_id   : v5,
                org       : 0x2::tx_context::sender(arg7),
                gross     : v0,
                fee       : v2,
                net       : v3,
                timestamp : v4,
            };
            0x2::event::emit<PoolFunded<T0>>(v23);
            return
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 13906834835769524243
        };
    }

    public fun grant_pool_role<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.org, 13906834672559587329);
        if (0x2::table::contains<address, u8>(&arg0.delegated_roles, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.delegated_roles, arg1);
            *v0 = *v0 | arg2;
        } else {
            0x2::table::add<address, u8>(&mut arg0.delegated_roles, arg1, arg2);
        };
        let v1 = PoolRoleGranted{
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            account : arg1,
            role    : arg2,
        };
        0x2::event::emit<PoolRoleGranted>(v1);
    }

    public fun has_pool_role<T0>(arg0: &StreamPool<T0>, arg1: address, arg2: u8) : bool {
        arg1 == arg0.org || 0x2::table::contains<address, u8>(&arg0.delegated_roles, arg1) && *0x2::table::borrow<address, u8>(&arg0.delegated_roles, arg1) & arg2 != 0
    }

    public fun has_stream<T0>(arg0: &StreamPool<T0>, arg1: address) : bool {
        0x2::table::contains<address, Stream>(&arg0.streams, arg1)
    }

    public fun merge_balance_from_yield<T0>(arg0: &mut StreamPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    entry fun migrate<T0>(arg0: &mut StreamPool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.org, 13906834612430045185);
        assert!(arg0.version < 1, 13906834616726454295);
        arg0.version = 1;
    }

    public fun min_coverage_weeks<T0>(arg0: &StreamPool<T0>) : u64 {
        arg0.min_coverage_weeks
    }

    public fun org<T0>(arg0: &StreamPool<T0>) : address {
        arg0.org
    }

    public fun pause_stream<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835591684030487);
        assert!(has_pool_role<T0>(arg0, 0x2::tx_context::sender(arg3), 1), 13906835595977555969);
        assert!(0x2::table::contains<address, Stream>(&arg0.streams, arg1), 13906835600272654339);
        let v0 = 0x2::table::borrow_mut<address, Stream>(&mut arg0.streams, arg1);
        assert!(0x1::option::is_none<u64>(&v0.paused_at) && 0x1::option::is_none<u64>(&v0.stopped_at), 13906835608862982153);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        v0.paused_at = 0x1::option::some<u64>(v1);
        let v2 = StreamPaused<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            employee  : arg1,
            paused_at : v1,
        };
        0x2::event::emit<StreamPaused<T0>>(v2);
    }

    public fun pauser_role() : u8 {
        1
    }

    public fun pending_org<T0>(arg0: &StreamPool<T0>) : 0x1::option::Option<address> {
        arg0.pending_org
    }

    public fun propose_org_transfer<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906836231634157591);
        assert!(0x2::tx_context::sender(arg2) == arg0.org, 13906836235927683073);
        arg0.pending_org = 0x1::option::some<address>(arg1);
        let v0 = OrgTransferProposed<T0>{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            current_org : arg0.org,
            proposed_to : arg1,
        };
        0x2::event::emit<OrgTransferProposed<T0>>(v0);
    }

    public fun resume_stream<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835660403507223);
        assert!(has_pool_role<T0>(arg0, 0x2::tx_context::sender(arg3), 1), 13906835664697032705);
        assert!(0x2::table::contains<address, Stream>(&arg0.streams, arg1), 13906835668992131075);
        let v0 = 0x2::table::borrow_mut<address, Stream>(&mut arg0.streams, arg1);
        assert!(0x1::option::is_some<u64>(&v0.paused_at), 13906835677582327815);
        v0.total_paused_ms = v0.total_paused_ms + 0x2::clock::timestamp_ms(arg2) - *0x1::option::borrow<u64>(&v0.paused_at);
        v0.paused_at = 0x1::option::none<u64>();
        let v1 = StreamResumed<T0>{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            employee   : arg1,
            resumed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StreamResumed<T0>>(v1);
    }

    public fun revoke_pool_role<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.org, 13906834719804227585);
        if (0x2::table::contains<address, u8>(&arg0.delegated_roles, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.delegated_roles, arg1);
            *v0 = *v0 & (arg2 ^ 255);
            let v1 = PoolRoleRevoked{
                pool_id : 0x2::object::uid_to_inner(&arg0.id),
                account : arg1,
                role    : arg2,
            };
            0x2::event::emit<PoolRoleRevoked>(v1);
        };
    }

    public fun split_balance_for_invest<T0>(arg0: &mut StreamPool<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.org, 13906836085603827713);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 13906836089899450379);
        assert!(((0x2::balance::value<T0>(&arg0.balance) - arg1) as u128) >= arg0.total_weekly_committed * (arg0.min_coverage_weeks as u128), 13906836098490302489);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun stop_stream<T0>(arg0: &mut StreamPool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835737712918551);
        assert!(0x2::tx_context::sender(arg3) == arg0.org, 13906835742006444033);
        assert!(0x2::table::contains<address, Stream>(&arg0.streams, arg1), 13906835746301542403);
        let v0 = 0x2::table::borrow_mut<address, Stream>(&mut arg0.streams, arg1);
        assert!(0x1::option::is_none<u64>(&v0.stopped_at), 13906835754891608069);
        if (0x1::option::is_some<u64>(&v0.paused_at)) {
            let v1 = *0x1::option::borrow<u64>(&v0.paused_at);
            v0.stopped_at = 0x1::option::some<u64>(v1);
            v0.paused_at = 0x1::option::none<u64>();
            let v2 = v1 - v0.claimed_at;
            if (v0.total_paused_ms > v2) {
                v0.total_paused_ms = v2;
            };
        } else {
            v0.stopped_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        };
        let v3 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v0.rate_amount, (604800000 as u128), (v0.rate_period_ms as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
        if (0x1::option::is_some<u128>(&v3)) {
            let v4 = 0x1::option::destroy_some<u128>(v3);
            let v5 = if (arg0.total_weekly_committed >= v4) {
                arg0.total_weekly_committed - v4
            } else {
                0
            };
            arg0.total_weekly_committed = v5;
            let v6 = StreamStopped<T0>{
                pool_id    : 0x2::object::uid_to_inner(&arg0.id),
                employee   : arg1,
                stopped_at : *0x1::option::borrow<u64>(&v0.stopped_at),
            };
            0x2::event::emit<StreamStopped<T0>>(v6);
            return
        } else {
            0x1::option::destroy_none<u128>(v3);
            abort 13906835827906969619
        };
    }

    public fun topup<T0>(arg0: &mut StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835278151417879);
        assert!(0x2::tx_context::sender(arg3) == arg0.org, 13906835282444943361);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v0, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::deposit_fee_bps(arg1), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = v0 - v2;
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg1));
            };
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
            arg0.total_deposited = arg0.total_deposited + v3;
            let v4 = PoolToppedUp<T0>{
                pool_id : 0x2::object::uid_to_inner(&arg0.id),
                org     : 0x2::tx_context::sender(arg3),
                gross   : v0,
                fee     : v2,
                net     : v3,
            };
            0x2::event::emit<PoolToppedUp<T0>>(v4);
            return
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 13906835303920959507
        };
    }

    public fun total_claimed<T0>(arg0: &StreamPool<T0>) : u64 {
        arg0.total_claimed
    }

    public fun total_deposited<T0>(arg0: &StreamPool<T0>) : u64 {
        arg0.total_deposited
    }

    public fun withdraw_excess<T0>(arg0: &mut StreamPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906836154324746263);
        assert!(0x2::tx_context::sender(arg1) == arg0.org, 13906836158618271745);
        let v0 = arg0.total_weekly_committed * (arg0.min_coverage_weeks as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.balance) as u128);
        assert!(v1 > v0, 13906836171504877595);
        let v2 = ((v1 - v0) as u64);
        let v3 = ExcessWithdrawn<T0>{
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            org     : arg0.org,
            amount  : v2,
        };
        0x2::event::emit<ExcessWithdrawn<T0>>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg1)
    }

    entry fun withdraw_excess_and_keep<T0>(arg0: &mut StreamPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_excess<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

