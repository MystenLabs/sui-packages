module 0xf97f3dbcd0942b239f0ea84d93cc684a6154d1c39b6759c2dd65a38458ad176b::indexer {
    struct IndexCluster has key {
        id: 0x2::object::UID,
        pointers: 0x2::table::Table<0x1::ascii::String, IndexNode>,
        version: u8,
    }

    struct IndexNode has store {
        owner: address,
        curator: address,
        status: u8,
        root_store: address,
        shard_store: address,
        shard_ratio: u8,
        pointers: 0x2::table::Table<0x2::object::ID, RecordPointer>,
    }

    struct RecordPointer has copy, drop, store {
        record_type: 0x1::ascii::String,
        rank: u64,
        indexed: bool,
    }

    struct ClusterCreated has copy, drop {
        cluster_id: 0x1::ascii::String,
        owner: address,
    }

    struct PointerAdded has copy, drop {
        cluster_id: 0x1::ascii::String,
        pointer_id: 0x2::object::ID,
        record_type: 0x1::ascii::String,
        rank: u64,
    }

    struct SyncCompleted has copy, drop {
        cluster_id: 0x1::ascii::String,
        pointer_id: 0x2::object::ID,
        result_rank: u64,
    }

    public entry fun add_pointer(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.curator, 100);
        let v2 = RecordPointer{
            record_type : arg3,
            rank        : arg4,
            indexed     : false,
        };
        if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg2, v2);
        };
        let v3 = PointerAdded{
            cluster_id  : arg1,
            pointer_id  : arg2,
            record_type : arg3,
            rank        : arg4,
        };
        0x2::event::emit<PointerAdded>(v3);
    }

    public fun archive_node(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut IndexCluster, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg1.pointers, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg1.pointers, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.curator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, RecordPointer>(&v0.pointers, arg3);
            !v3.indexed && v3.rank > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg3).indexed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.shard_ratio as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.shard_store);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.root_store);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.root_store);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.shard_store);
        };
        let v7 = SyncCompleted{
            cluster_id  : arg2,
            pointer_id  : arg3,
            result_rank : v5,
        };
        0x2::event::emit<SyncCompleted>(v7);
    }

    public entry fun create_cluster(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = IndexNode{
            owner       : 0x2::tx_context::sender(arg6),
            curator     : arg2,
            status      : 0,
            root_store  : arg3,
            shard_store : arg4,
            shard_ratio : arg5,
            pointers    : 0x2::table::new<0x2::object::ID, RecordPointer>(arg6),
        };
        0x2::table::add<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1, v0);
        let v1 = ClusterCreated{
            cluster_id : arg1,
            owner      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ClusterCreated>(v1);
    }

    public fun get_cluster_info(arg0: &IndexCluster, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1);
        (v0.owner, v0.curator, v0.status & 1 != 0, v0.root_store, v0.shard_store, v0.shard_ratio)
    }

    public fun get_pointer_info(arg0: &IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1);
        assert!(0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, RecordPointer>(&v0.pointers, arg2);
        (v1.record_type, v1.rank, v1.indexed)
    }

    public fun get_pointer_rank(arg0: &IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, RecordPointer>(&v0.pointers, arg2);
        if (v1.indexed) {
            return 0
        };
        v1.rank
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IndexCluster{
            id       : 0x2::object::new(arg0),
            pointers : 0x2::table::new<0x1::ascii::String, IndexNode>(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<IndexCluster>(v0);
    }

    public entry fun publish_cluster(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun reindex_object<T0: store + key>(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.curator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, RecordPointer>(&v0.pointers, arg2);
            !v3.indexed && v3.rank > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg2).indexed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.root_store);
        let v4 = SyncCompleted{
            cluster_id  : arg1,
            pointer_id  : arg2,
            result_rank : 1,
        };
        0x2::event::emit<SyncCompleted>(v4);
    }

    public fun should_reindex(arg0: &IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_pointer_rank(arg0, arg1, arg2) > 0
    }

    public fun sync_batch<T0>(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.curator, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg2).indexed = true;
        };
        let v3 = v2 * (v0.shard_ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.shard_store);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.root_store);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.root_store);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.shard_store);
        };
        let v4 = SyncCompleted{
            cluster_id  : arg1,
            pointer_id  : arg2,
            result_rank : v2,
        };
        0x2::event::emit<SyncCompleted>(v4);
    }

    public entry fun update_rank(arg0: &mut IndexCluster, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, IndexNode>(&arg0.pointers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, IndexNode>(&mut arg0.pointers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.curator, 100);
        assert!(0x2::table::contains<0x2::object::ID, RecordPointer>(&v0.pointers, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, RecordPointer>(&mut v0.pointers, arg2).rank = arg3;
    }

    // decompiled from Move bytecode v6
}

