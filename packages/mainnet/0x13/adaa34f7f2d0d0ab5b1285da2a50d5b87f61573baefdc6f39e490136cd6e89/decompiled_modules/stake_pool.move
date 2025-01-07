module 0x13adaa34f7f2d0d0ab5b1285da2a50d5b87f61573baefdc6f39e490136cd6e89::stake_pool {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakePool has store, key {
        id: 0x2::object::UID,
        pool_size: u64,
        user_staked_ids: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct PoolCreatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct UserStakeEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        updated_pool_size: u64,
        staked_object_id: 0x2::object::ID,
    }

    struct UserUnstakeEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        updated_pool_size: u64,
        unstaked_object_id: 0x2::object::ID,
    }

    public fun create_pool(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakePool>(create_pool_(arg1));
    }

    public fun create_pool_(arg0: &mut 0x2::tx_context::TxContext) : StakePool {
        let v0 = StakePool{
            id              : 0x2::object::new(arg0),
            pool_size       : 0,
            user_staked_ids : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
        };
        let v1 = PoolCreatedEvent{pool_id: 0x2::object::id<StakePool>(&v0)};
        0x2::event::emit<PoolCreatedEvent>(v1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun stake<T0: store + key>(arg0: &mut StakePool, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        stake_<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun stake_<T0: store + key>(arg0: &mut StakePool, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg1, arg2, &arg0.id, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_staked_ids, v0)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_staked_ids, v0), arg2);
        } else {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_staked_ids, v0, 0x2::vec_set::singleton<0x2::object::ID>(arg2));
        };
        arg0.pool_size = arg0.pool_size + 1;
        let v1 = UserStakeEvent{
            pool_id           : 0x2::object::id<StakePool>(arg0),
            user              : v0,
            updated_pool_size : arg0.pool_size,
            staked_object_id  : arg2,
        };
        0x2::event::emit<UserStakeEvent>(v1);
    }

    public fun unstake<T0: store + key>(arg0: &mut StakePool, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        unstake_<T0>(arg0, arg1, arg2, arg3);
    }

    fun unstake_<T0: store + key>(arg0: &mut StakePool, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_staked_ids, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_staked_ids, v0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v1, &arg2), 0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, arg2, &arg0.id);
        0x2::vec_set::remove<0x2::object::ID>(v1, &arg2);
        arg0.pool_size = arg0.pool_size - 1;
        let v2 = UserUnstakeEvent{
            pool_id            : 0x2::object::id<StakePool>(arg0),
            user               : v0,
            updated_pool_size  : arg0.pool_size,
            unstaked_object_id : arg2,
        };
        0x2::event::emit<UserUnstakeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

