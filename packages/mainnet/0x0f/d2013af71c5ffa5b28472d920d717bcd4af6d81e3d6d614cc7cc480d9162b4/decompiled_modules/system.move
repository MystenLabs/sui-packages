module 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system {
    struct System has key {
        id: 0x2::object::UID,
        version: u64,
        package_id: 0x2::object::ID,
        new_package_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun add_per_epoch_subsidies(arg0: &mut System, arg1: vector<0x2::balance::Balance<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::add_per_epoch_subsidies(inner_mut(arg0), arg1);
    }

    public fun add_subsidy(arg0: &mut System, arg1: 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg2: u32) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::add_subsidy(inner_mut(arg0), arg1, arg2);
    }

    public(friend) fun advance_epoch(arg0: &mut System, arg1: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::bls_aggregate::BlsCommittee, arg2: &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::epoch_parameters::EpochParams) : 0x2::vec_map::VecMap<0x2::object::ID, 0x2::balance::Balance<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>> {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::advance_epoch(inner_mut(arg0), arg1, arg2)
    }

    public fun burn_expired_pooled_blob(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u256) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::burn_expired_pooled_blob(inner(arg0), arg1, arg2);
    }

    public fun certify_blob(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::certify_blob(inner(arg0), arg1, arg2, arg3, arg4);
    }

    public fun certify_event_blob(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_node::StorageNodeCap, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: u64, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::certify_event_blob(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun certify_pooled_blob(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::certify_pooled_blob(inner(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun create_empty(arg0: u32, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = System{
            id             : 0x2::object::new(arg2),
            version        : 4,
            package_id     : arg1,
            new_package_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_field::add<u64, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1>(&mut v0.id, 4, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::create_empty(arg0, arg2));
        0x2::transfer::share_object<System>(v0);
    }

    public fun create_storage_pool(arg0: &mut System, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::create_storage_pool(inner_mut(arg0), arg1, arg2, arg3, arg4)
    }

    public fun create_storage_pool_with_storage(arg0: &System, arg1: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage, arg2: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::create_storage_pool_with_storage(inner(arg0), arg1, arg2)
    }

    public fun decrease_storage_pool_capacity_by_size(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage {
        let v0 = 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::decrease_storage_pool_capacity_by_size(inner(arg0), arg1, arg2, arg3);
        assert!(0x1::option::is_some<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage>(&v0), 2);
        0x1::option::destroy_some<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage>(v0)
    }

    public fun decrease_storage_pool_unused_capacity_by_percent(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage {
        let v0 = 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::decrease_storage_pool_unused_capacity_by_percent(inner(arg0), arg1, arg2, arg3);
        assert!(0x1::option::is_some<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage>(&v0), 2);
        0x1::option::destroy_some<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage>(v0)
    }

    public fun delete_blob(arg0: &System, arg1: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::delete_blob(inner(arg0), arg1)
    }

    public fun delete_deny_listed_blob(arg0: &System, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::delete_deny_listed_blob(inner(arg0), arg1, arg2, arg3);
    }

    public fun delete_pooled_blob(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u256) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::delete_pooled_blob(inner(arg0), arg1, arg2);
    }

    public fun epoch(arg0: &System) : u32 {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::epoch(inner(arg0))
    }

    public fun extend_blob(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob, arg2: u32, arg3: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::extend_blob(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun extend_blob_with_resource(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob, arg2: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::extend_blob_with_resource(inner(arg0), arg1, arg2);
    }

    public fun extend_storage_pool(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u32, arg3: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::extend_storage_pool(inner_mut(arg0), arg1, arg2, arg3);
    }

    public(friend) fun extract_burn_balance(arg0: &mut System) : 0x2::balance::Balance<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL> {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::extract_burn_balance(inner_mut(arg0))
    }

    public fun future_accounting(arg0: &System) : &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_accounting::FutureAccountingRingBuffer {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::future_accounting(inner(arg0))
    }

    public fun increase_storage_pool_capacity(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u64, arg3: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::increase_storage_pool_capacity(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun increase_storage_pool_capacity_with_storage(arg0: &System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::increase_storage_pool_capacity_with_storage(inner(arg0), arg1, arg2);
    }

    public(friend) fun inner(arg0: &System) : &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1 {
        assert!(arg0.version == 4, 1);
        0x2::dynamic_field::borrow<u64, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1>(&arg0.id, 4)
    }

    fun inner_mut(arg0: &mut System) : &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1 {
        assert!(arg0.version == 4, 1);
        0x2::dynamic_field::borrow_mut<u64, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1>(&mut arg0.id, 4)
    }

    public fun invalidate_blob_id(arg0: &System, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : u256 {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::invalidate_blob_id(inner(arg0), arg1, arg2, arg3)
    }

    public(friend) fun migrate(arg0: &mut System) {
        assert!(arg0.version < 4, 0);
        assert!(4 == 4, 0);
        0x2::dynamic_field::add<u64, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1>(&mut arg0.id, 4, 0x2::dynamic_field::remove<u64, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::SystemStateInnerV1>(&mut arg0.id, arg0.version));
        arg0.version = 4;
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 0);
        arg0.package_id = 0x1::option::extract<0x2::object::ID>(&mut arg0.new_package_id);
    }

    public fun n_shards(arg0: &System) : u16 {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::n_shards(inner(arg0))
    }

    public(friend) fun package_id(arg0: &System) : 0x2::object::ID {
        arg0.package_id
    }

    public fun register_blob(arg0: &mut System, arg1: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: bool, arg7: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::register_blob(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun register_deny_list_update(arg0: &mut System, arg1: &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_node::StorageNodeCap, arg2: u256, arg3: u64) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::register_deny_list_update(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun register_pooled_blob(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_pool::StoragePool, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: bool, arg7: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::register_pooled_blob(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun reserve_space(arg0: &mut System, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::reserve_space(inner_mut(arg0), arg1, arg2, arg3, arg4)
    }

    public fun reserve_space_for_epochs(arg0: &mut System, arg1: u64, arg2: u32, arg3: u32, arg4: &mut 0x2::coin::Coin<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_resource::Storage {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::reserve_space_for_epochs(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun set_new_package_id(arg0: &mut System, arg1: 0x2::object::ID) {
        arg0.new_package_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_storage_price(arg0: &mut System, arg1: u64) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::set_storage_price(inner_mut(arg0), arg1);
    }

    public(friend) fun set_write_price(arg0: &mut System, arg1: u64) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::set_write_price(inner_mut(arg0), arg1);
    }

    public fun total_capacity_size(arg0: &System) : u64 {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::total_capacity_size(inner(arg0))
    }

    public fun update_deny_list(arg0: &mut System, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_node::StorageNodeCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::update_deny_list(inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_protocol_version(arg0: &mut System, arg1: &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::storage_node::StorageNodeCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::update_protocol_version(inner(arg0), arg1, arg2, arg3, arg4);
    }

    public fun used_capacity_size(arg0: &System) : u64 {
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::system_state_inner::used_capacity_size(inner(arg0))
    }

    public fun version(arg0: &System) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

