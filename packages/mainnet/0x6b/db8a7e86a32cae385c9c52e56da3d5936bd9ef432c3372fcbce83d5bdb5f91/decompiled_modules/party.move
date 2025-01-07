module 0x6bdb8a7e86a32cae385c9c52e56da3d5936bd9ef432c3372fcbce83d5bdb5f91::party {
    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Reserve<phantom T0> has key {
        id: 0x2::object::UID,
        coins: 0x2::balance::Balance<T0>,
    }

    public entry fun add_whitelist(arg0: &StoreOwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StoreOwnerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v0, arg1);
    }

    public entry fun deposit<T0>(arg0: &StoreOwnerCap, arg1: &mut Reserve<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg1.coins, arg2);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = FetchPoolsEvent{pools: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve<0x2::sui::SUI>{
            id    : 0x2::object::new(arg0),
            coins : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Reserve<0x2::sui::SUI>>(v0);
        let v1 = StoreOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun turbo_swap_a_b<T0, T1, T2>(arg0: &StoreOwnerCap, arg1: &mut Reserve<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coins, arg3, arg8)), arg3, arg4, 4295048016, true, arg5, 1786901767461, arg6, arg7, arg8);
    }

    public entry fun turbo_swap_b_a<T0, T1, T2>(arg0: &StoreOwnerCap, arg1: &mut Reserve<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.coins, arg3, arg8)), arg3, arg4, 79226673515401279992447579055, true, arg5, 1786901767461, arg6, arg7, arg8);
    }

    public entry fun withdraw<T0>(arg0: &StoreOwnerCap, arg1: &mut Reserve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coins, 0x2::balance::value<T0>(&arg1.coins), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

