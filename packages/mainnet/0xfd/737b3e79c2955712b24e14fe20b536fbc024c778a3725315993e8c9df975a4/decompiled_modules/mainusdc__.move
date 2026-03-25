module 0xfd737b3e79c2955712b24e14fe20b536fbc024c778a3725315993e8c9df975a4::mainusdc__ {
    struct MAINUSDCX has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: MAINUSDCX, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<MAINUSDCX>(arg0, decimals(), 0x1::string::utf8(b"mainUSDC"), 0x1::string::utf8(b"mainUSDC"), 0x1::string::utf8(b"This Coin is for Test Use Only."), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MAINUSDCX>>(0x2::coin_registry::finalize<MAINUSDCX>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<MAINUSDCX, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<MAINUSDCX, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<MAINUSDCX, T0>>(v2, 0x2::tx_context::sender(arg4));
        let MAINUSDCX { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MAINUSDCX{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MAINUSDCX>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

