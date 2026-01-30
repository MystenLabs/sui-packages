module 0x62a1f6d210c236a404593d38060042d8e2b15def063c5d27acc397940fb253ba::xaum_usdc {
    struct XaumUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<XaumUSDC>(arg0, decimals(), 0x1::string::utf8(b"xaumUSDC"), 0x1::string::utf8(b"xaumUSDC"), 0x1::string::utf8(b"Mint xaumUSD with USDC and earn XAUM"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XaumUSDC>>(0x2::coin_registry::finalize<XaumUSDC>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::default<XaumUSDC, T0>(arg1, v1, arg2, arg3);
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}

