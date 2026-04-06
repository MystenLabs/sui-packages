module 0xcac77d617634e8005c5d467e886a70c9b79c559fcc3c292a5cc8fbaeb59bba8b::goodvibe {
    struct GoodVibeCoin has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: GoodVibeCoin, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<GoodVibeCoin>(arg0, decimals(), 0x1::string::utf8(b"ddUSDC"), 0x1::string::utf8(b"ddUSDC"), 0x1::string::utf8(b"Demo brand stablecoin for local testing: 1:1 intent with USDC backing narrative, used only on devnet for UI and flow validation"), 0x1::string::utf8(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.png"), arg4);
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

