module 0x5388e1e5270987a93c82077f1dee369f65631a122859055d7d290cb462e8211b::my_coin___ {
    struct MY_COINXX has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: MY_COINXX, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<MY_COINXX>(arg0, decimals(), 0x1::string::utf8(b"my_coin"), 0x1::string::utf8(b"my_coin"), 0x1::string::utf8(x"4d616e75616c207465737420636f696e20430a"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MY_COINXX>>(0x2::coin_registry::finalize<MY_COINXX>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<MY_COINXX, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<MY_COINXX, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<MY_COINXX, T0>>(v2, 0x2::tx_context::sender(arg4));
        let MY_COINXX { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_COINXX{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MY_COINXX>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

