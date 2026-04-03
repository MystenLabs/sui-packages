module 0xaf2b6a3e443d50ce1470f826e7e54de973bda4daf7f9d48223040a481c940e99::goodvibe {
    struct GoodVibeCoin has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: GoodVibeCoin, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<GoodVibeCoin>(arg0, decimals(), 0x1::string::utf8(b"gvUSD"), 0x1::string::utf8(b"gvUSD"), 0x1::string::utf8(b"GoodVibe branded stablecoin backed by USDC. Yield supports public good projects on the GoodVibe platform."), 0x1::string::utf8(b"https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=200&h=200&fit=crop"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GoodVibeCoin>>(0x2::coin_registry::finalize<GoodVibeCoin>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<GoodVibeCoin, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<GoodVibeCoin, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<GoodVibeCoin, T0>>(v2, 0x2::tx_context::sender(arg4));
        let GoodVibeCoin { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GoodVibeCoin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GoodVibeCoin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

