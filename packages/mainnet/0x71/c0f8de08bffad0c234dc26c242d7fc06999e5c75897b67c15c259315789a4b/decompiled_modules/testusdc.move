module 0x71c0f8de08bffad0c234dc26c242d7fc06999e5c75897b67c15c259315789a4b::testusdc {
    struct TESTUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: TESTUSDC, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<TESTUSDC>(arg0, decimals(), 0x1::string::utf8(b"testUSDC"), 0x1::string::utf8(b"testUSDC"), 0x1::string::utf8(x"4d61696e6e6574207465737420746f6b656e20e28094206e6f7420666f72207573652e"), 0x1::string::utf8(b"https://placehold.co/256x256/2775ca/ffffff/png?text=testUSDC"), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TESTUSDC>>(0x2::coin_registry::finalize<TESTUSDC>(v0, arg4), 0x2::tx_context::sender(arg4));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<TESTUSDC, T0>(arg1, v1, arg3, arg4);
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_entity<TESTUSDC, T0, T1>(arg1, &v2);
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<TESTUSDC, T0>>(v2, 0x2::tx_context::sender(arg4));
        let TESTUSDC { id: v3 } = arg2;
        0x2::object::delete(v3);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TESTUSDC{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TESTUSDC>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

