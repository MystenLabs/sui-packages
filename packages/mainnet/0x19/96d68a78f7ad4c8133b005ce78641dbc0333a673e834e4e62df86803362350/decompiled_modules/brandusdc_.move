module 0x1996d68a78f7ad4c8133b005ce78641dbc0333a673e834e4e62df86803362350::brandusdc_ {
    struct BRANDUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: BRANDUSDC, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<BRANDUSDC>(arg0, decimals(), 0x1::string::utf8(b"Brand USDC Test"), 0x1::string::utf8(b"Brand USDC Test"), 0x1::string::utf8(x"4d616e75616c207465737420636f696e20410a"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRANDUSDC>>(0x2::coin_registry::finalize<BRANDUSDC>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<BRANDUSDC, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<BRANDUSDC, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<BRANDUSDC, T0>>(v2, 0x2::tx_context::sender(arg4));
        let BRANDUSDC { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BRANDUSDC{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BRANDUSDC>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

