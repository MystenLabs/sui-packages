module 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking {
    struct Staking has key {
        id: 0x2::object::UID,
        version: u64,
        package_id: 0x2::object::ID,
        new_package_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun node_metadata(arg0: &Staking, arg1: 0x2::object::ID) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::node_metadata::NodeMetadata {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::node_metadata(inner(arg0), arg1)
    }

    public fun calculate_rewards(arg0: &Staking, arg1: 0x2::object::ID, arg2: u64, arg3: u32, arg4: u32) : u64 {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::calculate_rewards(inner(arg0), arg1, arg2, arg3, arg4)
    }

    public(friend) fun check_governance_authorization(arg0: &Staking, arg1: 0x2::object::ID, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authenticated) : bool {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::check_governance_authorization(inner(arg0), arg1, arg2)
    }

    public fun collect_commission(arg0: &mut Staking, arg1: 0x2::object::ID, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authenticated, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::collect_commission(inner_mut(arg0), arg1, arg2), arg3)
    }

    public fun compute_next_committee(arg0: &Staking) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::committee::Committee {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::compute_next_committee(inner(arg0))
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: u16, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Staking{
            id             : 0x2::object::new(arg5),
            version        : 1,
            package_id     : arg3,
            new_package_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_field::add<u64, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1>(&mut v0.id, 1, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::new(arg0, arg1, arg2, arg4, arg5));
        0x2::transfer::share_object<Staking>(v0);
    }

    public fun epoch(arg0: &Staking) : u32 {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::epoch(inner(arg0))
    }

    public fun epoch_sync_done(arg0: &mut Staking, arg1: &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: u32, arg3: &0x2::clock::Clock) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::epoch_sync_done(inner_mut(arg0), arg1, arg2, arg3);
    }

    public(friend) fun get_current_node_weight(arg0: &Staking, arg1: 0x2::object::ID) : u16 {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::get_current_node_weight(inner(arg0), arg1)
    }

    public fun initiate_epoch_change(arg0: &mut Staking, arg1: &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::system::System, arg2: &0x2::clock::Clock) {
        let v0 = inner_mut(arg0);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::initiate_epoch_change(v0, arg2, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::system::advance_epoch(arg1, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::next_bls_committee(v0), 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::next_epoch_params(v0)));
    }

    fun inner(arg0: &Staking) : &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1 {
        assert!(arg0.version == 1, 1);
        0x2::dynamic_field::borrow<u64, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1>(&arg0.id, 1)
    }

    fun inner_mut(arg0: &mut Staking) : &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1 {
        assert!(arg0.version == 1, 1);
        0x2::dynamic_field::borrow_mut<u64, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1>(&mut arg0.id, 1)
    }

    public(friend) fun is_quorum(arg0: &Staking, arg1: u16) : bool {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::is_quorum(inner(arg0), arg1)
    }

    public(friend) fun migrate(arg0: &mut Staking) {
        assert!(arg0.version < 1, 0);
        0x2::dynamic_field::add<u64, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1>(&mut arg0.id, 1, 0x2::dynamic_field::remove<u64, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::StakingInnerV1>(&mut arg0.id, arg0.version));
        arg0.version = 1;
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 0);
        arg0.package_id = 0x1::option::extract<0x2::object::ID>(&mut arg0.new_package_id);
    }

    public(friend) fun package_id(arg0: &Staking) : 0x2::object::ID {
        arg0.package_id
    }

    public fun register_candidate(arg0: &mut Staking, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::node_metadata::NodeMetadata, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u16, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap {
        let v0 = inner_mut(arg0);
        let v1 = 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::create_pool(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::new_cap(v1, arg11);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_commission_receiver(v0, v1, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::authenticate_sender(arg11), 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::authorized_object(0x2::object::id<0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap>(&v2)));
        v2
    }

    public fun request_withdraw_stake(arg0: &mut Staking, arg1: &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staked_wal::StakedWal, arg2: &mut 0x2::tx_context::TxContext) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::request_withdraw_stake(inner_mut(arg0), arg1, arg2);
    }

    public fun set_commission_receiver(arg0: &mut Staking, arg1: 0x2::object::ID, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authenticated, arg3: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authorized) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_commission_receiver(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_governance_authorized(arg0: &mut Staking, arg1: 0x2::object::ID, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authenticated, arg3: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::auth::Authorized) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_governance_authorized(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_name(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: 0x1::string::String) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_name(inner_mut(arg0), arg1, arg2);
    }

    public fun set_network_address(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: 0x1::string::String) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_network_address(inner_mut(arg0), arg1, arg2);
    }

    public fun set_network_public_key(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: vector<u8>) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_network_public_key(inner_mut(arg0), arg1, arg2);
    }

    public(friend) fun set_new_package_id(arg0: &mut Staking, arg1: 0x2::object::ID) {
        arg0.new_package_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_next_commission(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: u16) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_next_commission(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_public_key(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_next_public_key(inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    public fun set_node_capacity_vote(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: u64) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_node_capacity_vote(inner_mut(arg0), arg1, arg2);
    }

    public fun set_node_metadata(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::node_metadata::NodeMetadata) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_node_metadata(inner_mut(arg0), arg1, arg2);
    }

    public fun set_storage_price_vote(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: u64) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_storage_price_vote(inner_mut(arg0), arg1, arg2);
    }

    public fun set_write_price_vote(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap, arg2: u64) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::set_write_price_vote(inner_mut(arg0), arg1, arg2);
    }

    public fun stake_with_pool(arg0: &mut Staking, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staked_wal::StakedWal {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::stake_with_pool(inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun try_join_active_set(arg0: &mut Staking, arg1: &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_node::StorageNodeCap) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::try_join_active_set(inner_mut(arg0), arg1);
    }

    public(friend) fun version(arg0: &Staking) : u64 {
        arg0.version
    }

    public fun voting_end(arg0: &mut Staking, arg1: &0x2::clock::Clock) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::voting_end(inner_mut(arg0), arg1);
    }

    public fun withdraw_stake(arg0: &mut Staking, arg1: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staked_wal::StakedWal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::staking_inner::withdraw_stake(inner_mut(arg0), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

