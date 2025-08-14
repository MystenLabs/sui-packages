module 0x8d83ceec7faf87bb3104eb21e2cfa3eb0f63580576eae96558667b5d3280736e::swap_gate_slim {
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

    public fun swap_a2b<T0: store, T1: store>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun swap_to<T0: store, T1: store>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_a2b<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

