module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation_access {
    struct ObligationAccessStore has store, key {
        id: 0x2::object::UID,
        lock_keys: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        reward_keys: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun add_lock_key<T0: drop>(arg0: &mut ObligationAccessStore) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.lock_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_store_key_exists());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.lock_keys, v0);
    }

    public(friend) fun add_reward_key<T0: drop>(arg0: &mut ObligationAccessStore) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_store_key_exists());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_keys, v0);
    }

    public fun assert_lock_key_in_store<T0: drop>(arg0: &ObligationAccessStore, arg1: T0) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.lock_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_lock_key_not_in_store());
    }

    public fun assert_reward_key_in_store<T0: drop>(arg0: &ObligationAccessStore, arg1: T0) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_reward_key_not_in_store());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationAccessStore{
            id          : 0x2::object::new(arg0),
            lock_keys   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            reward_keys : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<ObligationAccessStore>(v0);
    }

    public(friend) fun remove_lock_key<T0: drop>(arg0: &mut ObligationAccessStore) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.lock_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_store_key_not_found());
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.lock_keys, &v0);
    }

    public(friend) fun remove_reward_key<T0: drop>(arg0: &mut ObligationAccessStore) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_keys, &v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_access_store_key_not_found());
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.reward_keys, &v0);
    }

    // decompiled from Move bytecode v6
}

