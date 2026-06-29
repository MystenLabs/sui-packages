module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        mms: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>,
        pools: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolInfo>,
    }

    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        mm_id: 0x2::object::ID,
        pool_type: u8,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public(friend) fun add_mm(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.mms, arg1), 2);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut arg0.mms, arg1, true);
    }

    public(friend) fun add_pool(arg0: &mut Registry, arg1: PoolInfo) {
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg1.pool_id), 4);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg1.pool_id, arg1);
    }

    public fun contains_mm(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.mms, arg1)
    }

    public fun contains_pool(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg1)
    }

    public fun get_pool_info(arg0: &Registry, arg1: 0x2::object::ID) : &PoolInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg1), 3);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PoolInfo>(&arg0.pools, arg1)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg1),
            mms   : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg1),
            pools : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolInfo>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun mm_count(arg0: &Registry) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, bool>(&arg0.mms)
    }

    public fun new_pool_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) : PoolInfo {
        PoolInfo{
            pool_id   : arg0,
            mm_id     : arg1,
            pool_type : arg2,
        }
    }

    public fun pool_count(arg0: &Registry) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, PoolInfo>(&arg0.pools)
    }

    public fun pool_info_mm_id(arg0: &PoolInfo) : 0x2::object::ID {
        arg0.mm_id
    }

    public fun pool_info_pool_id(arg0: &PoolInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_info_pool_type(arg0: &PoolInfo) : u8 {
        arg0.pool_type
    }

    public fun pool_type_orderbook() : u8 {
        0
    }

    public(friend) fun remove_mm(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.mms, arg1), 1);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(&mut arg0.mms, arg1);
    }

    public(friend) fun remove_pool(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg1), 3);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg1);
    }

    // decompiled from Move bytecode v7
}

