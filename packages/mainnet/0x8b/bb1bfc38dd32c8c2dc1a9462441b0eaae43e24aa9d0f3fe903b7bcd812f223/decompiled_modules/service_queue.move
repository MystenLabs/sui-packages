module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue {
    struct ServiceQueue<phantom T0> has key {
        id: 0x2::object::UID,
        authority: address,
        node_timeout: u64,
        max_size: u64,
        mr_enclaves: vector<vector<u8>>,
        max_quote_verification_age: u64,
        allow_authority_override_after: u64,
        require_authority_heartbeat_permission: bool,
        require_usage_permissions: bool,
        verifier_queue_addr: address,
        enable_content_hash: bool,
        reward: u64,
        curr_idx: u64,
        gc_idx: u64,
        node_idx: u64,
        last_hb: u64,
        data: 0x2::table_vec::TableVec<address>,
        heartbeats: 0x2::table::Table<address, u64>,
        permissions: 0x2::table::Table<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>,
        escrows: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        version: u64,
    }

    public(friend) fun push_back<T0>(arg0: &mut ServiceQueue<T0>, arg1: address, arg2: u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (0x2::table::contains<address, u64>(&arg0.heartbeats, arg1)) {
            0x2::table_vec::push_back<address>(&mut arg0.data, arg1);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.heartbeats, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.heartbeats, arg1, arg2);
        };
        arg0.last_hb = arg2;
    }

    public fun permission<T0>(arg0: &ServiceQueue<T0>, arg1: address) : &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission {
        0x2::table::borrow<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&arg0.permissions, arg1)
    }

    public(friend) fun add_mr_enclave<T0>(arg0: &mut ServiceQueue<T0>, arg1: vector<u8>) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x1::vector::push_back<vector<u8>>(&mut arg0.mr_enclaves, arg1);
    }

    public fun allow_authority_override_after<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.allow_authority_override_after
    }

    public fun authority<T0>(arg0: &ServiceQueue<T0>) : address {
        arg0.authority
    }

    public fun data_len<T0>(arg0: &ServiceQueue<T0>) : u64 {
        0x2::table_vec::length<address>(&arg0.data)
    }

    public fun enable_content_hash<T0>(arg0: &ServiceQueue<T0>) : bool {
        arg0.enable_content_hash
    }

    public fun escrow_balance<T0>(arg0: &ServiceQueue<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.escrows, arg1)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.escrows, arg1))
        }
    }

    public(friend) fun escrow_deposit<T0>(arg0: &mut ServiceQueue<T0>, arg1: address, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.escrows, arg1)) {
            let v0 = 0x2::balance::zero<T0>();
            0x2::coin::put<T0>(&mut v0, arg2);
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.escrows, arg1, v0);
        } else {
            0x2::coin::put<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.escrows, arg1), arg2);
        };
    }

    public(friend) fun escrow_withdraw<T0>(arg0: &mut ServiceQueue<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::coin::take<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.escrows, arg1), arg2, arg3)
    }

    public(friend) fun garbage_collect<T0>(arg0: &mut ServiceQueue<T0>, arg1: u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::table::remove<address, u64>(&mut arg0.heartbeats, *0x2::table_vec::borrow<address>(&arg0.data, arg1));
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::swap_remove<address>(&mut arg0.data, arg1);
        let v0 = 0x2::table_vec::length<address>(&arg0.data);
        arg0.curr_idx = arg0.curr_idx % v0;
        arg0.gc_idx = arg0.gc_idx % v0;
    }

    public fun has<T0>(arg0: &ServiceQueue<T0>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<address>(&arg0.data)) {
            if (0x2::table_vec::borrow<address>(&arg0.data, v0) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun has_authority<T0>(arg0: &ServiceQueue<T0>, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public fun has_mr_enclave<T0>(arg0: &ServiceQueue<T0>, arg1: vector<u8>) : bool {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.mr_enclaves)) {
            if (0x1::vector::borrow<vector<u8>>(&arg0.mr_enclaves, v0) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun increment_node_idx<T0>(arg0: &mut ServiceQueue<T0>) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.node_idx = (arg0.node_idx + 1) % 0x2::table_vec::length<address>(&arg0.data);
    }

    public fun is_expired<T0>(arg0: &ServiceQueue<T0>, arg1: address, arg2: u64) : bool {
        arg2 - *0x2::table::borrow<address, u64>(&arg0.heartbeats, arg1) > arg0.node_timeout
    }

    public fun last_heartbeat<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.last_hb
    }

    public fun max_quote_verification_age<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.max_quote_verification_age
    }

    public fun max_size<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.max_size
    }

    entry fun migrate<T0>(arg0: &mut ServiceQueue<T0>, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) {
        assert!(arg0.version < 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version();
    }

    public(friend) fun next<T0>(arg0: &mut ServiceQueue<T0>) : (bool, address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (0x2::table_vec::length<address>(&arg0.data) == 0) {
            return (false, @0x0)
        };
        arg0.curr_idx = arg0.curr_idx + 1;
        arg0.curr_idx = arg0.curr_idx % 0x2::table_vec::length<address>(&arg0.data);
        (true, *0x2::table_vec::borrow<address>(&arg0.data, arg0.curr_idx))
    }

    public(friend) fun next_garbage_collection_node<T0>(arg0: &mut ServiceQueue<T0>) : (address, u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (0x2::table_vec::length<address>(&arg0.data) <= 1) {
            return (@0x0, 0)
        };
        arg0.gc_idx = arg0.gc_idx + 1;
        arg0.gc_idx = arg0.gc_idx % 0x2::table_vec::length<address>(&arg0.data);
        (*0x2::table_vec::borrow<address>(&arg0.data, arg0.gc_idx), arg0.gc_idx)
    }

    public fun node_at_idx<T0>(arg0: &ServiceQueue<T0>, arg1: u64) : address {
        *0x2::table_vec::borrow<address>(&arg0.data, arg1)
    }

    public fun node_idx<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.node_idx
    }

    public(friend) fun permission_create<T0>(arg0: &mut ServiceQueue<T0>, arg1: 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::table::add<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&mut arg0.permissions, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key_from_permission(&arg1), arg1);
    }

    public(friend) fun permission_mut<T0>(arg0: &mut ServiceQueue<T0>, arg1: address) : &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::table::borrow_mut<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&mut arg0.permissions, arg1)
    }

    public(friend) fun remove_mr_enclave<T0>(arg0: &mut ServiceQueue<T0>, arg1: vector<u8>) : bool {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.mr_enclaves)) {
            if (0x1::vector::borrow<vector<u8>>(&arg0.mr_enclaves, v0) == &arg1) {
                0x1::vector::swap_remove<vector<u8>>(&mut arg0.mr_enclaves, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun require_authority_heartbeat_permission<T0>(arg0: &ServiceQueue<T0>) : bool {
        arg0.require_authority_heartbeat_permission
    }

    public fun require_usage_permissions<T0>(arg0: &ServiceQueue<T0>) : bool {
        arg0.require_usage_permissions
    }

    public fun reward<T0>(arg0: &ServiceQueue<T0>) : u64 {
        arg0.reward
    }

    public fun service_queue_address<T0>(arg0: &ServiceQueue<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun service_queue_create<T0>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: address, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : ServiceQueue<T0> {
        let v0 = ServiceQueue<T0>{
            id                                     : 0x2::object::new(arg10),
            authority                              : arg0,
            node_timeout                           : arg2,
            max_size                               : arg3,
            mr_enclaves                            : 0x1::vector::empty<vector<u8>>(),
            max_quote_verification_age             : arg4,
            allow_authority_override_after         : arg5,
            require_authority_heartbeat_permission : arg6,
            require_usage_permissions              : arg7,
            verifier_queue_addr                    : arg8,
            enable_content_hash                    : arg9,
            reward                                 : arg1,
            curr_idx                               : 0,
            gc_idx                                 : 0,
            node_idx                               : 0,
            last_hb                                : 0,
            data                                   : 0x2::table_vec::empty<address>(arg10),
            heartbeats                             : 0x2::table::new<address, u64>(arg10),
            permissions                            : 0x2::table::new<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(arg10),
            escrows                                : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg10),
            version                                : 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(),
        };
        let v1 = if (arg8 == @0x0) {
            0x2::tx_context::sender(arg10)
        } else {
            arg8
        };
        v0.verifier_queue_addr = v1;
        v0
    }

    public(friend) fun set_configs<T0>(arg0: &mut ServiceQueue<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.authority = arg1;
        arg0.reward = arg2;
        arg0.node_timeout = arg3;
        arg0.max_size = arg4;
        arg0.max_quote_verification_age = arg5;
        arg0.allow_authority_override_after = arg6;
        arg0.require_authority_heartbeat_permission = arg7;
        arg0.require_usage_permissions = arg8;
        arg0.verifier_queue_addr = arg9;
    }

    public(friend) fun share_service_queue<T0>(arg0: ServiceQueue<T0>) {
        0x2::transfer::share_object<ServiceQueue<T0>>(arg0);
    }

    public fun verifier_queue_addr<T0>(arg0: &ServiceQueue<T0>) : address {
        arg0.verifier_queue_addr
    }

    // decompiled from Move bytecode v6
}

