module 0x53b1acd449cbba3717390a7bd119afdc481cc9c7f274257d7ea6748db440392b::pool {
    struct DLMMMarket has store, key {
        id: 0x2::object::UID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        position_keys: 0x2::vec_set::VecSet<0x2::object::ID>,
        positions: 0x2::object_bag::ObjectBag,
    }

    struct DLMMPosition has store, key {
        id: 0x2::object::UID,
        position: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        buffer_assets: 0x53b1acd449cbba3717390a7bd119afdc481cc9c7f274257d7ea6748db440392b::balance_bag::BalanceBag,
        markets: 0x2::object_bag::ObjectBag,
    }

    public fun add_coin<T0: drop, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x53b1acd449cbba3717390a7bd119afdc481cc9c7f274257d7ea6748db440392b::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun add_position<T0: drop, T1, T2>(arg0: &mut Vault<T0>, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_dlmm_market<T1, T2>(arg2);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut v0.position_keys, v1);
        let v2 = DLMMPosition{
            id       : 0x2::object::new(arg2),
            position : arg1,
        };
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut v0.positions, v1, v2);
        0x2::object_bag::add<vector<u8>, DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET", v0);
    }

    public(friend) fun new_dlmm_market<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : DLMMMarket {
        DLMMMarket{
            id            : 0x2::object::new(arg0),
            coin_type_a   : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b   : 0x1::type_name::with_defining_ids<T1>(),
            position_keys : 0x2::vec_set::empty<0x2::object::ID>(),
            positions     : 0x2::object_bag::new(arg0),
        }
    }

    public fun new_vault<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg0),
            coin_type_a   : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b   : 0x1::type_name::with_defining_ids<T1>(),
            buffer_assets : 0x53b1acd449cbba3717390a7bd119afdc481cc9c7f274257d7ea6748db440392b::balance_bag::new_balance_bag(arg0),
            markets       : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

