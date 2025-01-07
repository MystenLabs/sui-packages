module 0x1cd0352f639f06f503c7d144494565020bd733b98709b0427a67872a2b1bfcef::stake_pool {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakePool<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        pool_size: u64,
        stake_pool: 0x2::object_table::ObjectTable<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>,
    }

    struct PoolCreatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct UserStakeEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        updated_pool_size: u64,
        user: address,
        staked_object_id: 0x2::object::ID,
    }

    struct UserUnstakeEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        updated_pool_size: u64,
        user: address,
        unstaked_object_id: 0x2::object::ID,
    }

    public fun create_pool<T0: store + key>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakePool<T0>>(create_pool_<T0>(arg1));
    }

    fun create_pool_<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : StakePool<T0> {
        let v0 = StakePool<T0>{
            id         : 0x2::object::new(arg0),
            pool_size  : 0,
            stake_pool : 0x2::object_table::new<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(arg0),
        };
        let v1 = PoolCreatedEvent{pool_id: 0x2::object::id<StakePool<T0>>(&v0)};
        0x2::event::emit<PoolCreatedEvent>(v1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun stake<T0: store + key>(arg0: &mut StakePool<T0>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        stake_<T0>(arg0, arg1, arg2);
    }

    fun stake_<T0: store + key>(arg0: &mut StakePool<T0>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<T0>(&arg1);
        if (0x2::object_table::contains<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(&arg0.stake_pool, v0)) {
            0x2::object_table::add<0x2::object::ID, T0>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(&mut arg0.stake_pool, v0), v1, arg1);
        } else {
            let v2 = 0x2::object_table::new<0x2::object::ID, T0>(arg2);
            0x2::object_table::add<0x2::object::ID, T0>(&mut v2, v1, arg1);
            0x2::object_table::add<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(&mut arg0.stake_pool, v0, v2);
        };
        arg0.pool_size = arg0.pool_size + 1;
        let v3 = UserStakeEvent{
            pool_id           : 0x2::object::id<StakePool<T0>>(arg0),
            updated_pool_size : arg0.pool_size,
            user              : v0,
            staked_object_id  : v1,
        };
        0x2::event::emit<UserStakeEvent>(v3);
    }

    public fun unstake<T0: store + key>(arg0: &mut StakePool<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake_<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    fun unstake_<T0: store + key>(arg0: &mut StakePool<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(&arg0.stake_pool, v0), 0);
        let v1 = 0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x2::object::ID, T0>>(&mut arg0.stake_pool, v0);
        assert!(0x2::object_table::contains<0x2::object::ID, T0>(v1, arg1), 0);
        let v2 = 0x2::object_table::remove<0x2::object::ID, T0>(v1, arg1);
        arg0.pool_size = arg0.pool_size - 1;
        let v3 = UserUnstakeEvent{
            pool_id            : 0x2::object::id<StakePool<T0>>(arg0),
            updated_pool_size  : arg0.pool_size,
            user               : v0,
            unstaked_object_id : arg1,
        };
        0x2::event::emit<UserUnstakeEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

