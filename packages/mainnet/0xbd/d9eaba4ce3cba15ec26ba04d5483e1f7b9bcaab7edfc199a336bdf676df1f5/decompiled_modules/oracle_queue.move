module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue {
    struct OracleQueue<phantom T0> has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        authority: address,
        reward: u64,
        unpermissioned_feeds_enabled: bool,
        oracle_timeout: u64,
        lock_lease_funding: bool,
        max_size: u64,
        created_at: u64,
        curr_idx: u64,
        gc_idx: u64,
        oracle_idx: u64,
        verification_queue_addr: address,
        allow_service_queue_heartbeats: bool,
        last_hb: u64,
        data: 0x2::table_vec::TableVec<address>,
        crank_feeds: 0x2::bag::Bag,
        heartbeats: 0x2::table::Table<address, u64>,
        permissions: 0x2::table::Table<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>,
        version: u64,
    }

    public(friend) fun push_back<T0>(arg0: &mut OracleQueue<T0>, arg1: address, arg2: u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (!0x2::table::contains<address, u64>(&arg0.heartbeats, arg1)) {
            0x2::table_vec::push_back<address>(&mut arg0.data, arg1);
            0x2::table::add<address, u64>(&mut arg0.heartbeats, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.heartbeats, arg1) = arg2;
        };
        arg0.last_hb = arg2;
    }

    public(friend) fun add_aggregator_to_crank<T0>(arg0: &mut OracleQueue<T0>, arg1: address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        assert!(!0x2::bag::contains<address>(&arg0.crank_feeds, arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        0x2::bag::add<address, bool>(&mut arg0.crank_feeds, arg1, true);
    }

    public fun allow_service_queue_heartbeats<T0>(arg0: &OracleQueue<T0>) : bool {
        arg0.allow_service_queue_heartbeats
    }

    public fun authority<T0>(arg0: &OracleQueue<T0>) : address {
        arg0.authority
    }

    public fun configs<T0>(arg0: &OracleQueue<T0>) : (address, u64, bool) {
        (arg0.authority, arg0.reward, arg0.unpermissioned_feeds_enabled)
    }

    public fun data_len<T0>(arg0: &OracleQueue<T0>) : u64 {
        0x2::table_vec::length<address>(&arg0.data)
    }

    public(friend) fun evict_aggregator<T0>(arg0: &mut OracleQueue<T0>, arg1: address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (0x2::bag::contains<address>(&arg0.crank_feeds, arg1)) {
            0x2::bag::remove<address, bool>(&mut arg0.crank_feeds, arg1);
        };
    }

    public(friend) fun garbage_collect<T0>(arg0: &mut OracleQueue<T0>, arg1: u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::swap_remove<address>(&mut arg0.data, arg1);
        0x2::table::remove<address, u64>(&mut arg0.heartbeats, *0x2::table_vec::borrow<address>(&arg0.data, arg1));
        let v0 = 0x2::table_vec::length<address>(&arg0.data);
        arg0.curr_idx = arg0.curr_idx % v0;
        arg0.gc_idx = arg0.gc_idx % v0;
    }

    public fun has_authority<T0>(arg0: &OracleQueue<T0>, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public(friend) fun increment_oracle_idx<T0>(arg0: &mut OracleQueue<T0>) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.oracle_idx = (arg0.oracle_idx + 1) % 0x2::table_vec::length<address>(&arg0.data);
    }

    public fun is_expired<T0>(arg0: &OracleQueue<T0>, arg1: address, arg2: u64) : bool {
        arg2 - *0x2::table::borrow<address, u64>(&arg0.heartbeats, arg1) > arg0.oracle_timeout
    }

    public fun lock_lease_funding<T0>(arg0: &OracleQueue<T0>) : bool {
        arg0.lock_lease_funding
    }

    public fun max_reward<T0>(arg0: &OracleQueue<T0>, arg1: u64) : u64 {
        arg0.reward * (arg1 + 1)
    }

    entry fun migrate<T0>(arg0: &mut OracleQueue<T0>, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) {
        assert!(arg0.version < 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version();
    }

    public(friend) fun next_garbage_collection_oracle<T0>(arg0: &mut OracleQueue<T0>) : (address, u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (0x2::table_vec::length<address>(&arg0.data) <= 1) {
            return (@0x0, 0)
        };
        arg0.gc_idx = arg0.gc_idx + 1;
        arg0.gc_idx = arg0.gc_idx % 0x2::table_vec::length<address>(&arg0.data);
        (*0x2::table_vec::borrow<address>(&arg0.data, arg0.gc_idx), arg0.gc_idx)
    }

    public fun oracle_at_idx<T0>(arg0: &OracleQueue<T0>, arg1: u64) : address {
        *0x2::table_vec::borrow<address>(&arg0.data, arg1)
    }

    public fun oracle_idx<T0>(arg0: &OracleQueue<T0>) : u64 {
        arg0.oracle_idx
    }

    public fun oracle_queue_address<T0>(arg0: &OracleQueue<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun oracle_queue_create<T0>(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : OracleQueue<T0> {
        OracleQueue<T0>{
            id                             : 0x2::object::new(arg10),
            name                           : arg1,
            authority                      : arg0,
            reward                         : arg3,
            unpermissioned_feeds_enabled   : arg4,
            oracle_timeout                 : arg2,
            lock_lease_funding             : arg5,
            max_size                       : arg6,
            created_at                     : arg7,
            curr_idx                       : 0,
            gc_idx                         : 0,
            oracle_idx                     : 0,
            verification_queue_addr        : arg8,
            allow_service_queue_heartbeats : arg9,
            last_hb                        : 0,
            data                           : 0x2::table_vec::empty<address>(arg10),
            crank_feeds                    : 0x2::bag::new(arg10),
            heartbeats                     : 0x2::table::new<address, u64>(arg10),
            permissions                    : 0x2::table::new<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(arg10),
            version                        : 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(),
        }
    }

    public fun oracle_timeout<T0>(arg0: &OracleQueue<T0>) : u64 {
        arg0.oracle_timeout
    }

    public fun permission<T0>(arg0: &OracleQueue<T0>, arg1: address) : &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission {
        0x2::table::borrow<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&arg0.permissions, arg1)
    }

    public(friend) fun permission_create<T0>(arg0: &mut OracleQueue<T0>, arg1: 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::table::add<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&mut arg0.permissions, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key_from_permission(&arg1), arg1);
    }

    public(friend) fun permission_mut<T0>(arg0: &mut OracleQueue<T0>, arg1: address) : &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x2::table::borrow_mut<address, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::Permission>(&mut arg0.permissions, arg1)
    }

    public fun reward<T0>(arg0: &OracleQueue<T0>) : u64 {
        arg0.reward
    }

    public(friend) fun set_configs<T0>(arg0: &mut OracleQueue<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: address, arg9: bool) {
        arg0.lock_lease_funding = arg6;
        arg0.max_size = arg7;
        arg0.name = arg2;
        arg0.unpermissioned_feeds_enabled = arg5;
        arg0.authority = arg1;
        arg0.oracle_timeout = arg3;
        arg0.reward = arg4;
        arg0.verification_queue_addr = arg8;
        arg0.allow_service_queue_heartbeats = arg9;
    }

    public(friend) fun share_oracle_queue<T0>(arg0: OracleQueue<T0>) {
        0x2::transfer::share_object<OracleQueue<T0>>(arg0);
    }

    public fun unpermissioned_feeds_enabled<T0>(arg0: &OracleQueue<T0>) : bool {
        arg0.unpermissioned_feeds_enabled
    }

    public fun verification_queue_addr<T0>(arg0: &OracleQueue<T0>) : address {
        arg0.verification_queue_addr
    }

    // decompiled from Move bytecode v6
}

