module 0x9883987c5eae13419c6df17faca7c1a10d3246b3bc9ab9cb77951b2108a8a58f::party {
    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Reserve<phantom T0> has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<T0>,
    }

    public entry fun deposit<T0>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.sui, arg1);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = FetchPoolsEvent{pools: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve<0x2::sui::SUI>{
            id  : 0x2::object::new(arg0),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Reserve<0x2::sui::SUI>>(v0);
    }

    public entry fun testSwap<T0, T1, T2>(arg0: &mut Reserve<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.sui);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui, v0), arg4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, 0x2::coin::divide_into_n<T0>(&mut v1, 1, arg4), v0, 0, 602365239733426830, true, @0x5062e00485cc6992d6d2cf4356898fde27fa1392444b4d278ef5dd50cc7f49f3, 1783884771618, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun withdraw<T0>(arg0: &mut Reserve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui, 0x2::balance::value<T0>(&arg0.sui)), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

