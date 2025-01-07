module 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::final {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct FinalPool has key {
        id: 0x2::object::UID,
        dev: address,
        openers: 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::BigVector<address>,
    }

    struct SinglePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_splitted: bool,
        main_pool: 0x2::balance::Balance<T0>,
    }

    struct LockedType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct LockedPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
    }

    public(friend) fun add_opener(arg0: &mut FinalPool, arg1: address) {
        0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::push_back<address>(&mut arg0.openers, arg1);
    }

    fun borrow_locked_pool_mut<T0>(arg0: &mut FinalPool, arg1: &mut 0x2::tx_context::TxContext) : &mut LockedPool<T0> {
        let v0 = LockedType<T0>{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_with_type<LockedType<T0>, LockedPool<T0>>(&arg0.id, v0)) {
            let v1 = LockedPool<T0>{
                id   : 0x2::object::new(arg1),
                pool : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<LockedType<T0>, LockedPool<T0>>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_object_field::borrow_mut<LockedType<T0>, LockedPool<T0>>(&mut arg0.id, v0)
    }

    fun borrow_single_pool<T0>(arg0: &FinalPool) : &SinglePool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0)) {
            err_pool_type_not_exists();
        };
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0)
    }

    fun borrow_single_pool_mut<T0>(arg0: &mut FinalPool) : &mut SinglePool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0)) {
            err_pool_type_not_exists();
        };
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg0.id, v0)
    }

    public fun deposit<T0>(arg0: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::listing::CoinTypeWhitelist, arg1: &mut FinalPool, arg2: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::GameStatus, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::assert_valid_package_version(arg2);
        0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::assert_game_is_not_ended(arg2, arg3);
        let v0 = 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::listing::assert_coin_type_is_listed<T0>(arg0);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg1.id, v0)) {
            let v1 = SinglePool<T0>{
                id          : 0x2::object::new(arg5),
                is_splitted : false,
                main_pool   : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg1.id, v0, v1);
        };
        let v2 = Deposit<T0>{amount: 0x2::coin::value<T0>(&arg4)};
        0x2::event::emit<Deposit<T0>>(v2);
        0x2::coin::put<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg1.id, v0).main_pool, arg4);
    }

    public fun dev(arg0: &FinalPool) : address {
        arg0.dev
    }

    fun err_pool_already_splitted() {
        abort 0
    }

    fun err_pool_type_not_exists() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FinalPool{
            id      : 0x2::object::new(arg0),
            dev     : 0x2::tx_context::sender(arg0),
            openers : 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::new<address>(1000, arg0),
        };
        0x2::transfer::share_object<FinalPool>(v0);
    }

    public(friend) fun lock<T0>(arg0: &mut FinalPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut borrow_locked_pool_mut<T0>(arg0, arg2).pool, arg1);
    }

    public fun main_pool_balance<T0>(arg0: &FinalPool) : u64 {
        0x2::balance::value<T0>(&borrow_single_pool<T0>(arg0).main_pool)
    }

    public fun openers(arg0: &FinalPool) : &0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::BigVector<address> {
        &arg0.openers
    }

    public fun split_final_pool_after_game_ended<T0>(arg0: &mut FinalPool, arg1: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::GameStatus, arg2: &0x2::clock::Clock, arg3: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::profile_manager::ProfileManager, arg4: &mut 0x2::tx_context::TxContext) {
        0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::assert_valid_package_version(arg1);
        0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::game_status::assert_game_is_ended(arg1, arg2);
        let v0 = arg0.dev;
        let v1 = borrow_single_pool_mut<T0>(arg0);
        if (v1.is_splitted) {
            err_pool_already_splitted();
        };
        let (v2, v3, v4, v5) = 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::splitter::split_final_pool<T0>(&mut v1.main_pool, arg4);
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::config::final_winner_count();
        let v9 = 0x1::option::none<address>();
        let v10 = vector[];
        let v11 = 0x1::option::none<address>();
        let v12 = 0;
        let v13 = &mut arg0.openers;
        while (v12 < v8) {
            let v14 = 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::pop_back<address>(v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, 0x2::coin::value<T0>(&v7) / v8, arg4), v14);
            let (v15, v16) = 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::profile_manager::get_seniors(arg3, v14);
            if (0x1::option::is_none<address>(&v9)) {
                v9 = v15;
                v10 = v16;
                v11 = 0x1::option::some<address>(v14);
            };
            v12 = v12 + 1;
        };
        0x2::coin::join<T0>(&mut v6, v7);
        if (0x1::option::is_some<address>(&v11)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x1::option::destroy_some<address>(v11));
        } else {
            0x2::coin::join<T0>(&mut v6, v4);
        };
        if (0x1::option::is_some<address>(&v9)) {
            0x1::vector::push_back<address>(&mut v10, 0x1::option::destroy_some<address>(v9));
        };
        if (0x1::vector::is_empty<address>(&v10)) {
            0x2::coin::join<T0>(&mut v6, v5);
        } else {
            0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::splitter::divide_coin_to<T0>(v5, v10, arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        borrow_single_pool_mut<T0>(arg0).is_splitted = true;
    }

    // decompiled from Move bytecode v6
}

