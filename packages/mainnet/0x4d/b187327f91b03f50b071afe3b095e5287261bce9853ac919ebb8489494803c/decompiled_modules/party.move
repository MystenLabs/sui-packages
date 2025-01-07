module 0x4db187327f91b03f50b071afe3b095e5287261bce9853ac919ebb8489494803c::party {
    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Reserve has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &mut Reserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = FetchPoolsEvent{pools: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))};
        0x2::event::emit<FetchPoolsEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve{
            id  : 0x2::object::new(arg0),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Reserve>(v0);
    }

    public entry fun withdraw(arg0: &mut Reserve, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui)), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

