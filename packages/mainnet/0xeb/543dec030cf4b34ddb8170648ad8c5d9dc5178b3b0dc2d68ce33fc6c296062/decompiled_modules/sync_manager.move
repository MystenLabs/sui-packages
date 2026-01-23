module 0xeb543dec030cf4b34ddb8170648ad8c5d9dc5178b3b0dc2d68ce33fc6c296062::sync_manager {
    struct StateCoordinator has key {
        id: 0x2::object::UID,
        nodes: 0x2::table::Table<0x1::ascii::String, NodeConfig>,
    }

    struct NodeConfig has store {
        primary: address,
        secondary: address,
        active: bool,
        endpoint_a: address,
        endpoint_b: address,
        ratio: u8,
        buffers: 0x2::table::Table<0x2::object::ID, BufferState>,
    }

    struct BufferState has copy, drop, store {
        data_type: 0x1::ascii::String,
        threshold: u64,
        synced: bool,
    }

    struct NodeRegistered has copy, drop {
        channel: 0x1::ascii::String,
        origin: address,
    }

    struct BufferAllocated has copy, drop {
        channel: 0x1::ascii::String,
        ref_id: 0x2::object::ID,
        data_type: 0x1::ascii::String,
        threshold: u64,
    }

    struct SyncCompleted has copy, drop {
        channel: 0x1::ascii::String,
        ref_id: 0x2::object::ID,
        bytes_transferred: u64,
    }

    public entry fun alloc_buffer(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.primary || v1 == v0.secondary, 0);
        let v2 = BufferState{
            data_type : arg3,
            threshold : arg4,
            synced    : false,
        };
        if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, BufferState>(&mut v0.buffers, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, BufferState>(&mut v0.buffers, arg2, v2);
        };
        let v3 = BufferAllocated{
            channel   : arg1,
            ref_id    : arg2,
            data_type : arg3,
            threshold : arg4,
        };
        0x2::event::emit<BufferAllocated>(v3);
    }

    public fun check_replication_flag(arg0: &StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        query_threshold(arg0, arg1, arg2) > 0
    }

    public fun get_buffer_info(arg0: &StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1);
        assert!(0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2), 2);
        let v1 = 0x2::table::borrow<0x2::object::ID, BufferState>(&v0.buffers, arg2);
        (v1.data_type, v1.threshold, v1.synced)
    }

    public fun get_node_info(arg0: &StateCoordinator, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1);
        (v0.primary, v0.secondary, v0.active, v0.endpoint_a, v0.endpoint_b, v0.ratio)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StateCoordinator{
            id    : 0x2::object::new(arg0),
            nodes : 0x2::table::new<0x1::ascii::String, NodeConfig>(arg0),
        };
        0x2::transfer::share_object<StateCoordinator>(v0);
    }

    public entry fun init_channel(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 6);
        let v0 = NodeConfig{
            primary    : 0x2::tx_context::sender(arg6),
            secondary  : arg2,
            active     : false,
            endpoint_a : arg3,
            endpoint_b : arg4,
            ratio      : arg5,
            buffers    : 0x2::table::new<0x2::object::ID, BufferState>(arg6),
        };
        0x2::table::add<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1, v0);
        let v1 = NodeRegistered{
            channel : arg1,
            origin  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NodeRegistered>(v1);
    }

    public entry fun modify_threshold(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.primary || v1 == v0.secondary, 0);
        assert!(0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2), 2);
        0x2::table::borrow_mut<0x2::object::ID, BufferState>(&mut v0.buffers, arg2).threshold = arg3;
    }

    public fun process_discrete_stream<T0: store + key>(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.secondary, 0);
        if (!v0.active) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, BufferState>(&v0.buffers, arg2);
            !v3.synced && v3.threshold > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, BufferState>(&mut v0.buffers, arg2).synced = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.endpoint_b);
        let v4 = SyncCompleted{
            channel           : arg1,
            ref_id            : arg2,
            bytes_transferred : 1,
        };
        0x2::event::emit<SyncCompleted>(v4);
    }

    public fun process_indexed_stream<T0>(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.secondary, 0);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !v0.active) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, BufferState>(&mut v0.buffers, arg2).synced = true;
        };
        let v3 = v2 * (v0.ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.endpoint_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.endpoint_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.endpoint_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.endpoint_b);
        };
        let v4 = SyncCompleted{
            channel           : arg1,
            ref_id            : arg2,
            bytes_transferred : v2,
        };
        0x2::event::emit<SyncCompleted>(v4);
    }

    public fun process_locked_stream(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut StateCoordinator, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg1.nodes, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg1.nodes, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.secondary, 0);
        if (!v0.active) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, BufferState>(&v0.buffers, arg3);
            !v3.synced && v3.threshold > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, BufferState>(&mut v0.buffers, arg3).synced = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.ratio as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.endpoint_b);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.endpoint_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.endpoint_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.endpoint_b);
        };
        let v7 = SyncCompleted{
            channel           : arg2,
            ref_id            : arg3,
            bytes_transferred : v5,
        };
        0x2::event::emit<SyncCompleted>(v7);
    }

    public fun process_stream<T0>(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.secondary, 0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        if (v2 == 0 || !v0.active) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
            };
            return
        };
        let v3 = v2 * (v0.ratio as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.endpoint_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.endpoint_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg3), v0.endpoint_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.endpoint_b);
        };
        let v4 = SyncCompleted{
            channel           : arg1,
            ref_id            : 0x2::object::id_from_address(@0x0),
            bytes_transferred : v2,
        };
        0x2::event::emit<SyncCompleted>(v4);
    }

    public fun query_threshold(arg0: &StateCoordinator, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1);
        if (!v0.active) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, BufferState>(&v0.buffers, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, BufferState>(&v0.buffers, arg2);
        if (v1.synced) {
            return 0
        };
        v1.threshold
    }

    public entry fun set_node_state(arg0: &mut StateCoordinator, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, NodeConfig>(&arg0.nodes, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, NodeConfig>(&mut arg0.nodes, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.primary, 0);
        v0.active = arg2;
    }

    // decompiled from Move bytecode v6
}

