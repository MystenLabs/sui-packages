module 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax {
    struct TaxStoreKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TaxStore has store {
        tax_fund: 0x2::balance::Balance<0x2::sui::SUI>,
        version_counters: 0x2::table::Table<0x2::object::ID, u64>,
        tax_buckets: 0x2::table::Table<TaxBucketKey, TaxBucket>,
        tax_levels: vector<TaxLevelCfg>,
        self_claimable: 0x2::table::Table<0x2::object::ID, u64>,
        polygon_buckets: 0x2::table::Table<0x2::object::ID, vector<TaxBucketKey>>,
    }

    struct TaxLevelCfg has copy, drop, store {
        retain_upstream_ppm: u64,
        collector_fee_bps: u64,
        bucket_epochs: u64,
        expiry_epochs: u64,
    }

    struct TaxBucketKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
        version: u64,
        bucket_id: u64,
        origin_level_rank: u8,
        ancestor_distance: u8,
        accrual_epoch: u64,
    }

    struct TaxBucket has store {
        upstream_total: u64,
        open_epoch: u64,
        accrual_epoch: u64,
        expires_at: u64,
    }

    struct ChildRef has copy, drop, store {
        child_id: 0x2::object::ID,
        bucket_id: u64,
        origin_level_rank: u8,
        ancestor_distance: u8,
    }

    struct TaxBucketOpened has copy, drop {
        polygon_id: 0x2::object::ID,
        version: u64,
        bucket_id: u64,
        origin_level_rank: u8,
        ancestor_distance: u8,
        accrual_epoch: u64,
        amount: u64,
    }

    struct TaxCollected has copy, drop {
        parent_id: 0x2::object::ID,
        child_id: 0x2::object::ID,
        child_version: u64,
        bucket_id: u64,
        origin_level_rank: u8,
        ancestor_distance: u8,
        accrual_epoch: u64,
        amount: u64,
        self_keep: u64,
        forward_upstream: u64,
    }

    struct TaxWithdrawn has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct TaxSwept has copy, drop {
        polygon_id: 0x2::object::ID,
        version: u64,
        bucket_id: u64,
        origin_level_rank: u8,
        ancestor_distance: u8,
        accrual_epoch: u64,
        remainder: u64,
    }

    struct TaxVersionClosed has copy, drop {
        polygon_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct TaxLevelCfgUpdated has copy, drop {
        level_index: u64,
        bucket_epochs: u64,
        expiry_epochs: u64,
    }

    fun borrow_tax_store(arg0: &0x2::object::UID) : &TaxStore {
        let v0 = TaxStoreKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TaxStoreKey>(arg0, v0), 3200);
        let v1 = TaxStoreKey{dummy_field: false};
        0x2::dynamic_field::borrow<TaxStoreKey, TaxStore>(arg0, v1)
    }

    fun borrow_tax_store_mut(arg0: &mut 0x2::object::UID) : &mut TaxStore {
        let v0 = TaxStoreKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TaxStoreKey>(arg0, v0), 3200);
        let v1 = TaxStoreKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TaxStoreKey, TaxStore>(arg0, v1)
    }

    fun collect_batch_impl(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg3: 0x2::object::ID, arg4: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg5: vector<ChildRef>, arg6: &0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x1::vector::length<ChildRef>(&arg5) <= 20, 3201);
        assert!(0x1::vector::length<ChildRef>(&arg5) > 0, 3202);
        let v0 = 6;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ChildRef>(&arg5)) {
            let v4 = *0x1::vector::borrow<ChildRef>(&arg5, v3);
            let v5 = 0x1::vector::empty<TaxBucketKey>();
            let v6 = borrow_tax_store(arg0);
            if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v6.polygon_buckets, v4.child_id)) {
                let v7 = 0x2::table::borrow<0x2::object::ID, vector<TaxBucketKey>>(&v6.polygon_buckets, v4.child_id);
                let v8 = 0;
                while (v8 < 0x1::vector::length<TaxBucketKey>(v7)) {
                    let v9 = *0x1::vector::borrow<TaxBucketKey>(v7, v8);
                    if (v9.bucket_id == v4.bucket_id) {
                        if (arg1 == (v9.origin_level_rank as u64) + (v9.ancestor_distance as u64)) {
                            0x1::vector::push_back<TaxBucketKey>(&mut v5, v9);
                        };
                    };
                    v8 = v8 + 1;
                };
            };
            if (0x1::vector::length<TaxBucketKey>(&v5) == 0) {
                v3 = v3 + 1;
                continue
            };
            if (!0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::outer_contains_inner(arg2, arg3, arg4, v4.child_id)) {
                v3 = v3 + 1;
                continue
            };
            let v10 = 0;
            while (v10 < 0x1::vector::length<TaxBucketKey>(&v5)) {
                let v11 = *0x1::vector::borrow<TaxBucketKey>(&v5, v10);
                let v12 = false;
                let v13 = 0;
                let v14 = borrow_tax_store(arg0);
                if (0x2::table::contains<TaxBucketKey, TaxBucket>(&v14.tax_buckets, v11)) {
                    v12 = true;
                    v13 = 0x2::table::borrow<TaxBucketKey, TaxBucket>(&v14.tax_buckets, v11).upstream_total;
                };
                if (!v12) {
                    v10 = v10 + 1;
                    continue
                };
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::created_epoch(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg2, arg3)) > v11.accrual_epoch) {
                    v10 = v10 + 1;
                    continue
                };
                let v15 = v11.origin_level_rank;
                let v16 = v11.ancestor_distance;
                let v17 = if ((v15 as u64) >= v0 - 1) {
                    0
                } else {
                    v0 - 1 - (v15 as u64)
                };
                let v18 = if ((v16 as u64) >= v17) {
                    0
                } else {
                    v17 - (v16 as u64)
                };
                let v19 = if (v18 == 0) {
                    v13
                } else if (v16 == 1) {
                    v13 / 2
                } else {
                    v13 / (1 + v18)
                };
                let v20 = v13 - v19;
                let v21 = borrow_tax_store_mut(arg0);
                let TaxBucket {
                    upstream_total : _,
                    open_epoch     : _,
                    accrual_epoch  : _,
                    expires_at     : _,
                } = 0x2::table::remove<TaxBucketKey, TaxBucket>(&mut v21.tax_buckets, v11);
                if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v21.polygon_buckets, v4.child_id)) {
                    let v26 = 0x2::table::borrow_mut<0x2::object::ID, vector<TaxBucketKey>>(&mut v21.polygon_buckets, v4.child_id);
                    let v27 = 0;
                    while (v27 < 0x1::vector::length<TaxBucketKey>(v26)) {
                        if (*0x1::vector::borrow<TaxBucketKey>(v26, v27) == v11) {
                            0x1::vector::swap_remove<TaxBucketKey>(v26, v27);
                            continue
                        };
                        v27 = v27 + 1;
                    };
                };
                let v28 = v1 + v19;
                v1 = v28;
                if (v20 > 0) {
                    if (v18 > 0 && v20 >= 1000) {
                        let v29 = 0;
                        let v30 = TaxLevelCfg{
                            retain_upstream_ppm : 0,
                            collector_fee_bps   : 0,
                            bucket_epochs       : 7,
                            expiry_epochs       : 30,
                        };
                        let v31 = borrow_tax_store(arg0);
                        if (0x2::table::contains<0x2::object::ID, u64>(&v31.version_counters, arg3)) {
                            v29 = *0x2::table::borrow<0x2::object::ID, u64>(&v31.version_counters, arg3);
                        };
                        if (arg1 < 0x1::vector::length<TaxLevelCfg>(&v31.tax_levels)) {
                            v30 = *0x1::vector::borrow<TaxLevelCfg>(&v31.tax_levels, arg1);
                        };
                        let v32 = if (v30.bucket_epochs == 0) {
                            1
                        } else {
                            v30.bucket_epochs
                        };
                        let v33 = v16 + 1;
                        let v34 = TaxBucketKey{
                            polygon_id        : arg3,
                            version           : v29,
                            bucket_id         : v11.bucket_id,
                            origin_level_rank : v15,
                            ancestor_distance : v33,
                            accrual_epoch     : v11.accrual_epoch,
                        };
                        let v35 = false;
                        let v36 = borrow_tax_store_mut(arg0);
                        if (0x2::table::contains<TaxBucketKey, TaxBucket>(&v36.tax_buckets, v34)) {
                            let v37 = 0x2::table::borrow_mut<TaxBucketKey, TaxBucket>(&mut v36.tax_buckets, v34);
                            v37.upstream_total = v37.upstream_total + v20;
                        } else if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v36.polygon_buckets, arg3) && 0x1::vector::length<TaxBucketKey>(0x2::table::borrow<0x2::object::ID, vector<TaxBucketKey>>(&v36.polygon_buckets, arg3)) >= 200) {
                            v1 = v28 + v20;
                        } else {
                            let v38 = TaxBucket{
                                upstream_total : v20,
                                open_epoch     : 0x2::tx_context::epoch(arg6),
                                accrual_epoch  : v11.accrual_epoch,
                                expires_at     : saturating_expires_at(v11.bucket_id, v32, v30.expiry_epochs),
                            };
                            0x2::table::add<TaxBucketKey, TaxBucket>(&mut v36.tax_buckets, v34, v38);
                            if (!0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v36.polygon_buckets, arg3)) {
                                0x2::table::add<0x2::object::ID, vector<TaxBucketKey>>(&mut v36.polygon_buckets, arg3, 0x1::vector::empty<TaxBucketKey>());
                            };
                            0x1::vector::push_back<TaxBucketKey>(0x2::table::borrow_mut<0x2::object::ID, vector<TaxBucketKey>>(&mut v36.polygon_buckets, arg3), v34);
                            v35 = true;
                        };
                        if (v35) {
                            let v39 = TaxBucketOpened{
                                polygon_id        : arg3,
                                version           : v29,
                                bucket_id         : v11.bucket_id,
                                origin_level_rank : v15,
                                ancestor_distance : v33,
                                accrual_epoch     : v11.accrual_epoch,
                                amount            : v20,
                            };
                            0x2::event::emit<TaxBucketOpened>(v39);
                        };
                    } else {
                        v1 = v28 + v20;
                    };
                };
                let v40 = TaxCollected{
                    parent_id         : arg3,
                    child_id          : v4.child_id,
                    child_version     : v11.version,
                    bucket_id         : v4.bucket_id,
                    origin_level_rank : v15,
                    ancestor_distance : v16,
                    accrual_epoch     : v11.accrual_epoch,
                    amount            : v13,
                    self_keep         : v19,
                    forward_upstream  : v20,
                };
                0x2::event::emit<TaxCollected>(v40);
                v10 = v10 + 1;
            };
            let v41 = borrow_tax_store_mut(arg0);
            if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v41.polygon_buckets, v4.child_id)) {
                if (0x1::vector::length<TaxBucketKey>(0x2::table::borrow<0x2::object::ID, vector<TaxBucketKey>>(&v41.polygon_buckets, v4.child_id)) == 0) {
                    0x2::table::remove<0x2::object::ID, vector<TaxBucketKey>>(&mut v41.polygon_buckets, v4.child_id);
                };
            };
            v3 = v3 + 1;
        };
        let v42 = if (v2 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut borrow_tax_store_mut(arg0).tax_fund, v2)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        (v1, v42)
    }

    public fun collect_tax(arg0: &mut 0x2::object::UID, arg1: bool, arg2: u64, arg3: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg4: 0x2::object::ID, arg5: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg6: vector<0x2::object::ID>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(!arg1, 3115);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(v0 == 0x1::vector::length<u64>(&arg7), 3207);
        let v1 = 0x1::vector::empty<ChildRef>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = ChildRef{
                child_id          : *0x1::vector::borrow<0x2::object::ID>(&arg6, v2),
                bucket_id         : *0x1::vector::borrow<u64>(&arg7, v2),
                origin_level_rank : 0,
                ancestor_distance : 0,
            };
            0x1::vector::push_back<ChildRef>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let (v4, v5) = collect_batch_impl(arg0, arg2, arg3, arg4, arg5, v1, arg8);
        let v6 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg3, arg4));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut borrow_tax_store_mut(arg0).tax_fund, v4), arg8), v6);
            let v7 = TaxWithdrawn{
                polygon_id : arg4,
                owner      : v6,
                amount     : v4,
            };
            0x2::event::emit<TaxWithdrawn>(v7);
        };
        v5
    }

    public fun init_tax(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TaxStoreKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TaxStoreKey>(arg0, v0), 3206);
        let v1 = TaxStore{
            tax_fund         : 0x2::balance::zero<0x2::sui::SUI>(),
            version_counters : 0x2::table::new<0x2::object::ID, u64>(arg2),
            tax_buckets      : 0x2::table::new<TaxBucketKey, TaxBucket>(arg2),
            tax_levels       : 0x1::vector::empty<TaxLevelCfg>(),
            self_claimable   : 0x2::table::new<0x2::object::ID, u64>(arg2),
            polygon_buckets  : 0x2::table::new<0x2::object::ID, vector<TaxBucketKey>>(arg2),
        };
        let v2 = TaxStoreKey{dummy_field: false};
        0x2::dynamic_field::add<TaxStoreKey, TaxStore>(arg0, v2, v1);
    }

    fun saturating_expires_at(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 >= 18446744073709551615 / arg1) {
            18446744073709551615
        } else {
            (arg0 + 1) * arg1
        };
        if (v0 > 18446744073709551615 - arg2) {
            18446744073709551615
        } else {
            v0 + arg2
        }
    }

    public fun set_tax_level_cfg(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: TaxLevelCfg) {
        assert!(arg3.retain_upstream_ppm == 0, 3207);
        assert!(arg3.collector_fee_bps == 0, 3207);
        assert!(arg3.bucket_epochs >= 1, 3207);
        assert!(arg3.bucket_epochs <= 365000, 3207);
        assert!(arg3.expiry_epochs <= 365000, 3207);
        assert!(arg3.expiry_epochs > arg3.bucket_epochs, 3207);
        assert!(arg2 < arg1, 3207);
        let v0 = borrow_tax_store_mut(arg0);
        while (0x1::vector::length<TaxLevelCfg>(&v0.tax_levels) <= arg2) {
            let v1 = TaxLevelCfg{
                retain_upstream_ppm : 0,
                collector_fee_bps   : 0,
                bucket_epochs       : 7,
                expiry_epochs       : 30,
            };
            0x1::vector::push_back<TaxLevelCfg>(&mut v0.tax_levels, v1);
        };
        *0x1::vector::borrow_mut<TaxLevelCfg>(&mut v0.tax_levels, arg2) = arg3;
        let v2 = TaxLevelCfgUpdated{
            level_index   : arg2,
            bucket_epochs : arg3.bucket_epochs,
            expiry_epochs : arg3.expiry_epochs,
        };
        0x2::event::emit<TaxLevelCfgUpdated>(v2);
    }

    public fun sweep_expired(arg0: &mut 0x2::object::UID, arg1: bool, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(!arg1, 3115);
        let v0 = 0x1::vector::empty<TaxBucketKey>();
        let v1 = borrow_tax_store(arg0);
        if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v1.polygon_buckets, arg2)) {
            let v2 = 0x2::table::borrow<0x2::object::ID, vector<TaxBucketKey>>(&v1.polygon_buckets, arg2);
            let v3 = 0;
            while (v3 < 0x1::vector::length<TaxBucketKey>(v2)) {
                let v4 = *0x1::vector::borrow<TaxBucketKey>(v2, v3);
                if (v4.version == arg3 && v4.bucket_id == arg4) {
                    if (0x2::tx_context::epoch(arg5) > 0x2::table::borrow<TaxBucketKey, TaxBucket>(&v1.tax_buckets, v4).expires_at) {
                        0x1::vector::push_back<TaxBucketKey>(&mut v0, v4);
                    };
                };
                v3 = v3 + 1;
            };
        };
        assert!(0x1::vector::length<TaxBucketKey>(&v0) > 0, 3203);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<TaxBucketKey>(&v0)) {
            let v7 = *0x1::vector::borrow<TaxBucketKey>(&v0, v6);
            let v8 = borrow_tax_store_mut(arg0);
            let TaxBucket {
                upstream_total : v9,
                open_epoch     : _,
                accrual_epoch  : _,
                expires_at     : _,
            } = 0x2::table::remove<TaxBucketKey, TaxBucket>(&mut v8.tax_buckets, v7);
            v5 = v5 + v9;
            let v13 = TaxSwept{
                polygon_id        : v7.polygon_id,
                version           : v7.version,
                bucket_id         : v7.bucket_id,
                origin_level_rank : v7.origin_level_rank,
                ancestor_distance : v7.ancestor_distance,
                accrual_epoch     : v7.accrual_epoch,
                remainder         : v9,
            };
            0x2::event::emit<TaxSwept>(v13);
            v6 = v6 + 1;
        };
        let v14 = borrow_tax_store_mut(arg0);
        if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v14.polygon_buckets, arg2)) {
            let v15 = 0x2::table::borrow_mut<0x2::object::ID, vector<TaxBucketKey>>(&mut v14.polygon_buckets, arg2);
            let v16 = 0;
            while (v16 < 0x1::vector::length<TaxBucketKey>(v15)) {
                let v17 = *0x1::vector::borrow<TaxBucketKey>(v15, v16);
                if (v17.version == arg3 && v17.bucket_id == arg4) {
                    0x1::vector::swap_remove<TaxBucketKey>(v15, v16);
                    continue
                };
                v16 = v16 + 1;
            };
            if (0x1::vector::length<TaxBucketKey>(v15) == 0) {
                0x2::table::remove<0x2::object::ID, vector<TaxBucketKey>>(&mut v14.polygon_buckets, arg2);
            };
        };
        if (v5 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut borrow_tax_store_mut(arg0).tax_fund, v5)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        }
    }

    public(friend) fun tax_accrue(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u8, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = 6;
        let v2 = if ((arg4 as u64) >= v1 - 1) {
            0
        } else {
            v1 - 1 - (arg4 as u64)
        };
        if (v2 == 0) {
            return arg2
        };
        let v3 = 0x2::tx_context::epoch(arg5);
        let v4 = borrow_tax_store_mut(arg0);
        let v5 = if (arg3 < 0x1::vector::length<TaxLevelCfg>(&v4.tax_levels)) {
            *0x1::vector::borrow<TaxLevelCfg>(&v4.tax_levels, arg3)
        } else {
            TaxLevelCfg{retain_upstream_ppm: 0, collector_fee_bps: 0, bucket_epochs: 7, expiry_epochs: 30}
        };
        let v6 = v5;
        let v7 = if (v6.bucket_epochs == 0) {
            1
        } else {
            v6.bucket_epochs
        };
        let v8 = v3 / v7;
        let v9 = if (0x2::table::contains<0x2::object::ID, u64>(&v4.version_counters, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v4.version_counters, arg1)
        } else {
            0
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v4.tax_fund, arg2);
        let v10 = TaxBucketKey{
            polygon_id        : arg1,
            version           : v9,
            bucket_id         : v8,
            origin_level_rank : arg4,
            ancestor_distance : 1,
            accrual_epoch     : v3,
        };
        if (0x2::table::contains<TaxBucketKey, TaxBucket>(&v4.tax_buckets, v10)) {
            let v11 = 0x2::table::borrow_mut<TaxBucketKey, TaxBucket>(&mut v4.tax_buckets, v10);
            v11.upstream_total = v11.upstream_total + v0;
        } else {
            if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v4.polygon_buckets, arg1) && 0x1::vector::length<TaxBucketKey>(0x2::table::borrow<0x2::object::ID, vector<TaxBucketKey>>(&v4.polygon_buckets, arg1)) >= 200) {
                return 0x2::balance::split<0x2::sui::SUI>(&mut v4.tax_fund, v0)
            };
            let v12 = TaxBucket{
                upstream_total : v0,
                open_epoch     : v3,
                accrual_epoch  : v3,
                expires_at     : saturating_expires_at(v8, v7, v6.expiry_epochs),
            };
            0x2::table::add<TaxBucketKey, TaxBucket>(&mut v4.tax_buckets, v10, v12);
            if (!0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v4.polygon_buckets, arg1)) {
                0x2::table::add<0x2::object::ID, vector<TaxBucketKey>>(&mut v4.polygon_buckets, arg1, 0x1::vector::empty<TaxBucketKey>());
            };
            0x1::vector::push_back<TaxBucketKey>(0x2::table::borrow_mut<0x2::object::ID, vector<TaxBucketKey>>(&mut v4.polygon_buckets, arg1), v10);
        };
        let v13 = TaxBucketOpened{
            polygon_id        : arg1,
            version           : v9,
            bucket_id         : v8,
            origin_level_rank : arg4,
            ancestor_distance : 1,
            accrual_epoch     : v3,
            amount            : v0,
        };
        0x2::event::emit<TaxBucketOpened>(v13);
        0x2::balance::zero<0x2::sui::SUI>()
    }

    public(friend) fun tax_close_and_sweep(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (!tax_is_initialized(arg0)) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let v0 = borrow_tax_store_mut(arg0);
        let v1 = 0;
        if (0x2::table::contains<0x2::object::ID, vector<TaxBucketKey>>(&v0.polygon_buckets, arg1)) {
            let v2 = 0x2::table::remove<0x2::object::ID, vector<TaxBucketKey>>(&mut v0.polygon_buckets, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<TaxBucketKey>(&v2)) {
                let v4 = *0x1::vector::borrow<TaxBucketKey>(&v2, v3);
                if (0x2::table::contains<TaxBucketKey, TaxBucket>(&v0.tax_buckets, v4)) {
                    let TaxBucket {
                        upstream_total : v5,
                        open_epoch     : _,
                        accrual_epoch  : _,
                        expires_at     : _,
                    } = 0x2::table::remove<TaxBucketKey, TaxBucket>(&mut v0.tax_buckets, v4);
                    v1 = v1 + v5;
                    let v9 = TaxSwept{
                        polygon_id        : v4.polygon_id,
                        version           : v4.version,
                        bucket_id         : v4.bucket_id,
                        origin_level_rank : v4.origin_level_rank,
                        ancestor_distance : v4.ancestor_distance,
                        accrual_epoch     : v4.accrual_epoch,
                        remainder         : v5,
                    };
                    0x2::event::emit<TaxSwept>(v9);
                };
                v3 = v3 + 1;
            };
        };
        if (0x2::table::contains<0x2::object::ID, u64>(&v0.version_counters, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut v0.version_counters, arg1);
        };
        if (v1 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut borrow_tax_store_mut(arg0).tax_fund, v1)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        }
    }

    public(friend) fun tax_close_version(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = borrow_tax_store_mut(arg0);
        let v1 = if (0x2::table::contains<0x2::object::ID, u64>(&v0.version_counters, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v0.version_counters, arg1)
        } else {
            0
        };
        let v2 = v1 + 1;
        if (0x2::table::contains<0x2::object::ID, u64>(&v0.version_counters, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v0.version_counters, arg1) = v2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut v0.version_counters, arg1, v2);
        };
        let v3 = TaxVersionClosed{
            polygon_id  : arg1,
            old_version : v1,
            new_version : v2,
        };
        0x2::event::emit<TaxVersionClosed>(v3);
    }

    public fun tax_fund_balance(arg0: &0x2::object::UID) : u64 {
        if (!tax_is_initialized(arg0)) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(&borrow_tax_store(arg0).tax_fund)
    }

    public fun tax_is_initialized(arg0: &0x2::object::UID) : bool {
        let v0 = TaxStoreKey{dummy_field: false};
        0x2::dynamic_field::exists_<TaxStoreKey>(arg0, v0)
    }

    public fun tax_self_claimable(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : u64 {
        0
    }

    public fun tax_version_counter(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : u64 {
        if (!tax_is_initialized(arg0)) {
            return 0
        };
        let v0 = borrow_tax_store(arg0);
        if (0x2::table::contains<0x2::object::ID, u64>(&v0.version_counters, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v0.version_counters, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

