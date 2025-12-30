module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::bucket {
    struct Bucket has store, key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
        owner: address,
        provider_id: address,
        bucket_id: u32,
        region: vector<u8>,
        country: vector<u8>,
        fb_bucket_id: vector<u8>,
        max_storage_gb: u64,
        max_egress_gb: u64,
        total_capacity_gb: u64,
        used_capacity_gb: u64,
        total_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        available_funds: u64,
        deal_ids: vector<0x2::object::ID>,
        status: u8,
        locked: bool,
        lock_timestamp: u64,
        liquidation_price: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct BucketMarketplace has store, key {
        id: 0x2::object::UID,
        bucket_id: 0x2::object::ID,
        name: vector<u8>,
        price_per_gb_storage: u64,
        price_per_gb_egress: u64,
        versioning_enabled: bool,
        encryption_at_rest: bool,
        encryption_in_transit: bool,
        object_locking: bool,
        api_compatibility: vector<u8>,
        sla_avg_latency_ms: u32,
        sla_avg_uptime_pct: u32,
        access_scope: vector<u8>,
        tags: vector<vector<u8>>,
    }

    struct BucketRegistry has store, key {
        id: 0x2::object::UID,
        buckets: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_buckets: u64,
    }

    struct BucketCreated has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        name: vector<u8>,
        timestamp: u64,
    }

    struct BucketDeleted has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct BucketUpdated has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct BucketLocked has copy, drop {
        bucket_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct BucketLiquidated has copy, drop {
        bucket_id: 0x2::object::ID,
        liquidation_amount: u64,
        timestamp: u64,
    }

    struct FundsAdded has copy, drop {
        bucket_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    public fun add_deal(arg0: &mut Bucket, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.deal_ids, arg1);
    }

    public fun add_funds(arg0: &mut Bucket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 204);
        assert!(arg0.status == 0, 200);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.available_funds = arg0.available_funds + v0;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = FundsAdded{
            bucket_id : 0x2::object::uid_to_inner(&arg0.id),
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FundsAdded>(v1);
    }

    public fun complete_liquidation(arg0: &mut Bucket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 203);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_funds, v0, arg1), arg0.owner);
        arg0.status = 5;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = BucketLiquidated{
            bucket_id          : 0x2::object::uid_to_inner(&arg0.id),
            liquidation_amount : v0,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<BucketLiquidated>(v1);
    }

    public fun create_bucket(arg0: &mut BucketRegistry, arg1: u32, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: vector<u8>, arg15: u32, arg16: u32, arg17: vector<u8>, arg18: vector<vector<u8>>, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg20);
        let v2 = Bucket{
            id                : 0x2::object::new(arg20),
            marketplace_id    : 0x2::object::id_from_address(@0x0),
            owner             : v0,
            provider_id       : v0,
            bucket_id         : arg1,
            region            : arg3,
            country           : arg4,
            fb_bucket_id      : arg5,
            max_storage_gb    : arg8,
            max_egress_gb     : arg9,
            total_capacity_gb : arg8,
            used_capacity_gb  : 0,
            total_funds       : 0x2::coin::into_balance<0x2::sui::SUI>(arg19),
            reserved_funds    : 0x2::balance::zero<0x2::sui::SUI>(),
            available_funds   : 0x2::coin::value<0x2::sui::SUI>(&arg19),
            deal_ids          : 0x1::vector::empty<0x2::object::ID>(),
            status            : 0,
            locked            : false,
            lock_timestamp    : 0,
            liquidation_price : 0,
            created_at        : v1,
            updated_at        : v1,
        };
        let v3 = BucketMarketplace{
            id                    : 0x2::object::new(arg20),
            bucket_id             : 0x2::object::uid_to_inner(&v2.id),
            name                  : arg2,
            price_per_gb_storage  : arg6,
            price_per_gb_egress   : arg7,
            versioning_enabled    : arg10,
            encryption_at_rest    : arg11,
            encryption_in_transit : arg12,
            object_locking        : arg13,
            api_compatibility     : arg14,
            sla_avg_latency_ms    : arg15,
            sla_avg_uptime_pct    : arg16,
            access_scope          : arg17,
            tags                  : arg18,
        };
        v2.marketplace_id = 0x2::object::uid_to_inner(&v3.id);
        let v4 = 0x2::object::uid_to_inner(&v2.id);
        let v5 = BucketCreated{
            bucket_id : v4,
            owner     : v0,
            name      : arg2,
            timestamp : v1,
        };
        0x2::event::emit<BucketCreated>(v5);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.buckets, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.buckets, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.buckets, v0), v4);
        arg0.total_buckets = arg0.total_buckets + 1;
        0x2::transfer::share_object<Bucket>(v2);
        0x2::transfer::share_object<BucketMarketplace>(v3);
    }

    public fun delete_bucket(arg0: &mut BucketRegistry, arg1: Bucket, arg2: BucketMarketplace, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 204);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg1.deal_ids), 202);
        assert!(arg1.status == 0, 200);
        let v0 = arg1.owner;
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        let Bucket {
            id                : v2,
            marketplace_id    : _,
            owner             : _,
            provider_id       : _,
            bucket_id         : _,
            region            : _,
            country           : _,
            fb_bucket_id      : _,
            max_storage_gb    : _,
            max_egress_gb     : _,
            total_capacity_gb : _,
            used_capacity_gb  : _,
            total_funds       : v14,
            reserved_funds    : v15,
            available_funds   : _,
            deal_ids          : _,
            status            : _,
            locked            : _,
            lock_timestamp    : _,
            liquidation_price : _,
            created_at        : _,
            updated_at        : _,
        } = arg1;
        let v24 = v15;
        let v25 = v14;
        0x2::balance::value<0x2::sui::SUI>(&v25);
        0x2::balance::value<0x2::sui::SUI>(&v24);
        0x2::balance::join<0x2::sui::SUI>(&mut v25, v24);
        if (0x2::balance::value<0x2::sui::SUI>(&v25) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v25, arg3), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v25);
        };
        let BucketMarketplace {
            id                    : v26,
            bucket_id             : _,
            name                  : _,
            price_per_gb_storage  : _,
            price_per_gb_egress   : _,
            versioning_enabled    : _,
            encryption_at_rest    : _,
            encryption_in_transit : _,
            object_locking        : _,
            api_compatibility     : _,
            sla_avg_latency_ms    : _,
            sla_avg_uptime_pct    : _,
            access_scope          : _,
            tags                  : _,
        } = arg2;
        0x2::object::delete(v26);
        0x2::object::delete(v2);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.buckets, v0)) {
            let v40 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.buckets, v0);
            let (v41, v42) = 0x1::vector::index_of<0x2::object::ID>(v40, &v1);
            if (v41) {
                0x1::vector::remove<0x2::object::ID>(v40, v42);
            };
        };
        arg0.total_buckets = arg0.total_buckets - 1;
        let v43 = BucketDeleted{
            bucket_id : v1,
            owner     : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BucketDeleted>(v43);
    }

    public fun get_available_funds(arg0: &Bucket) : u64 {
        arg0.available_funds
    }

    public fun get_capacity(arg0: &Bucket) : (u64, u64, u64) {
        (arg0.max_storage_gb, arg0.total_capacity_gb, arg0.used_capacity_gb)
    }

    public fun get_features(arg0: &BucketMarketplace) : (bool, bool, bool, bool) {
        (arg0.versioning_enabled, arg0.encryption_at_rest, arg0.encryption_in_transit, arg0.object_locking)
    }

    public fun get_pricing(arg0: &BucketMarketplace) : (u64, u64) {
        (arg0.price_per_gb_storage, arg0.price_per_gb_egress)
    }

    public fun get_sla_metrics(arg0: &BucketMarketplace) : (u32, u32) {
        (arg0.sla_avg_latency_ms, arg0.sla_avg_uptime_pct)
    }

    public fun get_status(arg0: &Bucket) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketRegistry{
            id            : 0x2::object::new(arg0),
            buckets       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_buckets : 0,
        };
        0x2::transfer::share_object<BucketRegistry>(v0);
    }

    public fun initiate_liquidation(arg0: &mut Bucket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 203);
        arg0.status = 4;
        arg0.liquidation_price = arg1;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun is_locked(arg0: &Bucket) : bool {
        arg0.locked
    }

    public fun lock_bucket(arg0: &mut Bucket, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 200);
        arg0.status = 3;
        arg0.locked = true;
        arg0.lock_timestamp = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = BucketLocked{
            bucket_id : 0x2::object::uid_to_inner(&arg0.id),
            reason    : arg1,
            timestamp : arg0.lock_timestamp,
        };
        0x2::event::emit<BucketLocked>(v0);
    }

    public fun release_funds(arg0: &mut Bucket, arg1: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_funds, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserved_funds, arg1));
        arg0.available_funds = arg0.available_funds + arg1;
    }

    public fun reserve_funds(arg0: &mut Bucket, arg1: u64) {
        assert!(arg0.status == 0, 200);
        assert!(arg0.available_funds >= arg1, 201);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserved_funds, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_funds, arg1));
        arg0.available_funds = arg0.available_funds - arg1;
    }

    public fun unlock_bucket(arg0: &mut Bucket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 204);
        assert!(arg0.status == 3, 200);
        arg0.status = 0;
        arg0.locked = false;
        arg0.lock_timestamp = 0;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    public fun update_bucket_conditions(arg0: &mut Bucket, arg1: &mut BucketMarketplace, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u32, arg11: u32, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg13) == arg0.owner, 204);
        assert!(arg0.status == 0, 200);
        arg0.max_storage_gb = arg2;
        arg0.max_egress_gb = arg3;
        arg0.total_capacity_gb = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg13);
        arg1.price_per_gb_storage = arg4;
        arg1.price_per_gb_egress = arg5;
        arg1.versioning_enabled = arg6;
        arg1.encryption_at_rest = arg7;
        arg1.encryption_in_transit = arg8;
        arg1.object_locking = arg9;
        arg1.sla_avg_latency_ms = arg10;
        arg1.sla_avg_uptime_pct = arg11;
        arg1.access_scope = arg12;
        let v0 = BucketUpdated{
            bucket_id : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg13),
        };
        0x2::event::emit<BucketUpdated>(v0);
    }

    public fun withdraw_funds(arg0: &mut Bucket, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 204);
        assert!(arg0.status == 0, 200);
        assert!(arg0.available_funds >= arg1, 201);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_funds, arg1, arg2), arg0.owner);
        arg0.available_funds = arg0.available_funds - arg1;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

