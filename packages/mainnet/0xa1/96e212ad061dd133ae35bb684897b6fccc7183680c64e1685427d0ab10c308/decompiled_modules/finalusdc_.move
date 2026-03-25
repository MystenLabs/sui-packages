module 0xa196e212ad061dd133ae35bb684897b6fccc7183680c64e1685427d0ab10c308::finalusdc_ {
    struct FINALUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: FINALUSDC, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<FINALUSDC>(arg0, decimals(), 0x1::string::utf8(b"finalUSDC"), 0x1::string::utf8(b"finalUSDC"), 0x1::string::utf8(b"This  token is for test use only."), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FINALUSDC>>(0x2::coin_registry::finalize<FINALUSDC>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<FINALUSDC, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<FINALUSDC, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<FINALUSDC, T0>>(v2, 0x2::tx_context::sender(arg4));
        let FINALUSDC { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FINALUSDC{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FINALUSDC>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

