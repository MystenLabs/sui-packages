module 0xdfb54150044f06fdf148197fb87dd3cb39ac2c7501a4b5fd1254f3fd6674582e::coin_registry {
    struct CoinRegistryManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinRegistry has key {
        id: 0x2::object::UID,
        coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
        price_feed_ids: 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::object::ID>,
    }

    public fun add_coin<T0>(arg0: &mut CoinRegistry, arg1: &CoinRegistryManagerCap, arg2: 0x2::object::ID) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.coins, v0);
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.price_feed_ids, &v0)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x2::object::ID>(&mut arg0.price_feed_ids, v0, arg2);
        };
    }

    public fun coins(arg0: &CoinRegistry) : &0x2::vec_set::VecSet<0x1::ascii::String> {
        &arg0.coins
    }

    public fun get_price_feed_id(arg0: &CoinRegistry, arg1: &0x1::ascii::String) : 0x2::object::ID {
        *0x2::vec_map::get<0x1::ascii::String, 0x2::object::ID>(&arg0.price_feed_ids, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinRegistry{
            id             : 0x2::object::new(arg0),
            coins          : 0x2::vec_set::empty<0x1::ascii::String>(),
            price_feed_ids : 0x2::vec_map::empty<0x1::ascii::String, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<CoinRegistry>(v0);
        let v1 = CoinRegistryManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CoinRegistryManagerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_coin<T0>(arg0: &mut CoinRegistry, arg1: &CoinRegistryManagerCap) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.coins, &v0);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x2::object::ID>(&mut arg0.price_feed_ids, &v0);
    }

    // decompiled from Move bytecode v6
}

