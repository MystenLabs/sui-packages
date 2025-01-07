module 0x4f01be5f5168d5f8c92a84e40edc9d757f0de29c945a20c3eb50d821ea3c575::party {
    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Reserve<phantom T0> has key {
        id: 0x2::object::UID,
        coins: vector<0x2::coin::Coin<T0>>,
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
        0x2::transfer::transfer<Reserve<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw<T0>(arg0: &mut Reserve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0.coins), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

