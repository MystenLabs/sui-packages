module 0xf1d628f9c99e3469e00ff537fc8f8b320ced0ab03d456584f1730e94b445b91f::pool_store {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolStore has key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        pools: vector<PoolConfig>,
    }

    struct PoolConfig has store {
        pool: address,
        name: vector<u8>,
        coin_a: vector<u8>,
        coin_b: vector<u8>,
        fee_rate: u64,
    }

    public fun add_pool(arg0: &mut PoolStore, arg1: PoolConfig) {
        0x1::vector::push_back<PoolConfig>(&mut arg0.pools, arg1);
    }

    public fun get_pools(arg0: &PoolStore) : &vector<PoolConfig> {
        &arg0.pools
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PoolStore{
            id    : 0x2::object::new(arg0),
            admin : 0x2::object::id<AdminCap>(&v0),
            pools : 0x1::vector::empty<PoolConfig>(),
        };
        0x2::transfer::share_object<PoolStore>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

