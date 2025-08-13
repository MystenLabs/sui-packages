module 0x9f3b372ea8110aa71af642d64c1539b351d768b505d4212d80963535bc81214b::cetus_gate_slim {
    struct CetusPoolGuard has store, key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct SwapCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_whitelist(arg0: &SwapCap, arg1: &mut CetusPoolGuard, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.pools, arg2);
    }

    fun contains_addr(arg0: &vector<address>, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(arg0, &arg1);
        v0
    }

    public entry fun delete_whitelist(arg0: &SwapCap, arg1: &mut CetusPoolGuard, arg2: u64, arg3: address) {
        0x1::vector::remove<address>(&mut arg1.pools, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusPoolGuard{
            id    : 0x2::object::new(arg0),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<CetusPoolGuard>(v0);
        let v1 = SwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SwapCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun sqrt_limit_max() : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
    }

    fun sqrt_limit_min() : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
    }

    public fun swap_a2b_checked<T0: store, T1: store>(arg0: &CetusPoolGuard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(contains_addr(&arg0.pools, 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2)), 1001);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&arg3), sqrt_limit_min(), arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public entry fun swap_usdc_to_sui<T0: store, T1: store>(arg0: &CetusPoolGuard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_a2b_checked<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

