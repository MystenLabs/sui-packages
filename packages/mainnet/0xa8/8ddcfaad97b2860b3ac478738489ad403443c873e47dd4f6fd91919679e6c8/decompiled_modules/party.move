module 0xa88ddcfaad97b2860b3ac478738489ad403443c873e47dd4f6fd91919679e6c8::party {
    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Reserve<phantom T0> has key {
        id: 0x2::object::UID,
        coins: vector<0x2::coin::Coin<T0>>,
    }

    public entry fun consume<T0>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0.coins));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit<T0>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0.coins, arg1);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = FetchPoolsEvent{pools: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve<0x2::sui::SUI>{
            id    : 0x2::object::new(arg0),
            coins : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Reserve<0x2::sui::SUI>>(v0);
    }

    public entry fun testSwap<T0, T1, T2>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, 0x2::coin::divide_into_n<T0>(arg0, 2, arg4), 100000000, 0, 4295048016, true, @0x5062e00485cc6992d6d2cf4356898fde27fa1392444b4d278ef5dd50cc7f49f3, 1786901767461, arg2, arg3, arg4);
    }

    public entry fun withdraw<T0>(arg0: &mut Reserve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0.coins), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

